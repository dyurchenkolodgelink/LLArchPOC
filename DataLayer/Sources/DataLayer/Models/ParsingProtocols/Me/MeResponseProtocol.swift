//
//  MeResponseProtocol.swift
//  LodgeLink
//
//  Created by Dmytro Yurchenko on 2024-08-12.
//

import Foundation
import DomainLayer

protocol MeResponseProtocol {
    var emailAddress: String { get }
    var phoneNumber: String? { get }
    var firstName: String { get }
    var lastName: String { get }
    var userId: String { get }
    var company: String? { get }
    var position: String? { get }
}

extension MeResponseProtocol {
    func toDomain() throws -> User {
        User(
            id: try ID<User>(userId),
            email: try Email(emailAddress),
            firstName: try Name(firstName),
            lastName: try Name(lastName),
            company: company,
            position: position,
            phoneNumber: phoneNumber
        )
    }
}

extension LoginMutation.Data.Login.Me: MeResponseProtocol {}
