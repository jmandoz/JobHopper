//
//  ButtonComponent.swift
//  JobHoppr
//
//  Created by Jason Mandozzi on 4/20/24.
//

import SwiftUI

struct ButtonComponent: View {
    let title: String
    let action: (() -> Void)?
    
    var body: some View {
        Button(action: {
            if let action = action {
                action()
            }
        }, label: {
            RoundedRectangle(cornerRadius: 50)
                .foregroundStyle(.primary500)
                .overlay {
                    Text("Update")
                        .font(.customFont(type: .bold, size: .small))
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.primary900)
                }
                .frame(height: 50)
        })
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ButtonComponent(title: "Title") {
        print("action")
    }
}
