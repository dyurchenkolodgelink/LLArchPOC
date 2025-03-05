//
//  File.swift
//  DataLayer
//
//  Created by Dmytro Yurchenko on 2025-03-04.
//

import Foundation
import DomainLayer

public struct RepositoriesFactory {
    let graphQLClient: GraphQLClientProtocol
    let localStoreRepository: LocalStoreRepositoryProtocol
    let authenticationRepository: AuthenticationRepositoryProtocol
    
    public init(
        projectBundle: Bundle
    ) {
        let localStoreRepository = LocalStoreRepository()
        let network = Network(
            projectBundle: projectBundle,
            getAuthenticationToken: {
                try? localStoreRepository.getValue(for: .authToken)
            }
        )
        let graphQLClient = network.getApolloClient()!
        
        self.authenticationRepository = AuthenticationRepository(graphQLClient: graphQLClient)
        self.graphQLClient = graphQLClient
        self.localStoreRepository = localStoreRepository
    }
}

extension RepositoriesFactory: RepositoriesFactoryProtocol {
    public func makeAuthenticationRepository() -> any DomainLayer.AuthenticationRepositoryProtocol {
        authenticationRepository
    }
    
    public func makeLocalStoreRepository() -> any DomainLayer.LocalStoreRepositoryProtocol {
        localStoreRepository
    }
}
