//
//  GraphQLRepository.swift
//  LodgeLink
//
//  Created by Dmytro Yurchenko on 2023-10-30.
//

import Foundation
import Apollo
import Combine
import DomainLayer

class GraphQLRepository {
    private let graphQLClient: GraphQLClientProtocol
    private let workingQueue: DispatchQueue = .init(label: "com.lodgeLink.PropertiesRepository.workingQueue")
    
    @Atomic([:]) private var activeRequests: [String: CancellableRequest]
        
    init(graphQLClient: GraphQLClientProtocol) {
        self.graphQLClient = graphQLClient
    }
    
    func cancelActive<Operation>(operation: Operation) where Operation: Apollo.GraphQLOperation {
        guard let activeRequest = activeRequests[operation.operationName]
        else { return }
        
        activeRequest.cancel()
        
        activeRequests.removeValue(forKey: operation.operationName)
    }
    
    func removeCompleted<Operation>(operation: Operation) where Operation: Apollo.GraphQLOperation {
        activeRequests.removeValue(forKey: operation.operationName)
    }
    
    typealias QueryMapType<Query: Apollo.GraphQLQuery, ResponseObject, Output> = (
        GraphQLResult<Query.Data>,
        (ResponseObject?) throws -> ResponseObject
    ) throws -> Output
    
    @discardableResult
    func execute<Query, ResponseObject, Output>(
        query: Query,
        map: @escaping QueryMapType<Query, ResponseObject, Output>
    ) -> AnyPublisher<Output, DataError> where Query : Apollo.GraphQLQuery {
        
        cancelActive(operation: query)
        
        return Future<Output, DataError> { [unowned self] promise in
           let request = ActiveRequest(
                operation: query,
                cancellable: graphQLClient.execute(
                    query: query,
                    queue: workingQueue
                ) { [weak self] result in
                    
                    self?.removeCompleted(operation: query)
                    
                    switch result {
                    case let .failure(error):
                        promise(.failure(.networkError(error)))
                        
                    case let .success(response):
                        let outputExtractor: (ResponseObject?) throws -> ResponseObject = { response in
                            if let response {
                                return response
                            } else {
                                throw ResponseError.noResponse
                            }
                        }
                        
                        if let responseError = response.errors?.first {
                            return promise(.failure(.responseError(responseError)))
                        }
                        
                        do {
                            
                            let domainModel: Output = try map(response, outputExtractor)
                            
                            promise(.success(domainModel))
                        } catch {
                            promise(.failure(.parsingError(error)))
                        }
                    }
                }
            )
            
            activeRequests[query.operationName] = request
        }
        .first()
        .eraseToAnyPublisher()
    }
    
    typealias MutationMapType<Mutation: Apollo.GraphQLMutation, ResponseObject, Output> = (
        GraphQLResult<Mutation.Data>,
        (ResponseObject?) throws -> ResponseObject
    ) throws -> Output
    
    @discardableResult
    func execute<Mutation, ResponseObject, Output>(
        mutation: Mutation,
        map: @escaping MutationMapType<Mutation, ResponseObject, Output>
    ) -> AnyPublisher<Output, DataError> where Mutation : Apollo.GraphQLMutation {
        
        cancelActive(operation: mutation)
        
        return Future<Output, DataError> { [unowned self] promise in
            let request = ActiveRequest(
                operation: mutation,
                cancellable: graphQLClient.execute(
                    mutation: mutation,
                    queue: workingQueue
                ) { [weak self] result in
                    
                    self?.removeCompleted(operation: mutation)
                    
                    switch result {
                    case let .failure(error):
                        promise(.failure(.networkError(error)))
                        
                    case let .success(response):
                        let outputExtractor: (ResponseObject?) throws -> ResponseObject = { response in
                            if let response {
                                return response
                            } else {
                                throw ResponseError.noResponse
                            }
                        }
                        
                        if let responseError = response.errors?.first {
                            return promise(.failure(.responseError(responseError)))
                        }
                        
                        do {
                            let domainModel: Output = try map(response, outputExtractor)
                            
                            promise(.success(domainModel))
                        } catch {
                            promise(.failure(.parsingError(error)))
                        }
                    }
                }
            )
            
            activeRequests[mutation.operationName] = request
        }
        .first()
        .eraseToAnyPublisher()
    }
    
    func unwrap<T>(response: T?) throws -> T {
        if let response {
            return response
        } else {
            throw DataError.parsingError(ResponseError.noResponse)
        }
    }
}
