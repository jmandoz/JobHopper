//
//  ContentView.swift
//  JobHoppr
//
//  Created by Jason Mandozzi on 3/10/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager
    @State var isPresentingLogin = false
    @State var selectedTab = 2
    var body: some View {
        VStack {
            if authManager.authState != .signedOut {
                HomeView()
            } else {
                LogInView()
            }
        }
    }
    
    private func loadingView() -> some View {
        VStack {
            Spacer()
            Text("Loading")
            Spacer()
        }
    }
    
    func onLogInDismiss() {
        
    }
}

#Preview {
    ContentView()
}
