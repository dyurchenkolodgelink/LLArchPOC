//
//  File.swift
//  iOS_PresentationLayer
//
//  Created by Dmytro Yurchenko on 2025-03-04.
//

import Foundation
import DomainLayer

public final class AppRouterViewModel: ViewModel {
    private let useCases: UseCases
    
    @Published var authentication: Authentication = .unauthenticated
    
    init(
        useCases: UseCases,
        sideCar: ViewModelSideCar
    ) throws {
        self.useCases = useCases
        
        try super.init(requiredPermissions: [], sideCar: sideCar)
        
        useCases.subscribeForAuthenticationChangesUseCase.execute()
            .receive(on: OperationQueue.main)
            .assign(to: &$authentication)
    }
}

extension AppRouterViewModel {
    struct UseCases: Fakeable {
        let subscribeForAuthenticationChangesUseCase: SubscribeForAuthenticationChangesUseCaseProtocol
        
        static func fake() -> UseCases {
            UseCases(
                subscribeForAuthenticationChangesUseCase: FakeSubscribeForAuthenticationChangesUseCase()
            )
        }
    }
}

extension AppRouterViewModel {
    public static func fake() -> AppRouterViewModel {
        try! AppRouterViewModel(
            useCases: .fake(),
            sideCar: .fake()
        )
    }
}
