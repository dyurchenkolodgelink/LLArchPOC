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
    
    @Published var user: User?
    
    init(
        useCases: UseCases,
        sideCar: ViewModelSideCar
    ) throws {
        self.useCases = useCases
        
        try super.init(requiredPermissions: [], sideCar: sideCar)
    }
    
    override func onViewLoaded() {
        super.onViewLoaded()
        
        populateUser()
    }
}

extension WelcomeViewModel {
    func signOut() {
        useCases.signOutUseCase.execute()
    }
}

private extension WelcomeViewModel {
    func populateUser() {
        isLoading = true
        
        useCases.getMeUseCase.execute()
            .delay(for: 3.0, scheduler: DispatchQueue.global())
            .receive(on: OperationQueue.main)
            .sink(
                receiveCompletion: { [unowned self] in
                    isLoading = false
                    
                    guard case .failure(let error) = $0
                    else { return }
                    
                    errorMessage = error.localizedDescription
                },
                receiveValue: { [unowned self] user in
                    self.user = user
                }
            )
            .store(in: &cancellableSet)
    }
}

extension WelcomeViewModel {
    struct UseCases: Fakeable {
        let signOutUseCase: SignOutUseCaseProtocol
        let getMeUseCase: GetMeUseCaseProtocol
    
        static func fake() -> UseCases {
            UseCases(
                signOutUseCase: FakeSignOutUseCase(),
                getMeUseCase: FakeGetMeUseCase()
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
