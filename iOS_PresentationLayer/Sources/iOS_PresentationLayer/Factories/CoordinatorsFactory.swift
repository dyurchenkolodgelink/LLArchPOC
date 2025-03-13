//
//  File.swift
//  iOS_PresentationLayer
//
//  Created by Dmytro Yurchenko on 2025-03-04.
//

import Foundation
import DomainLayer

public protocol CoordinatorsFactoryProtocol {
    func makeAppCoordinator() -> AppCoordinator
    func makeAuthCoordinator() -> AuthCoordinator
    func makeMainCoordinator() -> MainCoordinator
}

public struct CoordinatorsFactory {
    private let sideCar: CoordinatorSideCar
    private let viewModelsFactory: ViewModelsFactoryProtocol
    
    public init(
        sideCar: CoordinatorSideCar,
        useCasesFactory: UseCasesFactoryProtocol
    ) {
        self.sideCar = sideCar
        self.viewModelsFactory = ViewModelsFactory(useCasesFactory: useCasesFactory)
    }
}

extension CoordinatorsFactory: CoordinatorsFactoryProtocol {
    public func makeAppCoordinator() -> AppCoordinator {
        AppCoordinator(
            coordinatorsFactory: self,
            viewModelsFactory: viewModelsFactory,
            sideCar: sideCar
        )
    }
    
    public func makeAuthCoordinator() -> AuthCoordinator {
        AuthCoordinator(
            authViewModelsFactory: viewModelsFactory,
            sideCar: sideCar
        )
    }
    
    public func makeMainCoordinator() -> MainCoordinator {
        MainCoordinator(
            homeViewModelsFactory: viewModelsFactory,
            sideCar: sideCar
        )
    }
}

public struct FakeCoordinatorsFactory: CoordinatorsFactoryProtocol {
    public func makeAppCoordinator() -> AppCoordinator { .fake() }
    public func makeAuthCoordinator() -> AuthCoordinator { .fake() }
    public func makeMainCoordinator() -> MainCoordinator { .fake() }
}
