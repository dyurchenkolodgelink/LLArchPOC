//
//  MockedUseCase.swift
//  LodgeLinkTests
//
//  Created by Dmytro Yurchenko on 2024-09-10.
//

import Foundation

class MockedUseCase<Output, Failure: Error> {
    var result: Result<Output, Failure>?
    
    var isExecuteInvoked: Bool = false
}
