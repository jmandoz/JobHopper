//
//  HomeView.swift
//  JobHoppr
//
//  Created by Jason Mandozzi on 3/10/24.
//

import SwiftUI

struct HomeView: View {
    @Namespace var namespace
    @StateObject var viewModel = ListViewModel()
    @ObservedObject var authManager: AuthManager
    
    @State var offsetY: CGFloat = 0
    @State var offsetX: CGFloat = 0
    @State var scale: CGFloat = 1
    @State var showDetail = false
    @State var showProfileView = false
    
    private let detailOpenDuration = 0.2
    
    private let deviceHeight = UIScreen.self.main.bounds.height
    private let deviceWidth = UIScreen.self.main.bounds.width
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                // Main home view
                homeView(height: proxy.size.height)
                
                // full screen detail view
                if showDetail, let selectedJob = viewModel.selectedJob {
                    JobDetailView(namespace: namespace,
                                  showDetail: $showDetail,
                                  job: selectedJob)
                    .offset(y: offsetY)
                    .scaleEffect(scale)
                    .gesture(
                        DragGesture()
                            .onChanged(onDrag(_:))
                            .onEnded(onDragEnd(_:))
                    )
                    .frame(width: proxy.size.width,
                           height: proxy.size.height)
                    
                }
            }
            .frame(maxWidth: .infinity)
            .background(.primaryBackground)
            .fullScreenCover(isPresented: $showProfileView, content: {
                VStack {
                    Text("Sign out")
                        .font(.customFont(type: .book, size: .xtraLarge))
                    ButtonComponent(title: "Sign Out", buttonStyle: .filled) {
                        authManager.signOut {
                            showProfileView = false
                        }
                    }
                    
                    ButtonComponent(title: "Dismiss", buttonStyle: .plain) {
                        showProfileView = false
                    }
                }
            })
        }
    }
    
    private func homeView(height: CGFloat) -> some View {
        VStack {
            headerView(height: height)
            Spacer()
            ListView(viewModel: viewModel,
                     showDetail: $showDetail,
                     namespace: namespace)
        }
    }
    
    private func headerView(height: CGFloat) -> some View {
        ZStack(alignment: .top) {
            // Background
            headerBackground(height: height)
            // Foreground
            headerForeground()
        }
    }
    
    private func headerForeground() -> some View {
        VStack {
            ZStack {
                Text("JobHoppr")
                    .font(.customFont(type: .heavy, size: .medium))
                
                HStack(alignment: .center) {
                    Image("profilePicture")
                        .resizable()
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .shadow(radius: 2)
                        .onTapGesture {
                            showProfileView = true
                        }
                    Spacer()
                    Image(systemName: "bell.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
            }
            Text("Welcome back, Jason")
                .font(.customFont(type: .book, size: .large))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 15)
                .padding(.bottom, 30)
            HStack(spacing: 16) {
                homeCard(number: "3", label: "Interviews lined up")
                homeCard(number: "1", label: "Intro call scheduled")
            }
        }
        .padding()
    }
    
    private func headerBackground(height: CGFloat) -> some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .ignoresSafeArea(.all)
                .frame(height: height / 3.3)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.primary500)
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
                            .font(.customFont(type: .semiBold, size: .xtraLarge))
                            .truncationMode(.tail)
                            .padding(8)
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        Text(label)
                            .font(.customFont(type: .medium, size: .small))
                            .truncationMode(.tail)
                            .lineSpacing(6)
                        Spacer()
                    }
                }
                .padding()
            }
    }
    
    private func onDrag(_ value: DragGesture.Value) {
        let dy = value.translation.height
        if dy >= 0 {
            offsetY = dy
            scale = 1 - ((dy/deviceHeight)/6)
        }
    }
    
    private func onDragEnd(_ value: DragGesture.Value) {
        let dy = value.translation.height
        if dy >= 0 {
            if dy <= deviceHeight / 7.5 {
                withAnimation(.snappy(duration: 0.2)) {
                    offsetY = 0
                    scale = 1
                }
            } else {
                viewModel.selectedJob = nil
                withAnimation(.snappy(duration: 0.2)) {
                    showDetail.toggle()
                } completion: {
                    offsetY = 0
                    scale = 1
                }
            }
        }
    }
}

#Preview {
    HomeView(authManager: .init())
}
