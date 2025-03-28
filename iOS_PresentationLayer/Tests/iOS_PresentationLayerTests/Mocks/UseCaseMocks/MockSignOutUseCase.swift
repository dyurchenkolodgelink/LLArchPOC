//
//  File.swift
//  iOS_PresentationLayer
//
//  Created by Dmytro Yurchenko on 2025-03-28.
//

import Foundation
import Combine
import DomainLayer

final class MockSignOutUseCase: SignOutUseCaseProtocol {
    private(set) var isExecuted = false
    
    func execute() {
        isExecuted = true
    }
}
