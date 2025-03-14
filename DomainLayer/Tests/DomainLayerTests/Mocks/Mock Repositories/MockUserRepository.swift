//
//  File.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-03-14.
//

import Foundation
import TestUtils
import Combine
@testable import DomainLayer

final class MockUserRepository: UserRepositoryProtocol {
    var getMeResult: Result<User, DataError> = .success(makeUser())
    
    func getMe() -> AnyPublisher<DomainLayer.User, DomainLayer.DataError> {
        getMeResult.publisher.eraseToAnyPublisher()
    }
}
