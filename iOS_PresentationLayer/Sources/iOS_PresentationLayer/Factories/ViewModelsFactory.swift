//
//  File.swift
//  iOS_PresentationLayer
//
//  Created by Dmytro Yurchenko on 2025-03-04.
//

import Foundation
import DomainLayer

protocol ViewModelsFactoryProtocol: AuthViewModelsFactoryProtocol, HomeViewModelsFactoryProtocol {
    func makeAppRouterViewModel() -> AppRouterViewModel
}

struct ViewModelsFactory {
    let sideCar = ViewModelSideCar()
    let useCasesFactory: UseCasesFactoryProtocol
    
    init(
        useCasesFactory: UseCasesFactoryProtocol
    ) {
        self.useCasesFactory = useCasesFactory
    }
}

extension ViewModelsFactory: ViewModelsFactoryProtocol {
    func makeAppRouterViewModel() -> AppRouterViewModel {
        let useCases = AppRouterViewModel.UseCases(
            subscribeForAuthenticationChangesUseCase: useCasesFactory.makeSubscribeForAuthenticationChangesUseCase()
        )
        
        return try! AppRouterViewModel(
            useCases: useCases,
            sideCar: sideCar
        )
    }
    
    func makeLoginViewModel() -> LoginViewModel {
        let useCases = LoginViewModel.UseCases(
            signInUseCase: useCasesFactory.makeSignInUseCase()
        )
        
        return try! LoginViewModel(
            useCases: useCases,
            sideCar: sideCar
        )
    }
    
    func makeWelcomeViewModel() -> WelcomeViewModel {
        let useCases = WelcomeViewModel.UseCases(
            signOutUseCase: useCasesFactory.makeSignOutUseCase(),
            getMeUseCase: useCasesFactory.makeGetMeUseCase()
        )
        
        return try! WelcomeViewModel(
            useCases: useCases,
            sideCar: sideCar
        )
    }
}

struct FakeViewModelsFactory: ViewModelsFactoryProtocol {
    func makeAppRouterViewModel() -> AppRouterViewModel { .fake() }
    func makeLoginViewModel() -> LoginViewModel { .fake() }
    func makeWelcomeViewModel() -> WelcomeViewModel { .fake() }
}
