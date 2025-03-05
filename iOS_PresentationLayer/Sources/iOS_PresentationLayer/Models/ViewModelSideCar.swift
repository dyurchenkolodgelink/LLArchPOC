//
//  ViewModelSideCar.swift
//  LodgeLink
//
//  Created by Dmytro Yurchenko on 2024-08-07.
//

import Foundation
import DomainLayer

struct ViewModelSideCar: Fakeable {
//    let analyticsLogger: AnalyticsLoggerProtocol
//    let applicationSessionStore: ApplicationSessionStoreProtocol
    
    var permissions: Set<OrgPermission> = []
    
    static func fake() -> ViewModelSideCar {
        fake(permissions: [])
    }
    
    static func fake(
        permissions: Set<OrgPermission> = []
    ) -> ViewModelSideCar {
        ViewModelSideCar(
//            analyticsLogger: FakeAnalyticsLogger(),
//            applicationSessionStore: FakeApplicationSessionStore(
//                authentication:
//            )
        )
    }
    
//    private struct FakeAnalyticsLogger: AnalyticsLoggerProtocol {
//        let sideCar: AnalyticsLoggerSideCar = .fake()
//        
//        func log(event: AnalyticsLogEvent) {}
//        func log(error: String) {}
//    }
}
