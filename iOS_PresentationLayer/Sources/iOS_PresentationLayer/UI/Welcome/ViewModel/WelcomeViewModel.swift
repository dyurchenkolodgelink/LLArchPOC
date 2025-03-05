//
// NameViewModel.swift
// iOS_PresentationLayer
//
// Created by NameViewModel on 2025-03-04
//

import Foundation
import Combine
import DomainLayer

public final class WelcomeViewModel: ViewModel {
    private let useCases: UseCases
    
    init(
        useCases: UseCases,
        sideCar: ViewModelSideCar
    ) throws {
        self.useCases = useCases
        
        try super.init(requiredPermissions: [], sideCar: sideCar)
    }
}

extension WelcomeViewModel {
    func signOut() {
        useCases.signOutUseCase.execute()
    }
}

extension WelcomeViewModel {
    struct UseCases: Fakeable {
        let signOutUseCase: SignOutUseCaseProtocol
    
        static func fake() -> UseCases {
            UseCases(
                signOutUseCase: FakeSignOutUseCase()
            )
        }
    }
}

extension WelcomeViewModel {
    public static func fake() -> WelcomeViewModel {
        try! WelcomeViewModel(
            useCases: .fake(),
            sideCar: .fake()
        )
    }
}
