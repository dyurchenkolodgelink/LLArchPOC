//
//  AuthenticationRepositoryTests.swift
//  DataLayer
//
//  Created by Dmytro Yurchenko on 2025-03-11.
//

import Foundation
import Testing
import Apollo
import DomainLayer
import Combine
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

extension URLRequest {
    var apolloOperationName: String? {
        allHTTPHeaderFields?["X-APOLLO-OPERATION-NAME"]
    }
}

func makeGraphQLClient() -> GraphQLClientProtocol {
    let configuration: URLSessionConfiguration = .ephemeral
    
    configuration.protocolClasses = [MockURLProtocol.self]
    
    let infoDictionary: [String: Any] = [
        "API Base Url": "https://some.base.url.com/graphql"
    ]
    let graphQLClient = Network(
        infoDictionary: infoDictionary,
        getAuthenticationToken: { nil }
    ).getApolloClient(configuration: configuration)!
    
    return graphQLClient
}

enum MockResponseResult {
    case success(data: GraphQLSelectionSet)
    case failure(message: String)
    
    func makeResponseJSON() throws -> Data {
        switch self {
        case let .success(data):
            let data = try JSONSerialization.data(withJSONObject: data.jsonObject, options: .prettyPrinted)
            
            return """
            {
                "data": \(String(data: data, encoding: .utf8)!)
            }
            """.data(using: .utf8)!
            
        case let .failure(message):
            return """
            {
                "data": null,
                "errors": [
                    {
                        "message": "\(message)"
                    }
                ]
            }
            """.data(using: .utf8)!
        }
    }
}

func mockResponse<T>(
    with mockResult: MockResponseResult,
    statusCode: Int = 200,
    requestCheck: @escaping (URLRequest) -> Bool = { _ in true },
    requestExecutionBlock: () async throws -> T?
) async throws -> T? {
    
    let data = try mockResult.makeResponseJSON()
    
    MockURLProtocol.requestHandler = { request in
        XCTAssertTrue(requestCheck(request))
        
        let response = HTTPURLResponse(
            url: request.url!,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )!
        
        return (response, data)
    }
    
    let result = try await requestExecutionBlock()
    
    MockURLProtocol.requestHandler = nil
    
    return result
}

func makeMeResponse(
    emailAddress: String = "some@email.com"
) -> LoginMutation.Data.Login.Me {
    
    LoginMutation.Data.Login.Me(
        emailAddress: emailAddress,
        phoneNumber: "fake phone number",
        firstName: "First-Name",
        lastName: "LastName",
        userId: "UserID",
        company: "Some Company",
        position: "Some Position"
    )
}

func makeLoginResponse(
    errorMessage: String? = nil,
    accountToken: String? = "Some Token",
    meResponse: LoginMutation.Data.Login.Me? = makeMeResponse()
) -> LoginMutation.Data.Login {
    
    LoginMutation.Data.Login(
        errorMessage: errorMessage,
        message: "Some Message",
        accountToken: accountToken,
        tokenExpiry: nil,
        me: meResponse
    )
}

func makeLoginDataResponse(
    login: LoginMutation.Data.Login? = makeLoginResponse()
) -> LoginMutation.Data {
    
    LoginMutation.Data(login: login)
}
