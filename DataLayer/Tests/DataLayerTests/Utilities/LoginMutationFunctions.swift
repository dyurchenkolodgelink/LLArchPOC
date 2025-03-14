//
//  File.swift
//  DataLayer
//
//  Created by Dmytro Yurchenko on 2025-03-14.
//

import Foundation
@testable import DataLayer

func makeMeResponse(
    emailAddress: String = "some@email.com"
) -> LoginMutation.Data.Login.Me {
    
    LoginMutation.Data.Login.Me(
        emailAddress: emailAddress,
        phoneNumber: "fake phone number",
        firstName: "First-Name",
        lastName: "LastName",
        userId: "UserID",
        company: "Some Company",
        position: "Some Position"
    )
}

func makeLoginResponse(
    errorMessage: String? = nil,
    accountToken: String? = "Some Token",
    meResponse: LoginMutation.Data.Login.Me? = makeMeResponse()
) -> LoginMutation.Data.Login {
    
    LoginMutation.Data.Login(
        errorMessage: errorMessage,
        message: "Some Message",
        accountToken: accountToken,
        tokenExpiry: nil,
        me: meResponse
    )
}

func makeLoginDataResponse(
    login: LoginMutation.Data.Login? = makeLoginResponse()
) -> LoginMutation.Data {
    
    LoginMutation.Data(login: login)
}
