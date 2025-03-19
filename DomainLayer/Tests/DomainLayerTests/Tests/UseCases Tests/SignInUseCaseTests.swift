//
//  SignInUseCaseTests.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-02-21.
//

import XCTest
import Combine
import TestUtils
@testable import DomainLayer

final class SignInUseCaseTests: XCTestCase {
    private let authenticationRepository = MockAuthenticationRepository()
    private let localStoreRepository = MockLocalStoreRepository()
    
    func test_signInUseCase_invokes_signIn_inRepository() async throws {
        let sut = await makeSut()
        
        _ = try await sut.execute(makeSignInInput()).async()
        
        XCTAssertTrue(authenticationRepository.isSignInInvoked)
    }
    
    func test_storeAuthentication_isInvoked() async throws {
        let sut = await makeSut()
        let token = makeValidAuthenticationToken(value: "New Token")
        
        authenticationRepository.signInResult = .success(makeSignInResult(token: token))
        
        _ = try await sut.execute(makeSignInInput()).async()
        
        XCTAssertEqual(localStoreRepository.storedValue, token)
    }
    
    func test_signInUseCase_returnsError_afterUnsuccessfull_signIn() async throws {
        let sut = await makeSut()
        
        authenticationRepository.signInResult = .failure(.other(makeError()))
        
        do {
            _ = try await sut.execute(makeSignInInput()).async()
            
            XCTFail("Must fail")
        } catch AuthenticationError.dataError {
            XCTAssert(true, "Caught expected error")
        } catch {
            XCTFail("Wrong error: \(error)")
        }
    }
    
    func test_signInUseCase_returnsInvalidEmailParsingError_whenEmail_isInvalid() async throws {
        let sut = await makeSut()
        let signInInput = makeSignInInput(email: "invalidEmail")
        
        do {
            _ = try await sut.execute(signInInput).async()
            
            XCTFail("Must fail")
        } catch AuthenticationError.credentialsParsingError(let error) {
            XCTAssertEqual(error, .invalidEmail)
        } catch {
            XCTFail("Wrong error: \(error)")
        }
    }
    
    func test_signInUseCase_returnsEmptyEmailParsingError_whenEmail_isEmpty() async throws {
        let sut = await makeSut()
        let signInInput = makeSignInInput(email: "")
        
        do {
            _ = try await sut.execute(signInInput).async()
            
            XCTFail("Must fail")
        } catch AuthenticationError.credentialsParsingError(let error) {
            XCTAssertEqual(error, .invalidEmail)
        } catch {
            XCTFail("Wrong error: \(error)")
        }
    }
    
    func test_signInUseCase_returnsInvalidPasswordParsingError_whenPassword_isInvalid() async throws {
        let sut = await makeSut()
        let signInInput = makeSignInInput(password: "1")
        
        do {
            _ = try await sut.execute(signInInput).async()
            
            XCTFail("Must fail")
        } catch AuthenticationError.credentialsParsingError(let error) {
            XCTAssertEqual(error, .invalidPassword)
        } catch {
            XCTFail("Wrong error: \(error)")
        }
    }
    
    func test_signInUseCase_returnsEmptyPasswordParsingError_whenPassword_isEmpty() async throws {
        let sut = await makeSut()
        let signInInput = makeSignInInput(password: "")
        
        do {
            _ = try await sut.execute(signInInput).async()
            
            XCTFail("Must fail")
        } catch AuthenticationError.credentialsParsingError(let error) {
            XCTAssertEqual(error, .invalidPassword)
        } catch {
            XCTFail("Wrong error: \(error)")
        }
    }
    
    func test_signInUseCase_returnsDataError_whenFailStoreIntoLocalStoreRepository() async throws {
        let sut = await makeSut()
        let signInInput = makeSignInInput()
        let errorMessage = "Some error"
        
        localStoreRepository.storeError = ExecutionError.withMessage(errorMessage)
        
        do {
            _ = try await sut.execute(signInInput).async()
            
            XCTFail("Must fail")
        } catch AuthenticationError.dataError(let error) {
            switch error {
            case .persistenceError(let persistenceError):
                XCTAssertEqual(persistenceError.localizedDescription, errorMessage)
            default:
                XCTFail("Wrong error: \(error)")
            }
        } catch {
            XCTFail("Wrong error: \(error)")
        }
    }
}
    
private extension SignInUseCaseTests {
    func makeSut(
        file: StaticString = #file,
        line: UInt = #line
    ) async -> SignInUseCase {
        
        let sut = SignInUseCase(
            repository: authenticationRepository,
            localStorage: localStoreRepository
        )
        
        assertDeallocation(sut, file, line)
        
        return sut
    }
}
