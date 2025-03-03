//
//  CancellableRequest.swift
//  LodgeLink
//
//  Created by Dmytro Yurchenko on 2024-03-01.
//

import Foundation
import Apollo

protocol CancellableRequest {
    var cancellable: Apollo.Cancellable? { get }
    var operationName: String { get }
    
    func cancel()
}

extension CancellableRequest {
    func cancel() {
        cancellable?.cancel()
    }
}
