//
//  LoadingComponent.swift
//  JobHoppr
//
//  Created by Jason Mandozzi on 6/2/24.
//

import SwiftUI

struct LoadingComponent: View {
 
    @State private var isLoading = false
    
    private let height: CGFloat = 75
    private let width: CGFloat = 75
 
    var body: some View {
        ZStack {
            Circle()
                .stroke(.primary800.opacity(0.4), lineWidth: 18)
                .frame(width: width, height: height)
            
            Circle()
                .trim(from: 0, to: 0.2)
                .stroke(.primary200, lineWidth: 14)
                .frame(width: width, height: height)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                .animation(
                    .linear(duration: 0.7)
                    .repeatForever(autoreverses: false),
                    value: isLoading)
                .onAppear() {
                    self.isLoading = true
                }
        }
    }
}

#Preview {
    LoadingComponent()
}
