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
                TextFieldComponent(placeholder: "Email",
                                   text: $email)
                .padding(.top, 40)
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
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Log in")
            .padding()
            .background(.primaryBackground)
            .hasErrorView(withMessage: authManager.authError?.rawValue ?? "Error", show: $authManager.showError)
            .hasLoadingView(withMessage: "Loading...", show: $showLoading)
        }
        .tint(.primary200)
    }
}

#Preview {
    LogInView(authManager: .init())
}
