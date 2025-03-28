//
//  File.swift
//  iOS_PresentationLayer
//
//  Created by Dmytro Yurchenko on 2025-03-28.
//

import Foundation
import DomainLayer
import Combine
@testable import iOS_PresentationLayer

final class MockSignInUseCase: MockedUseCaseWithInput<SignInInput, User, AuthenticationError>, SignInUseCaseProtocol {}
