//
//  File.swift
//  DataLayer
//
//  Created by Dmytro Yurchenko on 2025-03-14.
//

import Foundation
import Apollo

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
