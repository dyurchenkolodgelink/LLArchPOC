//
//  File.swift
//  DataLayer
//
//  Created by Dmytro Yurchenko on 2025-03-19.
//

import XCTest
import DomainLayer
@testable import DataLayer

final class UserRepositoryTests: XCTestCase {
    func test_getMe_isSuccessfullyParsedAndMapped() async throws {
        let sut = makeSut()
        let mockData = makeMeQueryDataResponse()
        
        let result = try await mockResponse(
            with: .success(data: mockData),
            requestCheck: { request in
                request.apolloOperationName == "me"
            },
            requestExecutionBlock: {
                try await sut.getMe()
                    .eraseToAnyPublisher()
                    .async()
            }
        )
        
        XCTAssertEqual(result?.id.value, mockData.me?.userId)
        XCTAssertEqual(result?.firstName.value, mockData.me?.firstName)
        XCTAssertEqual(result?.lastName.value, mockData.me?.lastName)
        XCTAssertEqual(result?.email.value, mockData.me?.emailAddress)
    }
    
    func test_getMe_fails_withResponseError() async throws {
        let sut = makeSut()
        let errorMessage = "Error message"
        
        do {
            _ = try await mockResponse(
                with: .failure(message: errorMessage),
                requestExecutionBlock: {
                    try await sut.getMe()
                        .eraseToAnyPublisher()
                        .async()
                }
            )
            
            XCTFail("Get Me must fail here")
        } catch DataError.responseError(let responseError) {
            XCTAssertEqual(responseError.localizedDescription, errorMessage)
        } catch {
            XCTFail("Wrong error appeared: \(error)")
        }
    }
    
    func test_getMe_fails_withNetworkError() async throws {
        let sut = makeSut()
        
        do {
            _ = try await mockResponse(
                with: .failure(message: "Error message"),
                statusCode: 401,
                requestExecutionBlock: {
                    try await sut.getMe()
                        .eraseToAnyPublisher()
                        .async()
                }
            )
            
            XCTFail("Get Me must fail here")
        } catch DataError.networkError {
            XCTAssert(true)
        } catch {
            XCTFail("Wrong error appeared: \(error)")
        }
    }
    
    func test_getMe_fails_withParsingError_dueToInvalidEmail() async throws {
        let sut = makeSut()
        let mockMeResponse = makeMeQueryDataResponse(
            me: makeGetMeResponse(emailAddress: "invalidEmail.com")
        )
        
        do {
            _ = try await mockResponse(
                with: .success(data: mockMeResponse),
                requestExecutionBlock: {
                    try await sut.getMe()
                        .eraseToAnyPublisher()
                        .async()
                }
            )
            
            XCTFail("Get Me must fail here")
        } catch DataError.parsingError(let parsingError as CredentialsParsingError) {
            XCTAssertEqual(parsingError, .invalidEmail)
        } catch {
            XCTFail("Wrong error appeared: \(error)")
        }
    }
    
    func test_getMe_fails_withNoResponseParsingError() async throws {
        let sut = makeSut()
        let mockMeResponse = makeMeQueryDataResponse(me: nil)
        
        do {
            _ = try await mockResponse(
                with: .success(data: mockMeResponse),
                requestExecutionBlock: {
                    try await sut.getMe()
                        .eraseToAnyPublisher()
                        .async()
                }
            )
            
            XCTFail("Get Me must fail here")
        } catch DataError.parsingError(let error as ResponseError) {
            XCTAssertEqual(error, .noResponse)
        } catch {
            XCTFail("Wrong error appeared: \(error)")
        }
    }
}

private extension UserRepositoryTests {
    func makeSut(
        file: StaticString = #file,
        line: UInt = #line
    ) -> UserRepository {
        
        let sut = UserRepository(
            graphQLClient: makeGraphQLClient()
        )
        
        assertDeallocation(sut, file, line)
        
        return sut
    }
}
