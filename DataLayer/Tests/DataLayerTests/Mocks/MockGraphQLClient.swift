//
//  File.swift
//  DataLayer
//
//  Created by Dmytro Yurchenko on 2025-03-11.
//

import Foundation
import Apollo
import DomainLayer
@testable import DataLayer

struct MockGraphQLQueryClient<Q: Apollo.GraphQLQuery>: GraphQLClientProtocol {
    var mockQueryResult: Result<GraphQLResult<Q.Data>, Error> = .failure(ExecutionError.withMessage("Initial error"))
    
    func execute<Query>(
        query: Query,
        queue: DispatchQueue,
        resultHandler: Apollo.GraphQLResultHandler<Query.Data>?
    ) -> any Apollo.Cancellable where Query: Apollo.GraphQLQuery {
        
        let mockCancellable = MockCancellable()
        
        switch mockQueryResult {
        case .success(let data):
            resultHandler?(.success(data as! GraphQLResult<Query.Data>))
        case .failure(let error):
            resultHandler?(.failure(error))
        }
        
        return mockCancellable
    }
    
    func execute<Mutation>(
        mutation: Mutation,
        queue: DispatchQueue,
        resultHandler: Apollo.GraphQLResultHandler<Mutation.Data>?
    ) -> any Apollo.Cancellable where Mutation: Apollo.GraphQLMutation {
        let mockCancellable = MockCancellable()
        
        resultHandler?(.failure(ExecutionError.withMessage("Mutation shouldn't be executed")))
        
        return mockCancellable
    }
}

struct MockGraphQLMutationClient<M: Apollo.GraphQLMutation>: GraphQLClientProtocol {
    var mockMutationResult: Result<GraphQLResult<M.Data>, Error> = .failure(ExecutionError.withMessage("Initial error"))
    
    func execute<Query>(
        query: Query,
        queue: DispatchQueue,
        resultHandler: Apollo.GraphQLResultHandler<Query.Data>?
    ) -> any Apollo.Cancellable where Query: Apollo.GraphQLQuery {
        
        let mockCancellable = MockCancellable()
        
        resultHandler?(.failure(ExecutionError.withMessage("Mutation shouldn't be executed")))
        
        return mockCancellable
    }
    
    func execute<Mutation>(
        mutation: Mutation,
        queue: DispatchQueue,
        resultHandler: Apollo.GraphQLResultHandler<Mutation.Data>?
    ) -> any Apollo.Cancellable where Mutation: Apollo.GraphQLMutation {
        let mockCancellable = MockCancellable()
        
        switch mockMutationResult {
        case .success(let data):
            resultHandler?(.success(data as! GraphQLResult<Mutation.Data>))
        case .failure(let error):
            resultHandler?(.failure(error))
        }
        
        return mockCancellable
    }
}

class MockCancellable: Apollo.Cancellable {
    func cancel() {}
}

