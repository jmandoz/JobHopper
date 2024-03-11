//
//  HomeView.swift
//  JobHopper
//
//  Created by Jason Mandozzi on 3/10/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                HStack(alignment: .center) {
                    Text("Welcome back, Jason")
                        .font(.JHtitleXtraLarge)
                    Spacer()
                    Image(systemName: "bell.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
                .padding(.bottom)
                Text("You have 3 tasks for today")
                    .font(.JHtitleMedium)
                homeCard(number: "0/3 tasks completed", label: "Complete your tasks to hit your job search goal")
                    .padding(.bottom, 8)
                HStack(spacing: 16) {
                    homeCard(number: "3", label: "Interviews lined up")
                    homeCard(number: "1", label: "Intro call scheduled")
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
        .padding()
    }
    
    private func homeCard(number: String, label: String) -> some View {
        RoundedRectangle(cornerRadius: 24)
            .frame(height: 150)
            .foregroundStyle(.blue)
            .overlay {
                VStack {
                    HStack {
                        Text(number)
                            .font(.JHtitleXtraLarge)
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        Text(label)
                            .font(.JHtitleMedium)
                        Spacer()
                    }
                }
                .padding()
            }
    }
}

#Preview {
    HomeView()
}
