//
//  AuthCoordinator.swift
//  LodgeLink
//
//  Created by Dmytro Yurchenko on 2024-01-21.
//

import Foundation
import SwiftUI
import DomainLayer

public final class AuthCoordinator: BaseCoordinator<AuthCoordinator.FlowItem> {
    let authViewModelsFactory: AuthViewModelsFactoryProtocol
    
    init(
        authViewModelsFactory: AuthViewModelsFactoryProtocol,
        sideCar: CoordinatorSideCar
    ) {
        self.authViewModelsFactory = authViewModelsFactory
        let viewModel = authViewModelsFactory.makeLoginViewModel()

        super.init(
            initialFlowElement: .login(viewModel: viewModel),
            sideCar: sideCar
        )
    }
    
    @ViewBuilder override func getNextFlowItemView(for item: FlowItem) -> AnyView {
        switch item {
        case .login(let viewModel):
            LoginView(viewModel: viewModel)
                .eraseToAnyView()
        }
    }
}

public extension AuthCoordinator {
    enum FlowItem: CoordinatorFlowItem {
        case login(viewModel: LoginViewModel)
        
        public var viewModel: any ViewModel {
            switch self {
            case .login(let viewModel): viewModel
            }
        }
    }
}

extension AuthCoordinator: Fakeable {
    public static func fake() -> AuthCoordinator {
        AuthCoordinator(
            authViewModelsFactory: FakeAuthViewModelsFactory(),
            sideCar: .fake()
        )
    }
}
