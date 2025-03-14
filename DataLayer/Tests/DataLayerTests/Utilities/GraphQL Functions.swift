//
//  File.swift
//  DataLayer
//
//  Created by Dmytro Yurchenko on 2025-03-14.
//

import Foundation
import XCTest
@testable import DataLayer

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
