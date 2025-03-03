//
// LoginViewModel.swift
// iOS_PresentationLayer
//
// Created by NameViewModel on 2025-02-03
//

import Foundation
import Combine
import DomainLayer

final class LoginViewModel: ViewModel {
    private let useCases: UseCases
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    init(useCases: UseCases) {
        self.useCases = useCases
    }
}

extension LoginViewModel {
    func login() {
        isLoading = true
        
        let input = SignInInput(
            email: email,
            password: password
        )
        useCases.signInUseCase.execute(input)
            .receive(on: OperationQueue.main)
            .sink(
                receiveCompletion: { [unowned self] in
                    isLoading = false
                    
                    guard case .failure(let error) = $0
                    else { return }
                    
                    errorMessage = error.localizedDescription
                },
                receiveValue: { _ in
                    
                }
            )
            .store(in: &cancellableSet)
    }
}

extension LoginViewModel {
    struct UseCases: Fakeable {
        let signInUseCase: SignInUseCaseProtocol
        
        static func fake() -> UseCases {
            UseCases(
                signInUseCase: FakeSignInUseCase()
            )
        }
    }
}

extension LoginViewModel {
    static func fake() -> LoginViewModel {
        LoginViewModel(useCases: .fake())
    }
}
