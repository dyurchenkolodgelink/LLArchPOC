//
//  GraphQLClientProtocol.swift
//  LodgeLink
//
//  Created by Dmytro Yurchenko on 2023-10-30.
//

import Foundation
import Apollo

protocol GraphQLClientProtocol {
    @discardableResult
    func execute<Query>(
        query: Query,
        queue: DispatchQueue,
        resultHandler: GraphQLResultHandler<Query.Data>?
    ) -> Apollo.Cancellable where Query: GraphQLQuery
    
    @discardableResult
    func execute<Query>(
        query: Query,
        queue: DispatchQueue
    ) -> Apollo.Cancellable where Query: GraphQLQuery
    
    @discardableResult
    func execute<Mutation>(
        mutation: Mutation,
        queue: DispatchQueue,
        resultHandler: GraphQLResultHandler<Mutation.Data>?
    ) -> Apollo.Cancellable where Mutation: GraphQLMutation
    
    @discardableResult
    func execute<Mutation>(
        mutation: Mutation,
        queue: DispatchQueue
    ) -> Apollo.Cancellable where Mutation: GraphQLMutation
}

extension GraphQLClientProtocol {
    @discardableResult
    func execute<Query>(query: Query, queue: DispatchQueue) -> Apollo.Cancellable where Query: GraphQLQuery {
        execute(query: query, queue: queue, resultHandler: nil)
    }
    
    @discardableResult
    func execute<Mutation>(
        mutation: Mutation,
        queue: DispatchQueue
    ) -> Apollo.Cancellable where Mutation: GraphQLMutation {
        execute(mutation: mutation, queue: queue, resultHandler: nil)
    }
}

extension ApolloClient: GraphQLClientProtocol {
    func execute<Mutation>(
        mutation: Mutation,
        queue: DispatchQueue,
        resultHandler: Apollo.GraphQLResultHandler<Mutation.Data>?
    ) -> Apollo.Cancellable where Mutation : Apollo.GraphQLMutation {
        perform(
            mutation: mutation,
            queue: queue,
            resultHandler: resultHandler
        )
    }
    
    func execute<Query>(
        query: Query,
        queue: DispatchQueue,
        resultHandler: Apollo.GraphQLResultHandler<Query.Data>?
    ) -> Apollo.Cancellable where Query : Apollo.GraphQLQuery {
        fetch(
            query: query,
            cachePolicy: .fetchIgnoringCacheCompletely,
            queue: queue,
            resultHandler: resultHandler
        )
    }
}
