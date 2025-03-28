//
//  MockedUseCaseWithoutInput.swift
//  LodgeLinkTests
//
//  Created by Dmytro Yurchenko on 2024-09-10.
//

import Foundation
import Combine

class MockedUseCaseWithoutInput<Output, Failure: Error>: MockedUseCase<Output, Failure> {
    func execute() -> AnyPublisher<Output, Failure> {
        isExecuteInvoked = true
        
        return result.getMockedPublisher()
    }
}
