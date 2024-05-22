//
//  ButtonComponent.swift
//  JobHoppr
//
//  Created by Jason Mandozzi on 4/20/24.
//

import SwiftUI

struct ButtonComponent: View {
    let title: String
    @State var buttonStyle: JHButtonStyle
    let action: (() -> Void)?
    
    var body: some View {
        Button(action: {
            if let action = action {
                action()
            }
        }, label: {
            RoundedRectangle(cornerRadius: 18)
                .foregroundStyle(buttonStyle == .filled ? .primary500 : .clear)
                .overlay {
                    Text(title)
                        .font(.customFont(type: .bold, size: .small))
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(buttonStyle == .filled ? .primary900 : .primary500)
                }
                .frame(height: 50)
        })
        .frame(maxWidth: .infinity)
    }
}

enum JHButtonStyle {
    case filled
    case plain
}

#Preview {
    VStack {
        ButtonComponent(title: "Title", buttonStyle: .filled) {
            print("action")
        }
        ButtonComponent(title: "Title", buttonStyle: .plain) {
            print("action")
        }
    }
}
