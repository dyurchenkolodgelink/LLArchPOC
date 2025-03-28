//
//  WelcomeViewModelTests.swift
//  iOS_PresentationLayer
//
//  Created by Dmytro Yurchenko on 2025-03-28.
//

import XCTest
import TestUtils
import DomainLayer
@testable import iOS_PresentationLayer

final class WelcomeViewModelTests: XCTestCase {
    private let getMeUseCase = MockGetMeUseCase()
    private let signOutUseCase = MockSignOutUseCase()
    
    func test_isLoading_isFalse_byDefault() async throws {
        let sut = try makeSut()
        
        XCTAssertFalse(sut.isLoading)
    }
    
    func test_isLoading_isTrue_when_onViewLoaded_isInvoked() async throws {
        let sut = try makeSut()
        getMeUseCase.result = .success(makeUser())
        
        let isLoading = wait(for: sut.$isLoading.collect(2).eraseToAnyPublisher()) {
            sut.onViewLoaded()
        }.values.first!.last!
        
        XCTAssertTrue(isLoading)
    }
    
    func test_isLoading_isFalse_when_onViewLoaded_isSuccessful() async throws {
        let sut = try makeSut()
        getMeUseCase.result = .success(makeUser())
        
        let isLoading = wait(for: sut.$isLoading.collect(3).eraseToAnyPublisher()) {
            sut.onViewLoaded()
        }.values.first!.last!
        
        XCTAssertFalse(isLoading)
    }
    
    func test_user_isNil_byDefault() async throws {
        let sut = try makeSut()
        
        XCTAssertNil(sut.user)
    }
    
    func test_user_isSet_when_onViewLoaded_isSuccessful() async throws {
        let mockUser = makeUser()
        let sut = try makeSut()
        getMeUseCase.result = .success(mockUser)
        
        let user = wait(for: sut.$user.dropFirst().eraseToAnyPublisher()) {
            sut.onViewLoaded()
        }.values.first!
        
        XCTAssertEqual(mockUser, user)
    }
    
    func test_errorMessage_isNil_byDefault() async throws {
        let sut = try makeSut()
        
        XCTAssertNil(sut.errorMessage)
    }
    
    func test_errorMessage_isSet_when_login_isFailed() async throws {
        let sut = try makeSut()
        let mockErrorMessage = "Some custom error"
        getMeUseCase.result = .failure(.parsingError(ExecutionError.withMessage(mockErrorMessage)))
        
        let errorMessage = wait(for: sut.$errorMessage.dropFirst().eraseToAnyPublisher()) {
            sut.onViewLoaded()
        }.values.last!
        
        XCTAssertEqual(errorMessage, mockErrorMessage)
    }
    
    func test_signOutUseCase_isExecuted_when_signOut_isInvoked() async throws {
        let sut = try makeSut()
        
        sut.signOut()
        
        XCTAssertTrue(signOutUseCase.isExecuted)
    }
}

private extension WelcomeViewModelTests {
    func makeSut(
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> WelcomeViewModel {
        
        let useCases = WelcomeViewModel.UseCases(
            signOutUseCase: signOutUseCase,
            getMeUseCase: getMeUseCase
        )
        let sut = try WelcomeViewModel(
            useCases: useCases,
            sideCar: ViewModelSideCar()
        )
        
        assertDeallocation(sut, file, line)
        
        return sut
    }
}
