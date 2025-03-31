//
//  LoginViewModelTests.swift
//  iOS_PresentationLayer
//
//  Created by Dmytro Yurchenko on 2025-03-28.
//

import XCTest
import Combine
import DomainLayer
import TestUtils
@testable import iOS_PresentationLayer

final class LoginViewModelTests: XCTestCase {
    private let signInUseCase = MockSignInUseCase()
    
    func test_isLoading_isFalse_byDefault() async throws {
        let sut = try makeSut()
        
        XCTAssertFalse(sut.isLoading)
    }
    
    func test_isLoading_isTrue_when_login_isInvoked() async throws {
        let sut = try makeSut()
        signInUseCase.result = .success(makeUser())
        
        let isLoading = try XCTUnwrap(wait(for: sut.$isLoading.collect(2).eraseToAnyPublisher()) {
            sut.login()
        }.values.first?.last, "isLoading was not emitted for two times")
        
        XCTAssertTrue(isLoading)
    }
    
    func test_isLoading_isFalse_when_login_isSuccessful() async throws {
        let sut = try makeSut()
        signInUseCase.result = .success(makeUser())
        
        let isLoading = try XCTUnwrap(wait(for: sut.$isLoading.collect(3).eraseToAnyPublisher()) {
            sut.login()
        }.values.first?.last, "isLoading was not emitted for three times")
        
        XCTAssertFalse(isLoading)
    }
    
    func test_errorMessage_isNil_byDefault() async throws {
        let sut = try makeSut()
        
        XCTAssertNil(sut.errorMessage)
    }
    
    func test_errorMessage_isSet_when_login_isFailed() async throws {
        let sut = try makeSut()
        signInUseCase.result = .failure(.credentialsParsingError(.invalidEmail))
        
        let errorMessage = try XCTUnwrap(wait(for: sut.$errorMessage.dropFirst().eraseToAnyPublisher()) {
            sut.login()
        }.values.last, "errorMessage was not emitted")
        
        XCTAssertEqual(errorMessage, "Invalid email format")
    }
}

private extension LoginViewModelTests {
    func makeSut(
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> LoginViewModel {
        
        let useCases = LoginViewModel.UseCases(signInUseCase: signInUseCase)
        let sut = try LoginViewModel(useCases: useCases, sideCar: ViewModelSideCar())
        
        assertDeallocation(sut, file, line)
        
        return sut
    }
}
