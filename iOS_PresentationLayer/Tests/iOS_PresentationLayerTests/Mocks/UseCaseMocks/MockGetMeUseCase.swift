//
//  File.swift
//  iOS_PresentationLayer
//
//  Created by Dmytro Yurchenko on 2025-03-28.
//

import Foundation
import Combine
import DomainLayer

final class MockGetMeUseCase: MockedUseCaseWithoutInput<User, DataError>, GetMeUseCaseProtocol {}
