//
//  XCTestCase + Ext.swift
//  LodgeLinkTests
//
//  Created by Dmytro Yurchenko on 2023-04-27.
//

import XCTest
import Combine

extension XCTestCase {
    @discardableResult
    func wait<Output, Failure: Error>(
        for publisher: AnyPublisher<Output, Failure>,
        waitForValue value: Output? = nil,
        timeout: TimeInterval = 5.0,
        trigger: () -> Void = {}
    ) -> PublisherSpy<Output, Failure> {
        let expectation = expectation(description: "Expecting for the publisher is completed")
        let publisherSpy: PublisherSpy<Output, Failure>
        
        if let value {
            publisherSpy = PublisherSpy(
                publisher: publisher.eraseToAnyPublisher(),
                completeOn: value,
                onComplete: expectation.fulfill
            )
        } else {
            publisherSpy = PublisherSpy(
                publisher: publisher.first().eraseToAnyPublisher(),
                onComplete: expectation.fulfill
            )
        }
        
        trigger()
        
        wait(for: [expectation], timeout: timeout)
        
        return publisherSpy
    }
}
