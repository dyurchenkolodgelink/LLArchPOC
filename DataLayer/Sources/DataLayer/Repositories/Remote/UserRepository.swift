//
//  File.swift
//  DataLayer
//
//  Created by Dmytro Yurchenko on 2025-03-05.
//

import Foundation
import DomainLayer
import Combine

final class UserRepository: GraphQLRepository, UserRepositoryProtocol {
    func getMe() -> AnyPublisher<DomainLayer.User, DomainLayer.DataError> {
        let query = MeQuery()
        
        return execute(query: query) { response, extractOutput in
            let userResponse = try extractOutput(response.data?.me)
            
            return try userResponse.toDomain()
        }
    }
}
