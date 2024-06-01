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
    func signOut(completion: (() -> Void)?) async
    func signIn(with email: String, password: String, completion: (() -> Void)?) async
    func createUser(email: String, password: String, displayName: String?, completion: (() -> Void)?) async
}

@MainActor 
class AuthManager: ObservableObject {
    @Published var user: User?
    @Published var authState: AuthState = .signedOut
    @Published var authError: AuthenticationError?
    @Published var isLoading = true
    @Published var showError = false
    @Published var errorText: String = ""
    
    private var authStateListener: AuthStateDidChangeListenerHandle?
    
    init() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.configureInitialAuthState()
        }
    }
    
    private func configureInitialAuthState() {
        isLoading = true
        authStateListener = Auth.auth().addStateDidChangeListener({ auth, user in
            if let user = user {
                print(user.displayName ?? "display name is nil")
                self.updateState(user: user)
            } else {
                self.updateState(user: nil)
            }
            self.isLoading = false
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
    
    private func signOut(completion: (() -> Void)? = nil) async throws {
        if let _ = Auth.auth().currentUser {
            isLoading = true
            do {
                try Auth.auth().signOut()
                if let completion {
                    completion()
                }
            }
            catch let error as NSError {
                print(error.localizedDescription)
                throw error
            }
            isLoading = false
        }
    }
    
    private func signIn(with email: String, 
                        password: String,
                        completion: (() -> Void)? = nil) async throws {
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
            if let completion {
                completion()
            }
        } catch {
            print(error.localizedDescription)
            triggerError(with: .incorrectEmailOrPassword)
            throw error
        }
    }
    
    private func createUser(with email: String, 
                            password: String,
                            displayName: String? = nil,
                            completion: (() -> Void)? = nil) async throws {
        do {
            try await Auth.auth().createUser(withEmail: email, password: password)
            if let completion {
                completion()
            }
        } catch {
            print(error.localizedDescription)
            triggerError(with: authError)
            isLoading = false
            throw error
        }
    }
    
    private func updateUser(displayName: String) {
        
    }
    
    private func triggerError(with message: AuthenticationError?) {
        errorText = message?.rawValue ?? ""
        showError = true
    }
}

extension AuthManager: UserManaging {
    func signOut(completion: (() -> Void)? = nil) {
        Task {
            self.isLoading = true
            try await signOut()
            if let completion = completion {
                completion()
                isLoading = false
            }
        }
    }
    
    func signIn(with email: String,
                password: String,
                completion: (() -> Void)? = nil) {
        Task {
            isLoading = true
            try await signIn(with: email, password: password)
            if let completion = completion {
                completion()
            }
            isLoading = false
        }
    }
    
    func createUser(email: String,
                    password: String,
                    displayName: String? = nil,
                    completion: (() -> Void)? = nil) {
        Task {
            isLoading = true
            try await createUser(with: email, password: password)
            if let displayName = displayName {
                
            }
            if let completion = completion {
                completion()
            }
            isLoading = false
        }
    }
}

enum AuthenticationError: String {
    case incorrectEmailOrPassword = "You have entered an incorrect email or password"
    case cannotCreateUser = "We couldn't create your account"
}
