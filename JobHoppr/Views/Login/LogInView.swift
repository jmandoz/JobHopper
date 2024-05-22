//
//  LogInView.swift
//  JobHoppr
//
//  Created by Jason Mandozzi on 4/20/24.
//

import SwiftUI
import FirebaseAuth

struct LogInView: View {
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 45) {
                Text("Log in")
                    .font(.customFont(type: .semiBold, size: .xtraLarge))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom)
                TextFieldComponent(placeholder: "Email",
                                   text: $email)
                TextFieldComponent(placeholder: "Password",
                                   text: $password,
                                   isSecure: true)
                Spacer()
                ButtonComponent(title: "Submit", buttonStyle: .filled) {
                    Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                        if var error {
                           print(error)
                        }
                        if var authResult {
                            print(authResult)
                        }
                    }
                }
                NavigationLink(destination: SignUpView()) {
                    Text("Sign up")
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.primaryBackground)
        }
        .navigationBarTitleDisplayMode(.inline)
        .tint(.primary200)
    }
}

#Preview {
    LogInView()
}
