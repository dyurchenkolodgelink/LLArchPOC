//
//  File.swift
//  iOS_PresentationLayer
//
//  Created by Dmytro Yurchenko on 2025-03-04.
//

import SwiftUI

extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
    
//    func shadowed(
//        radius: CGFloat = 5,
//        x: CGFloat = 0,
//        y: CGFloat = 3
//    ) -> some View {
//
//        shadow(
//            color: .shadowColor.opacity(0.7),
//            radius: radius,
//            x: x,
//            y: y
//        )
//    }
    
    @ViewBuilder
    func bottomSheet<Content: View, S: ShapeStyle>(
        presentationDetents: Set<PresentationDetent>,
        selectedDetent: Binding<PresentationDetent>,
        background: S,
        isPresented: Binding<Bool>,
        dragIndicator: Visibility = .visible,
        sheetCornerRadius: CGFloat?,
        largestUndimmedIdentifier: UISheetPresentationController.Detent.Identifier = .large,
        isTransparentBackground: Bool = false,
        @ViewBuilder content: @escaping () -> Content,
        interactiveDismissDisabled: Bool,
        onDismiss: @escaping () -> Void
    ) -> some View {
        sheet(
            isPresented: isPresented,
            onDismiss: onDismiss,
            content: {
                content()
                    .ignoresSafeArea()
                    .presentationBackgroundInteraction(.enabled(upThrough: .medium))
                    .presentationDetents(presentationDetents, selection: selectedDetent)
                    .presentationDragIndicator(dragIndicator)
                    .presentationBackground(background)
                    .interactiveDismissDisabled(interactiveDismissDisabled)
                    .onAppear {
                        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                              let presentedController = scene.windows.first?.rootViewController?.presentedViewController,
                              let sheetController = presentedController.presentationController as? UISheetPresentationController
                        else { return }
                        
                        sheetController.largestUndimmedDetentIdentifier = largestUndimmedIdentifier
                        sheetController.preferredCornerRadius = sheetCornerRadius
                    }
            }
        )
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    @ViewBuilder
    func hideScrollContentBackground() -> some View {
        if #available(iOS 16.0, *) {
            scrollContentBackground(.hidden)
        } else {
            self
        }
    }
    
    func onNotification(_ notificationName: Notification.Name,
                        perform action: @escaping () -> Void) -> some View {
        onReceive(NotificationCenter.default.publisher(for: notificationName)) { _ in
            action()
        }
    }
    
    func onNotification(_ notificationName: Notification.Name,
                        perform action: @escaping (Notification) -> Void) -> some View {
        onReceive(NotificationCenter.default.publisher(for: notificationName)) { notification in
            action(notification)
        }
    }
    
    @ViewBuilder
    func height(_ value: CGFloat?) -> some View {
        frame(height: value)
    }
    
    @ViewBuilder
    func dismissKeyboardOnScroll() -> some View {
        if #available(iOS 16.0, *) {
            scrollDismissesKeyboard(ScrollDismissesKeyboardMode.immediately)
        } else {
            gesture(DragGesture()
                .onChanged { _ in
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            )
        }
    }
    
    @ViewBuilder
    func errorAlert(
        message: Binding<String?>,
        action: @escaping () -> Void = {}
    ) -> some View {
        alert(
            Text("error.title"),
            isPresented: .init(
                get: {
                    !message.wrappedValue.isNilOrEmpty
                },
                set: {
                    if !$0 {
                        message.wrappedValue = nil
                    }
                }),
            actions: {
                Button("button.ok", role: .cancel, action: action)
            },
            message: {
                if let message = message.wrappedValue {
                    Text(message)
                }
            })
    }
    
    @ViewBuilder
    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewDidLoadModifier(action: action))
    }
    
    @ViewBuilder
    func padding(allExcept edge: Edge.Set, _ length: CGFloat? = nil) -> some View {
        let edge: Edge.Set = {
            var newEdgeSet: Edge.Set = .all
            
            _ = newEdgeSet.remove(edge)
            
            return newEdgeSet
        }()
        
        
        padding(edge, length)
    }
    
    @ViewBuilder
    func accessibilityId<T>(_ identifier: T, file: StaticString = #file) -> some View where T: RawRepresentable, T.RawValue == String {
        let combinedIdentifier: String = [
            file.description.components(separatedBy: "/").last?.components(separatedBy: ".").first,
            String(describing: type(of: identifier)),
            identifier.rawValue
        ].compactMap { $0 }.joined(separator: ".")
        
        accessibilityIdentifier(combinedIdentifier)
    }
    
    @ViewBuilder
    func dividedHorizontally<S: ShapeStyle>(_ count: Int, _ style: S) -> some View {
        background {
            GeometryReader { geometry in
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(style)
                        .padding(.trailing, 2)
                    
                    let numberOfDividers: Int = count - 1
                    
                    if numberOfDividers > 0 {
                        HStack(spacing: geometry.size.width / CGFloat(count)) {
                            ForEach(0..<numberOfDividers, id: \.self) { _ in
                                Divider()
                                    .opacity(0)
                                    .frame(width: 1.5)
                                    .overlay(style.opacity(0.5))
                            }
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func successFeedback(trigger: Binding<Bool>) -> some View {
        if #available(iOS 17.0, *) {
            sensoryFeedback(.impact(weight: .light), trigger: trigger.wrappedValue)
        } else {
            onChange(of: trigger.wrappedValue, perform: { value in
                guard value else { return }
                
                let generator = UIImpactFeedbackGenerator(style: .light)
                
                generator.impactOccurred()
                
                trigger.wrappedValue = false
            })
        }
    }
    
    @ViewBuilder
    func show(_ condition: Bool) -> some View {
        if condition {
            self
        }
    }
    
    @ViewBuilder
    func disabledAction(_ disabled: Bool) -> some View {
        self.disabled(disabled)
            .opacity(disabled ? 0.4 : 1.0)
    }
}

private struct ViewDidLoadModifier: ViewModifier {
    @State private var viewDidLoad: Bool = false
    
    let action: (() -> Void)?
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                guard !viewDidLoad else { return }
                
                viewDidLoad = true
                
                action?()
            }
    }
}
