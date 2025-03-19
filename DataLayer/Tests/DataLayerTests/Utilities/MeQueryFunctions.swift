//
//  File.swift
//  DataLayer
//
//  Created by Dmytro Yurchenko on 2025-03-19.
//

import Foundation
@testable import DataLayer

func makeGetMeResponse(
    emailAddress: String = "some@email.com"
) -> MeQuery.Data.Me {
    
    MeQuery.Data.Me(
        emailAddress: emailAddress,
        phoneNumber: "fake phone number",
        firstName: "First-Name",
        lastName: "LastName",
        userId: "UserID",
        company: "Some Company",
        position: "Some Position"
    )
}

func makeMeQueryDataResponse(
    me: MeQuery.Data.Me? = makeGetMeResponse()
) -> MeQuery.Data {
    
    MeQuery.Data(me: me)
}
