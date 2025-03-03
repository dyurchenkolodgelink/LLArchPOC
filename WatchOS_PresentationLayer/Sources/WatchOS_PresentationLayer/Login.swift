//
//  SwiftUIView.swift
//  WatchOS_PresentationLayer
//
//  Created by Dmytro Yurchenko on 2025-01-31.
//

import SwiftUI
import PresentationLayer

struct SwiftUIView: View {
    var body: some View {
        Button(action: {}) {
            Text("Enter the Wonderland")
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(Color.primaryGreen)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    SwiftUIView()
}
