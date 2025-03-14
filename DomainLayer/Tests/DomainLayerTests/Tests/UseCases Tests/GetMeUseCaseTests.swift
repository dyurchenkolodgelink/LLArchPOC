//
//  File.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-03-14.
//

import XCTest
import TestUtils
@testable import DomainLayer

final class GetMeUseCaseTests: XCTestCase {
    func test_happyPath() async throws {
        let (sut, dependencies) = makeSut()
        let user = makeUser()
        
        dependencies.userRepository.getMeResult = .success(user)
        
        let result = try await sut.execute().async()
        
        XCTAssertEqual(result, user)
    }
    
    func test_happyPath_authenticationIsSet_inAuthenticatioResository() async throws {
        let (sut, dependencies) = makeSut()
        let user = makeUser()
        
        dependencies.userRepository.getMeResult = .success(user)
        
        try await sut.execute().async()
        
        XCTAssertEqual(dependencies.authenticationRepository.setAuthentication, Authentication.authenticated(user))
    }
    
    func test_error_isReceivedProperly() async throws {
        let (sut, dependencies) = makeSut()
        let dataError = DataError.responseError(ExecutionError.withMessage("Response issue"))
        
        dependencies.userRepository.getMeResult = .failure(dataError)
        
        do {
            try await sut.execute().async()
            
            XCTFail("Must fail here")
        } catch let error as DataError {
            XCTAssertEqual(error, dataError)
        } catch {
            XCTFail("Wrong error: \(error)")
        }
    }
}

private extension GetMeUseCaseTests {
    func makeSut(
        file: StaticString = #file,
        line: UInt = #line
    ) -> (GetMeUseCase, Dependencies) {
        
        let mockUserRepository = MockUserRepository()
        let mockAuthenticationRepository = MockAuthenticationRepository()
        let dependencies = Dependencies(
            userRepository: mockUserRepository,
            authenticationRepository: mockAuthenticationRepository
        )
        let sut = dependencies.assembleSut()
        
        assertDeallocation(sut, file, line)
        
        return (sut, dependencies)
    }
}

private struct Dependencies {
    let userRepository: MockUserRepository
    let authenticationRepository: MockAuthenticationRepository
    
    func assembleSut() -> GetMeUseCase {
        GetMeUseCase(
            userRepository: userRepository,
            authenticationRepository: authenticationRepository
        )
    }
}
