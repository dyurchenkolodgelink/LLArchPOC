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
    private let userRepository = MockUserRepository()
    private let authenticationRepository = MockAuthenticationRepository()
    
    func test_happyPath() async throws {
        let sut = makeSut()
        let user = makeUser()
        
        userRepository.getMeResult = .success(user)
        
        let result = try await sut.execute().async()
        
        XCTAssertEqual(result, user)
    }
    
    func test_happyPath_authenticationIsSet_inAuthenticatioResository() async throws {
        let sut = makeSut()
        let user = makeUser()
        
        userRepository.getMeResult = .success(user)
        
        try await sut.execute().async()
        
        XCTAssertEqual(authenticationRepository.setAuthentication, Authentication.authenticated(user))
    }
    
    func test_error_isReceivedProperly() async throws {
        let sut = makeSut()
        let dataError = DataError.responseError(ExecutionError.withMessage("Response issue"))
        
        userRepository.getMeResult = .failure(dataError)
        
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
    ) -> GetMeUseCase {
        
        let sut = GetMeUseCase(
            userRepository: userRepository,
            authenticationRepository: authenticationRepository
        )
        
        assertDeallocation(sut, file, line)
        
        return sut
    }
}
