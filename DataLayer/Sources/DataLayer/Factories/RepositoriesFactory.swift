//
//  File.swift
//  DataLayer
//
//  Created by Dmytro Yurchenko on 2025-03-04.
//

import Foundation
import DomainLayer

public struct RepositoriesFactory: RepositoriesFactoryProtocol {
    let graphQLClient: GraphQLClientProtocol
    
    public func makeAuthenticationRepository() -> any DomainLayer.AuthenticationRepositoryProtocol {
        AuthenticationRepository(graphQLClient: graphQLClient)
    }
    
    public func makeLocalStoreRepository() -> any DomainLayer.LocalStoreRepositoryProtocol {
        LocalStoreRepository()
    }
}
