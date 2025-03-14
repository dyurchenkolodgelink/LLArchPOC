//
//  File.swift
//  DataLayer
//
//  Created by Dmytro Yurchenko on 2025-03-14.
//

import Foundation

extension URLRequest {
    var apolloOperationName: String? {
        allHTTPHeaderFields?["X-APOLLO-OPERATION-NAME"]
    }
}
