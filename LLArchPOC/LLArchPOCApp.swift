//
//  LLArchPOCApp.swift
//  LLArchPOC
//
//  Created by Dmytro Yurchenko on 2025-01-30.
//

import SwiftUI
import iOS_PresentationLayer

@main
struct LLArchPOCApp: App {
    let applicationDependencyContainer: ApplicationDependencyContainer
    
    @StateObject var applicationCoordinator: AppCoordinator
    
    init() {
        applicationDependencyContainer = ApplicationDependencyContainer()
        
        let applicationCoordinator = applicationDependencyContainer.coordinatorsFactory.makeAppCoordinator()
        
        _applicationCoordinator = StateObject(wrappedValue: applicationCoordinator)
    }
}

extension LLArchPOCApp {
    var body: some Scene {
        WindowGroup {
            applicationCoordinator.makeRouterView()
        }
    }
}
