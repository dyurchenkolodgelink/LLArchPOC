//
//  File.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-03-19.
//

import XCTest
@testable import DomainLayer

final class SignOutUseCaseTests: XCTestCase {
    private let authenticationRepository = MockAuthenticationRepository()
    private let localStoreRepository = MockLocalStoreRepository()
    
    func test_execute_shouldSetAuthentication_unauthenticated() {
        let sut = makeSut()
        
        sut.execute()
        
        XCTAssertEqual(authenticationRepository.setAuthentication, .unauthenticated)
    }
    
    func test_execute_shouldRemoveValue_forAuthTokenStorageKey() {
        let sut = makeSut()
        
        sut.execute()
        
        XCTAssertEqual(localStoreRepository.removedValueKey, .authToken)
    }
}

private extension SignOutUseCaseTests {
    func makeSut(
        file: StaticString = #file,
        line: UInt = #line
    ) -> SignOutUseCase {
        
        let sut = SignOutUseCase(
            authenticationRepository: authenticationRepository,
            localStoreRepository: localStoreRepository
        )
        
        assertDeallocation(sut, file, line)
        
        return sut
    }
}
