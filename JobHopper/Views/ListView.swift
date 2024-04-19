//
//  ListView.swift
//  JobHopper
//
//  Created by Jason Mandozzi on 3/10/24.
//

import SwiftUI

struct ListView: View {
    @Namespace var namespace
    @StateObject var viewModel = ListViewModel()
    @State var showDetail: Bool = false
    @State var selectedStatus: CandidateStatus?
    let statusSelectors: [CandidateStatus] = [.applied, .introCall, .interviewProcess]
    
    @State var offsetY: CGFloat = 0
    @State var offsetX: CGFloat = 0
    @State var scale: CGFloat = 1
    
    private let detailOpenDuration = 0.2
    
    private let deviceHeight = UIScreen.self.main.bounds.height
    private let deviceWidth = UIScreen.self.main.bounds.width
    
    var body: some View {
        ZStack {
            // list view
            VStack {
                headerView
                listView
            }
            .padding()
            if showDetail {
                RoundedRectangle(cornerRadius: 20.0)
                    .fill(.black)
                    .opacity(0.25)
                    .shadow(radius: 10.0)
                    .ignoresSafeArea()
            }
            
            // full screen detail view
            if showDetail, let selectedJob = viewModel.selectedJob {
                GeometryReader { proxy in
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
                    .frame(width: proxy.size.width, height: proxy.size.height)
                }
            }
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
    
    private var listView: some View {
        VStack {
            Picker("1", selection: $selectedStatus) {
                ForEach(statusSelectors) { item in
                    Text(item.rawValue)
                        .tag(CandidateStatus(rawValue: item.rawValue))
                }
            }
            .pickerStyle(.segmented)
            .padding(.bottom)
            
            ScrollView(showsIndicators: false) {
                ForEach(viewModel.jobOpenings) { job in
                    ZStack {
                        JobCardComponent(namespace: namespace,
                                job: job,
                                showDetail: $showDetail) {
                            withAnimation(.snappy(duration: 0.2)){
                                viewModel.selectedJob = job
                                showDetail.toggle()
                            }
                        }
                        if let selectedJob = viewModel.selectedJob,
                           job.id == selectedJob.id {
                            RoundedRectangle(cornerRadius: 25.0)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.blue)
                                .frame(height: 100)
                        }
                    }
                    .padding(.bottom)
                }
            }
        }
    }
    
    private var headerView: some View {
        VStack {
            Group {
                Text("\(viewModel.jobOpenings.count) " + (viewModel.jobOpenings.count == 1 ? "job opportunity listed" : "job opportunities listed"))
                    .font(.customFont(type: .lightItalic, size: .mediun))
                Text("Search bar")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.bottom)
    }
}

#Preview {
    ListView()
}
