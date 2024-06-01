//
//  SignUpView.swift
//  JobHoppr
//
//  Created by Jason Mandozzi on 4/20/24.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    @ObservedObject var authManager: AuthManager
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
            VStack(spacing: 45) {
                Text("Sign Up")
                    .font(.customFont(type: .semiBold, size: .xtraLarge))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom)
                TextFieldComponent(placeholder: "First Name", text: $firstName)
                TextFieldComponent(placeholder: "Last Name", text: $lastName)
                TextFieldComponent(placeholder: "Email", text: $email)
                TextFieldComponent(placeholder: "Password", text: $password)
                Spacer()
                ButtonComponent(title: "Submit", buttonStyle: .filled) {
                    authManager.createUser(email: email, password: password)
                }
            }
            .padding()
            .background(.primaryBackground)
            .hasErrorView(withMessage: "Error", show: $authManager.showError)
    }
}

#Preview {
    SignUpView(authManager: .init())
}
