//
//  File.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-03-14.
//

import XCTest

public extension XCTestCase {
    func assertDeallocation(
        _ object: AnyObject?,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        addTeardownBlock { [weak object] in
            XCTAssertNil(
                object,
                "\(String(describing: type(of: object))) has not been deallocated",
                file: file,
                line: line
            )
        }
    }
}
