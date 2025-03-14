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
    func test_signInUseCase_invokes_signIn_inRepository() async throws {
        let (sut, dependencies) = await makeSut()
        
        _ = try await sut.execute(makeSignInInput()).async()
        
        XCTAssertTrue(dependencies.authenticationRepository.isSignInInvoked)
    }
    
    func test_storeAuthentication_isInvoked() async throws {
        let (sut, dependencies) = await makeSut()
        let token = makeValidAuthenticationToken(value: "New Token")
        
        dependencies.authenticationRepository.signInResult = .success(makeSignInResult(token: token))
        
        _ = try await sut.execute(makeSignInInput()).async()
        
        XCTAssertEqual(dependencies.localStoreRepository.storedValue, token)
    }
    
    func test_signInUseCase_returnsError_afterUnsuccessfull_signIn() async throws {
        let (sut, dependencies) = await makeSut()
        
        dependencies.authenticationRepository.signInResult = .failure(.other(makeError()))
        
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
        let (sut, _) = await makeSut()
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
        let (sut, _) = await makeSut()
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
        let (sut, _) = await makeSut()
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
        let (sut, _) = await makeSut()
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
        let (sut, dependencies) = await makeSut()
        let signInInput = makeSignInInput()
        let errorMessage = "Some error"
        
        dependencies.localStoreRepository.storeError = ExecutionError.withMessage(errorMessage)
        
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
    ) async -> (SignInUseCase, SignInUseCase.Dependencies) {
        
        let mockAuthenticationRepository = MockAuthenticationRepository()
        let mockLocalStoreRepository = MockLocalStoreRepository()
        let dependencies = SignInUseCase.Dependencies(
            authenticationRepository: mockAuthenticationRepository,
            localStoreRepository: mockLocalStoreRepository
        )
        let sut = dependencies.assemble()
        
        assertDeallocation(sut, file: file, line: line)
        
        return (sut, dependencies)
    }
}

private extension SignInUseCase {
    struct Dependencies {
        let authenticationRepository: MockAuthenticationRepository
        let localStoreRepository: MockLocalStoreRepository

        func assemble() -> SignInUseCase {
            SignInUseCase(
                repository: authenticationRepository,
                localStorage: localStoreRepository
            )
        }
    }
}
