//
//  BaseCoordinator.swift
//  LodgeLink
//
//  Created by Dmytro Yurchenko on 2024-01-21.
//

import SwiftUI
import Combine
import DomainLayer

public class BaseCoordinator<Item>: ObservableObject, Coordinator where Item: CoordinatorFlowItem {
    @Published private(set) var path: [Item] = []
    @Published private(set) var presentedItem: Item?
    @Published private(set) var bottomSheetItem: Item?
    @Published private(set) var popoverItem: Item?
    
    @Published private var shouldBeDismissed: Bool = false
    
    let sideCar: CoordinatorSideCar
    private(set) var requiredPermissions: Set<OrgPermission> = []
    let initialFlowElement: Item
    
    final var permissions: Set<OrgPermission> {
        []//sideCar.applicationSessionStore.authentication.permissions
    }
    var cancellableSet: Set<AnyCancellable> = []
    var pathBinding: Binding<[Item]>{
        .init(
            get: { [unowned self] in path },
            set: { [unowned self] in path = $0 }
        )
    }
    var presentedItemBinding: Binding<Item?> {
        .init(
            get: { [unowned self] in presentedItem },
            set: { [unowned self] in presentedItem = $0 }
        )
    }
    var bottomSheetItemBinding: Binding<Item?> {
        .init(
            get: { [unowned self] in bottomSheetItem },
            set: { [unowned self] in bottomSheetItem = $0 }
        )
    }
    var popoverItemBinding: Binding<Item?> {
        .init(
            get: { [unowned self] in popoverItem },
            set: { [unowned self] in popoverItem = $0 }
        )
    }
    
    init(
        initialFlowElement: Item,
        sideCar: CoordinatorSideCar
    ) {
        self.initialFlowElement = initialFlowElement
        self.sideCar = sideCar
        
        $presentedItem
            .removeDuplicates()
            .dropFirst()
            .filter { $0 == nil }
            .receive(on: OperationQueue.main)
            .sink { [unowned self] _ in
                path.forEach { $0.viewModel.refresh() }
            }
            .store(in: &cancellableSet)
        
        $bottomSheetItem
            .removeDuplicates()
            .dropFirst()
            .filter { $0 == nil }
            .receive(on: OperationQueue.main)
            .sink { [unowned self] _ in
                path.forEach { $0.viewModel.refresh() }
            }
            .store(in: &cancellableSet)
    }
    
    func tryToMakeRouterView(permissions: Set<OrgPermission>) throws -> AnyView {
        if !requiredPermissions.satisfied(by: permissions) {
            throw AccessError.noPermission
        } else {
            return makeRouterView()
        }
    }
    
    @ViewBuilder
    func makeRouterView() -> AnyView {
        NavigationRouterView(
            coordinator: self,
            shouldBeDismissed: Binding(
                get: { [unowned self] in shouldBeDismissed },
                set: { [unowned self] in shouldBeDismissed = $0 }
            )
        )
        .eraseToAnyView()
    }
    
    
    @ViewBuilder func getNextFlowItemView(for item: Item) -> AnyView {
        EmptyView()
            .eraseToAnyView()
    }
    
    func dismiss() {
        shouldBeDismissed = true
        
        bottomSheetItem = nil
        popoverItem = nil
    }
    
    func pop() {
        guard !path.isEmpty else { return }
        
        path.removeLast()
    }
}

extension BaseCoordinator {
    final func push(_ item: Item) {
        guard item.requiredPermissions.satisfied(by: permissions)
        else { return }
        
        path.append(item)
    }
    
    final func present(_ item: Item) {
        guard item.requiredPermissions.satisfied(by: permissions)
        else { return }
        
        presentedItem = item
    }
    
    final func presentAsBottomSheet(_ item: Item) {
        guard item.requiredPermissions.satisfied(by: permissions)
        else { return }
        
        bottomSheetItem = item
    }
    
    final func presentPopover(_ item: Item) {
        guard item.requiredPermissions.satisfied(by: permissions)
        else { return }
        
        popoverItem = item
    }
    
    final func setPath(_ items: [Item]) {
        guard items.allSatisfy({ $0.requiredPermissions.satisfied(by: permissions) })
        else { return }
        
        path = items
    }
    
    final func erasePath() {
        setPath([])
    }
}

extension BaseCoordinator: CoordinatorFlowItem {
    public var id: UUID { initialFlowElement.id }
    public var viewModel: any ViewModel { initialFlowElement.viewModel }
}

extension BaseCoordinator: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(viewModel)
    }
}

extension BaseCoordinator: Equatable {
    public static func == (lhs: BaseCoordinator, rhs: BaseCoordinator) -> Bool {
        lhs.id == rhs.id && lhs.viewModel == rhs.viewModel
    }
}
