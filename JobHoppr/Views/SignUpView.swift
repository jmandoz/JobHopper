//
//  SignUpView.swift
//  JobHoppr
//
//  Created by Jason Mandozzi on 4/20/24.
//

import SwiftUI

struct SignUpView: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    
    var body: some View {
        VStack(spacing: 45) {
            Text("Log in")
                .font(.customFont(type: .semiBold, size: .xtraLarge))
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            TextFieldComponent(placeholder: "Email", text: $firstName)
            TextFieldComponent(placeholder: "Password", text: $lastName)
            Spacer()
            ButtonComponent(title: "Submit") {}
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.primaryBackground)
    }
}

#Preview {
    SignUpView()
}
