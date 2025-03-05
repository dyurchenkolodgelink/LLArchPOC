//
//  File.swift
//  iOS_PresentationLayer
//
//  Created by Dmytro Yurchenko on 2025-03-04.
//

import Foundation

public protocol AuthViewModelsFactoryProtocol {
    func makeLoginViewModel() -> LoginViewModel
}

public struct FakeAuthViewModelsFactory: AuthViewModelsFactoryProtocol {
    public func makeLoginViewModel() -> LoginViewModel { .fake() }
}
