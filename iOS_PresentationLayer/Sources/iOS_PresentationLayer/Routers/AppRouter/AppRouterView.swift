//
//  AppRouterView.swift
//  LodgeLink
//
//  Created by Jim Niemann on 3/2/22.
//

import SwiftUI

struct AppRouterView: View {
    @ObservedObject var coordinator: AppCoordinator
    @ObservedObject var viewModel: AppRouterViewModel
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        coordinator.getNextFlowItemView(for: coordinator.selectedFlowItem)
            .onChange(of: viewModel.authentication) { _, authentication in
                switch authentication {
                case .authenticated:
                    coordinator.moveToMainCoordinator()
                    
                case .unauthenticated:
                    coordinator.moveToAuthCoordinator()
                }
            }
    }
}
