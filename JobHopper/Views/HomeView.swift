//
//  HomeView.swift
//  JobHopper
//
//  Created by Jason Mandozzi on 3/10/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                // Background
                headerBackground(height: proxy.size.height)
                // Foreground
                headerForeground()
            }
            .background(.primary900.opacity(0.6))
        }
    }
    
    private func headerForeground() -> some View {
        VStack {
            ZStack {
                Text("JobHoppr")
                    .font(.customFont(type: .heavyItalic, size: .mediun))
                HStack(alignment: .center) {
                    Image("profilePicture")
                        .resizable()
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .overlay {
                            Circle()
                                .stroke(.primary100.opacity(0.3), lineWidth: 2)
                                .scaleEffect(1.04)
                        }
                    Spacer()
                    Image(systemName: "bell.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
            }
            .padding(.bottom, 45)
            HStack(spacing: 16) {
                homeCard(number: "3", label: "Interviews lined up")
                homeCard(number: "1", label: "Intro call scheduled")
            }
            
            Spacer()
        }
        .padding()
    }
    
    private func headerBackground(height: CGFloat) -> some View {
        VStack {
            RoundedRectangle(cornerRadius: 8)
                .ignoresSafeArea(.all)
                .frame(height: height / 3.5)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.primary500)
            Spacer()
        }
    }
    
    private func homeCard(number: String, label: String) -> some View {
        RoundedRectangle(cornerRadius: 24)
            .shadow(radius: 3)
            .frame(height: 150)
            .foregroundStyle(.primary700)
            .overlay {
                VStack {
                    HStack {
                        Text(number)
                            .font(.customFont(type: .heavy, size: .xtraLarge))
                            .truncationMode(.tail)
                            .padding(8)
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        Text(label)
                            .font(.customFont(type: .heavy, size: .small))
                            .truncationMode(.tail)
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
