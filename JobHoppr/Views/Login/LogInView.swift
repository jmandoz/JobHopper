//
//  LogInView.swift
//  JobHoppr
//
//  Created by Jason Mandozzi on 4/20/24.
//

import SwiftUI
import FirebaseAuth

struct LogInView: View {
    @ObservedObject var authManager: AuthManager
    @State var email: String = ""
    @State var password: String = ""
    @State var showSignUp = false
    @State var showLoading = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 45) {
                Text("Log in")
                    .font(.customFont(type: .semiBold, size: .xtraLarge))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical)
                TextFieldComponent(placeholder: "Email",
                                   text: $email)
                TextFieldComponent(placeholder: "Password",
                                   text: $password,
                                   isSecure: true)
                Spacer()
                VStack {
                    ButtonComponent(title: "Submit", buttonStyle: .filled) {
                        showLoading = true
                        authManager.signIn(with: email, password: password) {
                            showLoading = false
                        }
                    }
                    ButtonComponent(title: "Sign Up", buttonStyle: .plain) {
                        showSignUp = true
                    }
                }
            }
            .navigationDestination(isPresented: $showSignUp, destination: {
                SignUpView(authManager: authManager)
            })
            .padding()
            .background(.primaryBackground)
            .hasErrorView(withMessage: "Error", show: $authManager.showError)
            
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Hello")
        .tint(.primary200)
    }
}

#Preview {
    LogInView(authManager: .init())
}
