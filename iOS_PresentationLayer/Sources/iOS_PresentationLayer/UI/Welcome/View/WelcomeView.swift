//
// NameView.swift
// iOS_PresentationLayer
//
// Created by NameView on 2025-03-04
//

import SwiftUI
import PresentationLayer

struct WelcomeView: LLView {
    @ObservedObject var viewModel: WelcomeViewModel
    
    var content: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading user...")
                    .foregroundStyle(Color.primaryGreen)
                    .tint(Color.primaryGreen)
                    .padding()
            } else if let user = viewModel.user {
                VStack {
                    HStack {
                        Text(user.firstName.value)
                        Text(user.lastName.value)
                    }
                    
                    Text(user.email.value)
                }
            } else {
                Text("Failed to get a user")
            }
            
            Spacer()
            
            Button(action: viewModel.signOut) {
                Text("welcome.signOut.title".localized)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.primaryGreen)
                    }
            }
        }
        .padding()
    }
}

#Preview {
    WelcomeView(viewModel: .fake())
}
