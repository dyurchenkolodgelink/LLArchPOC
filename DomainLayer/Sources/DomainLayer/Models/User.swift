//
//  File.swift
//  DomainLayer
//
//  Created by Dmytro Yurchenko on 2025-01-30.
//

import Foundation

public struct User: Hashable {
    public let id: ID<User>
    public let email: Email
    public let firstName, lastName: Name
    public let company, position, phoneNumber: String?
    
    public init(
        id: ID<User>,
        email: Email,
        firstName: Name,
        lastName: Name,
        company: String?,
        position: String?,
        phoneNumber: String?
    ) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.company = company
        self.position = position
        self.phoneNumber = phoneNumber
    }
}

extension User: Fakeable {
    public static func fake() -> User {
        User(
            id: try! ID<User>("Fake ID"),
            email: try! Email("fake@example.com"),
            firstName: try! Name("Fake First Name"),
            lastName: try! Name("Fake Last Name"),
            company: "Fake Company",
            position: "Fake Position",
            phoneNumber: "Fake Phone Number"
        )
    }
}
