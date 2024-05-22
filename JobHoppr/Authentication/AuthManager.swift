//
//  AuthManager.swift
//  JobHoppr
//
//  Created by Jason Mandozzi on 5/21/24.
//

import Foundation
import AuthenticationServices
import FirebaseAuth
import FirebaseCore

enum AuthState {
    case authenticated // Anonymously authenticated in Firebase.
    case signedIn // Authenticated in Firebase using one of service providers, and not anonymous.
    case signedOut // Not authenticated in Firebase.
}

class AuthManager: ObservableObject {
    @Published var user: User?
    @Published var authState: AuthState = .signedOut
    
    private var authStateListener: AuthStateDidChangeListenerHandle?
    
    init() {
        configureInitialAuthState()
    }
    
    private func configureInitialAuthState() {
        authStateListener = Auth.auth().addStateDidChangeListener({ auth, user in
            print(auth.currentUser?.email ?? "no user email found")
            if let user = user {
                print(user.displayName ?? "display name is nil")
                self.updateState(user: user)
            }
        })
    }
    
    private func updateState(user: User?) {
        self.user = user
        let isAuthenticatedUser = user != nil
        let isAnonymous = user?.isAnonymous ?? false

        if isAuthenticatedUser {
            self.authState = isAnonymous ? .authenticated : .signedIn
        } else {
            self.authState = .signedOut
        }
    }
}
