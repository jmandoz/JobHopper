//
//  ErrorViewModifier.swift
//  JobHoppr
//
//  Created by Jason Mandozzi on 5/30/24.
//

import Foundation
import SwiftUI

struct ErrorViewModifier: ViewModifier {
    let text: String
    @Binding var show: Bool
    @State var timeRemaining = 3
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    func body(content: Content) -> some View {
        ZStack {
            content
            VStack {
                Spacer()
                RoundedRectangle(cornerRadius: 18)
                    .transition(.move(edge: .bottom))
                    .frame(height: 60)
                    .foregroundStyle(Color.red)
                    .overlay {
                        Text(text)
                            .font(.customFont(type: .bold, size: .small))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                    }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()
            .background(.clear)
            .offset(y: show ? 0 : 110)
            .animation(.bouncy, value: show)
            .opacity(show ? 1 : 0)
            .onReceive(timer, perform: { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    withAnimation {
                        show = false
                    }
                    timeRemaining = 3
                }
            })
        }
    }
}

extension View {
    func hasErrorView(withMessage text: String, show: Binding<Bool>) -> some View {
        modifier(ErrorViewModifier(text: text, show: show))
    }
}

#Preview {
    struct DemoView: View {
        @State var show: Bool = false
        var body: some View {
            VStack {
                Text("Here's a view")
                    .padding(.vertical)
                Button("Trigger error view") {
                    withAnimation {
                        show.toggle()
                    }
                }
            }
            .hasErrorView(withMessage: "Message", show: $show)
        }
    }
    return DemoView()
}
