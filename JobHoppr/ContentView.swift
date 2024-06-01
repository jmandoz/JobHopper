//
//  ContentView.swift
//  JobHoppr
//
//  Created by Jason Mandozzi on 3/10/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var authManager: AuthManager
    @State var isPresentingLogin = false
    @State var selectedTab = 2
    var body: some View {
        VStack {
//            if authManager.isLoading {
//                loadingView()
//            } else {
                if authManager.authState != .signedOut {
                    HomeView(authManager: authManager)
                } else {
                    LogInView(authManager: authManager)
                }
//            }
        }
    }
    
    private func loadingView() -> some View {
        VStack {
            Spacer()
            Text("Loading")
            Spacer()
        }
    }
}

#Preview {
    ContentView(authManager: .init())
}
