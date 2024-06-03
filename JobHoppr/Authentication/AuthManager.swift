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

protocol UserManaging {
    func signOut(completion: @escaping (() -> Void)) async
    func signIn(with email: String, password: String, completion: @escaping (() -> Void)) async
    func createUser(email: String, password: String, displayName: String?, completion: @escaping (() -> Void)) async
}

@MainActor 
class AuthManager: ObservableObject {
    @Published var user: User?
    @Published var authState: AuthState = .signedOut
    @Published var authError: AuthenticationError?
    @Published var showError = false
    
    private var authStateListener: AuthStateDidChangeListenerHandle?
    
    init() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.configureInitialAuthState()
        }
    }
    
    private func configureInitialAuthState() {
        authStateListener = Auth.auth().addStateDidChangeListener({ auth, user in
            if let user = user {
                print(user.displayName ?? "display name is nil")
                self.updateState(user: user)
            } else {
                self.updateState(user: nil)
            }
        })
    }
    
    private func updateState(user: User?) {
        let isAuthenticatedUser = user != nil
        let isAnonymous = user?.isAnonymous ?? false
        self.user = user
        
        if isAuthenticatedUser {
            self.authState = isAnonymous ? .authenticated : .signedIn
        } else {
            self.authState = .signedOut
        }
    }
    
    private func signOut(completion: (() -> Void)) async throws {
        if let _ = Auth.auth().currentUser {
            do {
                try Auth.auth().signOut()
                completion()
            } catch let error as NSError {
                print(error.localizedDescription)
                completion()
                throw error
            }
        }
    }
    
    private func signIn(with email: String, 
                        password: String,
                        completion: (() -> Void)) async throws {
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
            completion()
        } catch {
            print(error.localizedDescription)
            triggerError(with: .incorrectEmailOrPassword)
            completion()
            throw error
        }
    }
    
    private func createUser(with email: String,
                            password: String,
                            displayName: String? = nil,
                            completion: (() -> Void)) async throws {
        do {
            try await Auth.auth().createUser(withEmail: email, password: password)
            completion()
        } catch {
            print(error.localizedDescription)
            triggerError(with: .cannotCreateUser)
            completion()
            throw error
        }
    }
    
    private func updateUser(displayName: String) {
        
    }
    
    private func triggerError(with message: AuthenticationError?) {
        authError = message
        showError = true
    }
}

extension AuthManager: UserManaging {
    
    func signOut(completion: @escaping (() -> Void)) {
        Task {
            try await signOut(completion: completion)
        }
    }
    
    func signIn(with email: String,
                password: String,
                completion: @escaping (() -> Void)) {
        Task {
            try await signIn(with: email, password: password, completion: completion)
        }
    }
    
    func createUser(email: String,
                    password: String,
                    displayName: String? = nil,
                    completion: @escaping (() -> Void)) {
        Task {
            try await createUser(with: email, password: password, completion: completion)
        }
    }
}

enum AuthenticationError: String {
    case incorrectEmailOrPassword = "You have entered an incorrect email or password"
    case cannotCreateUser = "We couldn't create your account"
}
