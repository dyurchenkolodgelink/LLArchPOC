//
//  ApplicationDependencyContainer.swift
//  LLArchPOC
//
//  Created by Dmytro Yurchenko on 2025-03-05.
//

import Foundation
import DomainLayer
import DataLayer
import iOS_PresentationLayer

struct ApplicationDependencyContainer {
    let coordinatorsFactory: CoordinatorsFactoryProtocol
    
    init() {
        let repositoriesFactory: RepositoriesFactoryProtocol = RepositoriesFactory(projectBundle: Bundle.main)
        let useCasesFactory: UseCasesFactoryProtocol = UseCasesFactory(repositoriesFactory: repositoriesFactory)
        let coordinatorSideCar = CoordinatorSideCar()
        let coordinatorsFactory = CoordinatorsFactory(
            sideCar: coordinatorSideCar,
            useCasesFactory: useCasesFactory
        )
        
        self.coordinatorsFactory = coordinatorsFactory
    }
}
