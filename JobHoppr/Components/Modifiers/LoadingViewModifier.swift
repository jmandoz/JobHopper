//
//  LoadingViewModifier.swift
//  JobHoppr
//
//  Created by Jason Mandozzi on 6/2/24.
//

import Foundation
import SwiftUI

struct LoadingViewModifier: ViewModifier {
    let message: String
    @Binding var showLoading: Bool
    func body(content: Content) -> some View {
        if showLoading {
            VStack {
                LoadingComponent()
                Text(message)
                    .font(.customFont(type: .book, size: .medium))
            }
        } else {
            content
        }
    }
}

extension View {
    func hasLoadingView(withMessage text: String, show: Binding<Bool>) -> some View {
        modifier(LoadingViewModifier(message: text, showLoading: show))
    }
}
