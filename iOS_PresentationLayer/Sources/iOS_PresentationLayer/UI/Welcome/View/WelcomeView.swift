//
// NameView.swift
// iOS_PresentationLayer
//
// Created by NameView on 2025-03-04
//

import SwiftUI
import PresentationLayer

struct WelcomeView: View {
    @ObservedObject var viewModel: WelcomeViewModel
    
    var body: some View {
        VStack {
            Button(action: viewModel.signOut) {
                Text("Sign Out")
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.primaryGreen)
                    }
            }
        }
    }
}

#Preview {
    WelcomeView(viewModel: .fake())
}
