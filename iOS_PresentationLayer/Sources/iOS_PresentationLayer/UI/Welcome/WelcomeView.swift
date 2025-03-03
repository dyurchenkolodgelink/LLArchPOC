//
//  WelcomeView.swift
//  iOS_PresentationLayer
//
//  Created by Dmytro Yurchenko on 2025-01-31.
//

import SwiftUI
import PresentationLayer

struct WelcomeView: View {
    let onEnter: () -> Void
    
    var body: some View {
        Button(action: {}) {
            Text("welcome.button.title")
                .foregroundStyle(.white)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(Color.primaryGreen)
        }
    }
}

#Preview {
    WelcomeView(onEnter: {})
}

extension Text {
    init(_ textKey: LocalizedStringKey) {
        self.init(textKey, bundle: .module)
    }
}
