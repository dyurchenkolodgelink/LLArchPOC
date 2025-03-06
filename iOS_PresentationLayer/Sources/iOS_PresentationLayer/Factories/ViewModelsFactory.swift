//
//  File.swift
//  iOS_PresentationLayer
//
//  Created by Dmytro Yurchenko on 2025-03-04.
//

import Foundation
import DomainLayer

public protocol ViewModelsFactoryProtocol: AuthViewModelsFactoryProtocol, HomeViewModelsFactoryProtocol {
    func makeAppRouterViewModel() -> AppRouterViewModel
}

public struct ViewModelsFactory {
    let sideCar = ViewModelSideCar()
    let useCasesFactory: UseCasesFactoryProtocol
    
    public init(
        useCasesFactory: UseCasesFactoryProtocol
    ) {
        self.useCasesFactory = useCasesFactory
    }
}

extension ViewModelsFactory: ViewModelsFactoryProtocol {
    public func makeAppRouterViewModel() -> AppRouterViewModel {
        let useCases = AppRouterViewModel.UseCases(
            subscribeForAuthenticationChangesUseCase: useCasesFactory.makeSubscribeForAuthenticationChangesUseCase()
        )
        
        return try! AppRouterViewModel(
            useCases: useCases,
            sideCar: sideCar
        )
    }
    
    public func makeLoginViewModel() -> LoginViewModel {
        let useCases = LoginViewModel.UseCases(
            signInUseCase: useCasesFactory.makeSignInUseCase()
        )
        
        return try! LoginViewModel(
            useCases: useCases,
            sideCar: sideCar
        )
    }
    
    public func makeWelcomeViewModel() -> WelcomeViewModel {
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

public struct FakeViewModelsFactory: ViewModelsFactoryProtocol {
    public func makeAppRouterViewModel() -> AppRouterViewModel { .fake() }
    public func makeLoginViewModel() -> LoginViewModel { .fake() }
    public func makeWelcomeViewModel() -> WelcomeViewModel { .fake() }
}
