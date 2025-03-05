//
//  Debug.swift
//  LodgeLink
//
//  Created by Dmytro Yurchenko on 2024-01-08.
//

import Foundation
import os.log

public struct Debug {
    static private let types: [LogType.AvailableLogType] = [.network_apollo, .error]
    
    public static func log(_ logType: LogType) {
        #if DEBUG
        
        guard types.contains(logType.availabilityType)
        else { return }
        
        let log = OSLog(subsystem: logType.subsystem, category: logType.category)
        
        switch logType {
        case let .error(error):
            os_log("🆘 [Error]\n%@", log: log, type: .error, error.localizedDescription)
            
//        case let .analyticsEvent(eventData):
//            os_log("💹 [Analytics Event]\n%@", log: log, type: .info, eventData.logString)
            
        case let .network_apollo(data):
            os_log("🛜 [Network]\n%@", log: log, type: .debug, data)
            
        case let .request(data):
            os_log("➡️🛜 [Request]\n%@", log: log, type: .debug, data)
            
        case let .response(data):
            os_log("⬅️🛜 [Response]\n %@", log: log, type: .debug, data)
            
        case let .message(message):
            os_log("✉️ [Message]\n %@", log: log, type: .info, message)
            
        case let .deinitialization(data):
            os_log("♻️ %@", log: log, type: .debug, data)
        }
        
        #endif
    }
}

public extension Debug {
    enum LogType {
        case error(Error)
        case network_apollo(String)
        case request(String)
        case response(String)
        case deinitialization(String)
        case message(String)
//        case analyticsEvent(AnalyticsEventDebugData)
        
        var category: String {
            switch self {
            case .error: "Error"
            case .network_apollo, .request, .response: "Apollo Network"
            case .deinitialization: "Deinit"
            case .message: "Message"
//            case .analyticsEvent: "Analytics"
            }
        }
        
        var subsystem: String {
            switch self {
            case .error: "com.lodgelink.error"
            case .network_apollo, .request, .response: "com.lodgelink.Apollo"
            case .deinitialization: "com.lodgelink.deinit"
            case .message: "com.lodgelink.message"
//            case .analyticsEvent: "com.lodgelink.analytics"
            }
        }
        
        var availabilityType: AvailableLogType {
            switch self {
            case .error: .error
            case .network_apollo, .request, .response: .network_apollo
            case .deinitialization: .deinit
            case .message: .message
//            case .analyticsEvent: .analyticsEvent
            }
        }
        
        enum AvailableLogType: CaseIterable {
            case error, network_apollo, `deinit`, message, analyticsEvent
        }
    }
}
