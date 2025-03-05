//
//  File.swift
//  iOS_PresentationLayer
//
//  Created by Dmytro Yurchenko on 2025-03-04.
//

import Foundation
import SwiftUI
import DomainLayer

public final class MainCoordinator: BaseCoordinator<MainCoordinator.FlowItem> {
    private let homeViewModelsFactory: HomeViewModelsFactoryProtocol
    
    init(
        homeViewModelsFactory: HomeViewModelsFactoryProtocol,
        sideCar: CoordinatorSideCar
    ) {
        self.homeViewModelsFactory = homeViewModelsFactory
        
        let welcomeViewModel = homeViewModelsFactory.makeWelcomeViewModel()
        
        super.init(
            initialFlowElement: .welcome(viewModel: welcomeViewModel),
            sideCar: sideCar
        )
    }
    
    @ViewBuilder override func getNextFlowItemView(for item: FlowItem) -> AnyView {
        switch item {
        case .welcome(let viewModel):
            WelcomeView(viewModel: viewModel)
                .eraseToAnyView()
        }
    }
}

extension MainCoordinator {
    public enum FlowItem: CoordinatorFlowItem {
        case welcome(viewModel: WelcomeViewModel)
        
        public var viewModel: any ViewModel {
            switch self {
            case .welcome(let viewModel): viewModel
            }
        }
    }
}

extension MainCoordinator: Fakeable {
    public static func fake() -> MainCoordinator {
        MainCoordinator(
            homeViewModelsFactory: FakeHomeViewModelsFactory(),
            sideCar: .fake()
        )
    }
}
