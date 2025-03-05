//
//  File.swift
//  iOS_PresentationLayer
//
//  Created by Dmytro Yurchenko on 2025-03-04.
//

import Foundation

public protocol HomeViewModelsFactoryProtocol {
    func makeWelcomeViewModel() -> WelcomeViewModel
}

extension ViewModelsFactory: HomeViewModelsFactoryProtocol {}

public struct FakeHomeViewModelsFactory: HomeViewModelsFactoryProtocol {
    public func makeWelcomeViewModel() -> WelcomeViewModel { .fake() }
}
