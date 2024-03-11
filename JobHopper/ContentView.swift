//
//  ContentView.swift
//  JobHopper
//
//  Created by Jason Mandozzi on 3/10/24.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab = 2
    var body: some View {
        TabView(selection: $selectedTab,
                content:  {
            ListView()
                .tabItem {
                    Image(systemName: "list.bullet.rectangle")
            }.tag(1)
            
            HomeView()
                .tabItem {
                    Image(systemName: "house")
            }.tag(2)
            
            AccountView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
            }.tag(3)
        })
    }
}

#Preview {
    ContentView()
}
