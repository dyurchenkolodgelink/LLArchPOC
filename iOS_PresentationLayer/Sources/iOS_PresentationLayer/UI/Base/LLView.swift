//
//  LLView.swift
//  LodgeLink
//
//  Created by Dmytro Yurchenko on 2024-08-07.
//

import SwiftUI

protocol LLView: View {
    associatedtype Content: View
    associatedtype VM: ViewModel
    
    @ViewBuilder @MainActor var content: Content { get }
    
    var viewModel: VM { get set }
    
    func onDismissError()
}

extension LLView {
    private var observedViewModel: ObservedObject<VM> {
        ObservedObject(wrappedValue: viewModel)
    }
    
    @MainActor
    var body: some View {
        content
            .onLoad(perform: viewModel.onViewLoaded)
            .errorAlert(
                message: observedViewModel.projectedValue.errorMessage,
                action: onDismissError
            )
    }
    
    func onDismissError() {}
}

private struct DummyView: LLView {
    @ObservedObject var viewModel: LoginViewModel
    
    var content: some View {
        VStack {
            Text("Fake Text")
            
            Button(action: {}) {
                Text("Fake Button")
            }
        }
    }
}

#Preview {
    DummyView(viewModel: .fake())
}
