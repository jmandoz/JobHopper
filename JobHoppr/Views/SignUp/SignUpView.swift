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
    @State var showLoading: Bool = false
    
    var body: some View {
            VStack(spacing: 30) {
                TextFieldComponent(placeholder: "First Name", text: $firstName)
                    .padding(.top, 40)
                TextFieldComponent(placeholder: "Last Name", text: $lastName)
                TextFieldComponent(placeholder: "Email", text: $email)
                TextFieldComponent(placeholder: "Password", text: $password)
                Spacer()
                ButtonComponent(title: "Submit", buttonStyle: .filled) {
                    showLoading = true
                    authManager.createUser(email: email, password: password) {
                        showLoading = false
                    }
                }
            }
            .padding()
            .background(.primaryBackground)
            .navigationTitle("Sign Up")
            .hasErrorView(withMessage: authManager.authError?.rawValue ?? "Error", show: $authManager.showError)
            .hasLoadingView(withMessage: "Loading...", show: $showLoading)
    }
}

#Preview {
    SignUpView(authManager: .init())
}
