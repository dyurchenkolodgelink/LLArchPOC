//
//  MockURLProtocol.swift
//  DataLayer
//
//  Created by Dmytro Yurchenko on 2025-03-11.
//

import Foundation
import Testing

final class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let requestHandler = MockURLProtocol.requestHandler else {
            return assertionFailure("No request handler provided")
        }
        
        do {
            let (response, data) = try requestHandler(request)
            
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            assertionFailure("Error handling the request: \(error)")
        }
    }
    
    override func stopLoading() {}
}
