//
//  AppCoordinator.swift
//  LodgeLink
//
//  Created by Dmytro Yurchenko on 2024-01-20.
//

import SwiftUI
import Combine
import DomainLayer

public final class AppCoordinator: BaseCoordinator<AppCoordinator.FlowItem> {
    private let coordinatorsFactory: CoordinatorsFactoryProtocol
    private let appRouterViewModel: AppRouterViewModel
    
    @Published var selectedFlowItem: FlowItem
    
    init(
        coordinatorsFactory: CoordinatorsFactoryProtocol,
        viewModelsFactory: ViewModelsFactoryProtocol,
        sideCar: CoordinatorSideCar
    ) {
        self.coordinatorsFactory = coordinatorsFactory
        self.appRouterViewModel = viewModelsFactory.makeAppRouterViewModel()
        
        let selectedItem = FlowItem.authCoordinator(
            coordinator: coordinatorsFactory.makeAuthCoordinator()
        )
        
        self.selectedFlowItem = selectedItem
        
        super.init(
            initialFlowElement: selectedItem,
            sideCar: sideCar
        )
    }
    
    @ViewBuilder override public func makeRouterView() -> AnyView {
        AppRouterView(
            coordinator: self,
            viewModel: appRouterViewModel
        )
        .eraseToAnyView()
    }
    
    @ViewBuilder override func getNextFlowItemView(for item: FlowItem) -> AnyView {
        let view: some View = switch item {
        case let .mainCoordinator(coordinator):
            coordinator.makeRouterView()
            
        case let .authCoordinator(coordinator):
            coordinator.makeRouterView()
        }
        
        view.eraseToAnyView()
    }
    
    func moveToMainCoordinator() {
        let mainCoordinator = coordinatorsFactory.makeMainCoordinator()
        
        selectedFlowItem = .mainCoordinator(coordinator: mainCoordinator)
    }
    
    func moveToAuthCoordinator() {
        let authCoordinator = coordinatorsFactory.makeAuthCoordinator()
        
        selectedFlowItem = .authCoordinator(coordinator: authCoordinator)
    }
}

extension AppCoordinator {
    public enum FlowItem: CoordinatorFlowItem {
        case mainCoordinator(coordinator: MainCoordinator)
        case authCoordinator(coordinator: AuthCoordinator)
        
        public var viewModel: any ViewModel {
            switch self {
            case let .mainCoordinator(coordinator): coordinator.viewModel
            case let .authCoordinator(coordinator): coordinator.viewModel
            }
        }
    }
}

extension AppCoordinator: Fakeable {
    public static func fake() -> AppCoordinator {
        AppCoordinator(
            coordinatorsFactory: FakeCoordinatorsFactory(),
            viewModelsFactory: FakeViewModelsFactory(),
            sideCar: .fake()
        )
    }
}
