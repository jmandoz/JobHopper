//
//  TextFieldComponent.swift
//  JobHoppr
//
//  Created by Jason Mandozzi on 4/20/24.
//

import SwiftUI

struct TextFieldComponent: View {
    let placeholder: String
    @Binding var text: String
    
    let isSecure: Bool
    @FocusState private var isFocused: Bool
    @State private var movePlaceholder: Bool = false
    
    init(placeholder: String = "", 
         text: Binding<String>,
         isSecure: Bool = false) {
        self.placeholder = placeholder
        self._text = text
        self.isSecure = isSecure
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(height: 65)
                .foregroundStyle(.gray.opacity(0.2))
            Text(placeholder)
                .font(.customFont(type: .light, size: .small))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .offset(y: movePlaceholder ? -50 : !text.isEmpty ? -50 : 0)
                .onChange(of: isFocused) {
                    withAnimation(.smooth) {
                        movePlaceholder.toggle()
                    }
                }
            Group {
                if isSecure {
                    SecureField("", text: $text)
                } else {
                    TextField("", text: $text)
                }
            }
            .padding(.leading)
            .focused($isFocused)
            .font(.customFont(type: .semiBold, size: .small))
        }
    }
}

#Preview {
    @State var text: String = ""
    return TextFieldComponent(placeholder: "First Name", text: $text)
}
