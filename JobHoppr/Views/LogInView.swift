//
//  LogInView.swift
//  JobHoppr
//
//  Created by Jason Mandozzi on 4/20/24.
//

import SwiftUI

struct LogInView: View {
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack(spacing: 45) {
            Text("Log in")
                .font(.customFont(type: .semiBold, size: .xtraLarge))
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            TextFieldComponent(placeholder: "Email", 
                               text: $email)
            TextFieldComponent(placeholder: "Password", 
                               text: $password,
                               isSecure: true)
            Spacer()
            ButtonComponent(title: "Submit") {}
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.primaryBackground)
    }
}

#Preview {
    LogInView()
}
