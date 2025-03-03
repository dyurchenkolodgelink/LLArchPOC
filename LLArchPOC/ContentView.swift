//
//  ContentView.swift
//  LLArchPOC
//
//  Created by Dmytro Yurchenko on 2025-01-30.
//

import SwiftUI
import DataLayer
import DomainLayer
import PresentationLayer

struct ContentView: View {
    let user: User
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView(user: .fake())
}
