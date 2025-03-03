//
//  LLArchPOCApp.swift
//  LLArchPOC
//
//  Created by Dmytro Yurchenko on 2025-01-30.
//

import SwiftUI
import DomainLayer
import DataLayer
import iOS_PresentationLayer

@main
struct LLArchPOCApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(user: .fake())
        }
    }
}
