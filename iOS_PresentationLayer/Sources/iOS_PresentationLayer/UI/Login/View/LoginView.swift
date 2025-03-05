//
// NameView.swift
// iOS_PresentationLayer
//
// Created by NameView on 2025-02-03
//

import SwiftUI
import PresentationLayer

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Group {
                TextField("login.email.placeholder".localized, text: $viewModel.email)
                TextField("login.password.placeholder".localized, text: $viewModel.password)
            }
            .textFieldStyle(.roundedBorder)
            
            Button(action: viewModel.login) {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    Text("login.button.title".localized)
                        .font(.title3).bold()
                        .foregroundStyle(.white)                    
                }
            }
            .padding()
            .padding(.horizontal, 20)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(Color.primaryGreen)
            }
        }
        .padding()
    }
}

#Preview {
    LoginView(viewModel: .fake())
}
