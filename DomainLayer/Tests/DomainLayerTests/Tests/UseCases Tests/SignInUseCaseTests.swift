//
//  SignInUseCaseTests.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-02-21.
//

import Testing
import Combine
import TestUtils
@testable import DomainLayer

struct SignInUseCaseTests {
    @Test func test_signInUseCase_invokes_signIn_inRepository() async throws {
        let (sut, dependencies) = await makeSut()
        
        _ = try await sut.execute(makeSignInInput()).async()
        
        #expect(dependencies.authenticationRepository.isSignInInvoked)
    }
    
    @Test func test_signInUseCase_returnsError_afterUnsuccessfull_signIn() async throws {
        let (sut, dependencies) = await makeSut()
        
        dependencies.authenticationRepository.signInResult = .failure(.other(makeError()))
        
        do {
            _ = try await sut.execute(makeSignInInput()).async()
            assert(false)
        } catch AuthenticationError.dataError {
            #expect(true)
        } catch {
            assert(false)
        }
    }
    
    @Test func test_signInUseCase_returnsInvalidEmailParsingError_whenEmail_isInvalid() async throws {
        let (sut, _) = await makeSut()
        let signInInput = makeSignInInput(email: "invalidEmail")
        
        do {
            _ = try await sut.execute(signInInput).async()
            assert(false)
        } catch AuthenticationError.credentialsParsingError(let error) {
            #expect(error == .invalidEmail)
        } catch {
            assert(false)
        }
    }
    
    @Test func test_signInUseCase_returnsEmptyEmailParsingError_whenEmail_isEmpty() async throws {
        let (sut, _) = await makeSut()
        let signInInput = makeSignInInput(email: "")
        
        do {
            _ = try await sut.execute(signInInput).async()
            assert(false)
        } catch AuthenticationError.credentialsParsingError(let error) {
            #expect(error == .invalidEmail)
        } catch {
            assert(false)
        }
    }
    
    @Test func test_signInUseCase_returnsInvalidPasswordParsingError_whenPassword_isInvalid() async throws {
        let (sut, _) = await makeSut()
        let signInInput = makeSignInInput(password: "1")
        
        do {
            _ = try await sut.execute(signInInput).async()
            assert(false)
        } catch AuthenticationError.credentialsParsingError(let error) {
            #expect(error == .invalidPassword)
        } catch {
            assert(false)
        }
    }
    
    @Test func test_signInUseCase_returnsEmptyPasswordParsingError_whenPassword_isEmpty() async throws {
        let (sut, _) = await makeSut()
        let signInInput = makeSignInInput(password: "")
        
        do {
            _ = try await sut.execute(signInInput).async()
            assert(false)
        } catch AuthenticationError.credentialsParsingError(let error) {
            #expect(error == .invalidPassword)
        } catch {
            assert(false)
        }
    }
}
    

private extension SignInUseCaseTests {
    func makeSut() async -> (SignInUseCase, SignInUseCase.Dependencies) {
        let mockAuthenticationRepository = MockAuthenticationRepository()
        let mockLocalStoreRepository = MockLocalStoreRepository()
        let dependencies = SignInUseCase.Dependencies(
            authenticationRepository: mockAuthenticationRepository,
            mockLocalStoreRepository: mockLocalStoreRepository
        )
        let sut = dependencies.assemble()
        
        return (sut, dependencies)
    }
}

private extension SignInUseCase {
    struct Dependencies {
        let authenticationRepository: MockAuthenticationRepository
        let mockLocalStoreRepository: MockLocalStoreRepository

        func assemble() -> SignInUseCase {
            SignInUseCase(
                repository: authenticationRepository,
                localStorage: mockLocalStoreRepository
            )
        }
    }
}
