//
//  ToastModifier.swift
//  Task
//
//  Created by Sahitya on 12/08/24.
//

import SwiftUI

struct ToastModifier: ViewModifier {
    let message: String
    @Binding var isShowing: Bool
    let duration: Double

    func body(content: Content) -> some View {
        ZStack {
            content
            if isShowing {
                VStack {
                    Spacer()
                    Text(message)
                        .padding()
                        .background(Color.black.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.bottom, 50)
                        .transition(.move(edge: .bottom))
                        .animation(.easeInOut(duration: 0.5))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                                withAnimation {
                                    isShowing = false
                                }
                            }
                        }
                }
                .padding()
            }
        }
    }
}

extension View {
    func toast(message: String, isShowing: Binding<Bool>, duration: Double = 2.0) -> some View {
        self.modifier(ToastModifier(message: message, isShowing: isShowing, duration: duration))
    }
}
