//
//  ActiveRequest.swift
//  LodgeLink
//
//  Created by Dmytro Yurchenko on 2024-03-01.
//

import Foundation
import Apollo

struct ActiveRequest<Operation: Apollo.GraphQLOperation>: CancellableRequest {
    let operation: Operation
    let cancellable: Apollo.Cancellable?
    var operationName: String { operation.operationName }
}
