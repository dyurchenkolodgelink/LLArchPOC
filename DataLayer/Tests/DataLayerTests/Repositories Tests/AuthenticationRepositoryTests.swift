//
//  AuthenticationRepositoryTests.swift
//  DataLayer
//
//  Created by Dmytro Yurchenko on 2025-03-11.
//

import Foundation
import DomainLayer
import XCTest
import TestUtils
@testable import DataLayer

final class AuthenticationRepositoryTests: XCTestCase {
    func test_signIn_isSuccessfullyParsed_andMapped() async throws {
        let sut = AuthenticationRepository(graphQLClient: makeGraphQLClient())
        let mockData = makeLoginDataResponse()
        let result = try await mockResponse(
            with: .success(data: mockData),
            requestCheck: { request in
                request.apolloOperationName == "login"
            },
            requestExecutionBlock: {
                try await sut.signIn(
                    email: makeEmail(),
                    password: makePassword()
                ).eraseToAnyPublisher().async()
            }
        )
        
        XCTAssertEqual(result?.user.id.value, mockData.login?.me?.userId)
        XCTAssertEqual(result?.user.firstName.value, mockData.login?.me?.firstName)
        XCTAssertEqual(result?.user.lastName.value, mockData.login?.me?.lastName)
        XCTAssertEqual(result?.user.email.value, mockData.login?.me?.emailAddress)
        XCTAssertEqual(result?.token.value, mockData.login?.accountToken)
    }
    
    func test_signIn_fails_withResponseError() async throws {
        let sut = AuthenticationRepository(graphQLClient: makeGraphQLClient())
        let errorMessage = "Error message"
        
        do {
            _ = try await mockResponse(
                with: .failure(message: errorMessage),
                requestExecutionBlock: {
                    try await sut.signIn(email: makeEmail(), password: makePassword())
                        .eraseToAnyPublisher()
                        .async()
                }
            )
            
            XCTFail("Sign in must fail here")
        } catch DataError.responseError(let responseError) {
            XCTAssertEqual(responseError.localizedDescription, errorMessage)
        } catch {
            XCTFail("Wrong error appeared: \(error)")
        }
    }
    
    func test_signIn_fails_withNetworkError() async throws {
        let sut = AuthenticationRepository(graphQLClient: makeGraphQLClient())
        
        do {
            _ = try await mockResponse(
                with: .failure(message: "Error message"),
                statusCode: 401,
                requestExecutionBlock: {
                    try await sut.signIn(email: makeEmail(), password: makePassword())
                        .eraseToAnyPublisher()
                        .async()
                }
            )
            
            XCTFail("Sign in must fail here")
        } catch DataError.networkError {
            XCTAssert(true)
        } catch {
            XCTFail("Wrong error appeared: \(error)")
        }
    }
    
    func test_signIn_fails_withParsingError_dueToInvalidEmail() async throws {
        let sut = AuthenticationRepository(graphQLClient: makeGraphQLClient())
        let mockLoginResponse = makeLoginDataResponse(
            login: makeLoginResponse(
                meResponse: makeMeResponse(emailAddress: "invalidEmail.com")
            )
        )
        
        do {
            _ = try await mockResponse(
                with: .success(data: mockLoginResponse),
                requestExecutionBlock: {
                    try await sut.signIn(email: makeEmail(), password: makePassword())
                        .eraseToAnyPublisher()
                        .async()
                }
            )
            
            XCTFail("Sign in must fail here")
        } catch DataError.parsingError(let parsingError as CredentialsParsingError) {
            XCTAssertEqual(parsingError, .invalidEmail)
        } catch {
            XCTFail("Wrong error appeared: \(error)")
        }
    }
    
    func test_signIn_fails_withNoResponseParsingError() async throws {
        let sut = AuthenticationRepository(graphQLClient: makeGraphQLClient())
        let mockLoginResponse = makeLoginDataResponse(login: nil)
        
        do {
            _ = try await mockResponse(
                with: .success(data: mockLoginResponse),
                requestExecutionBlock: {
                    try await sut.signIn(email: makeEmail(), password: makePassword())
                        .eraseToAnyPublisher()
                        .async()
                }
            )
            
            XCTFail("Sign in must fail here")
        } catch DataError.parsingError(let error as ResponseError) {
            XCTAssertEqual(error, .noResponse)
        } catch {
            XCTFail("Wrong error appeared: \(error)")
        }
    }
}
