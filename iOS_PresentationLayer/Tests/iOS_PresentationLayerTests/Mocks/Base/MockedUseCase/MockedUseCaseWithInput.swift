//
//  MockedUseCaseWithInput.swift
//  LodgeLinkTests
//
//  Created by Dmytro Yurchenko on 2024-09-10.
//

import Foundation
import Combine

class MockedUseCaseWithInput<Input, Output, Failure: Error>: MockedUseCase<Output, Failure> {
    func execute(_ input: Input) -> AnyPublisher<Output, Failure> {
        isExecuteInvoked = true
        
        return result.getMockedPublisher()
    }
}
