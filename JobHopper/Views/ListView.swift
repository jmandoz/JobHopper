//
//  ListView.swift
//  JobHopper
//
//  Created by Jason Mandozzi on 3/10/24.
//

import SwiftUI

struct ListView: View {
    @Namespace var cardNamespace
    @Namespace var detailNamespace
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
                .padding(.horizontal)
            
                // full screen detail view
                if showDetail, let selectedJob = viewModel.selectedJob {
                    JobDetailView(detailNamespace: detailNamespace,
                                  cardNamespace: cardNamespace, 
                                  showDetail: $showDetail,
                                  job: selectedJob)
                    .offset(x: offsetX, y: offsetY)
                    .scaleEffect(scale)
                    .gesture(
                        DragGesture()
                            .onChanged(onDrag(_:))
                            .onEnded(onDragEnd(_:))
                    )
                }
            
        }
    }
    
    private func onDrag(_ value: DragGesture.Value) {
        let dy = value.translation.height
        let dx = value.translation.width
        offsetX = dx
        if dy >= 0 {
            offsetY = dy
            scale = 1 - ((dy/deviceHeight)/1.5)
        }
    }
    
    private func onDragEnd(_ value: DragGesture.Value) {
        let dy = value.translation.height
        let dx = value.translation.width
        if dx >= 0 {
            if dx > deviceWidth / 3 {
                withAnimation(.snappy(duration: 0.3)) {
                    offsetX = 0
                    offsetY = 0
                    scale = 1
                }
            } else {
                withAnimation(.snappy(duration: 0.3)) {
                    offsetX = 0
                    offsetY = 0
                    scale = 1
                }
            }
        } else {
            if dx > -(deviceWidth / 3) {
                withAnimation(.snappy(duration: 0.3)) {
                    offsetX = 0
                    offsetY = 0
                    scale = 1
                }
            } else {
                withAnimation(.snappy(duration: 0.3)) {
                    offsetX = 0
                    offsetY = 0
                    scale = 1
                }
            }
        }
        if dy >= 0 {
            if dy <= deviceHeight / 7.5 {
                withAnimation(.snappy(duration: 0.3)) {
                    offsetX = 0
                    offsetY = 0
                    scale = 1
                }
            } else {
                withAnimation(.snappy(duration: 0.3)) {
                    offsetX = 0
                    offsetY = 0
                    scale = 1
                    showDetail.toggle()
                }
            }
        }
    }
    
    private var listView: some View {
        VStack {
            Picker("Hello", selection: $selectedStatus) {
                ForEach(statusSelectors) { item in
                    Text(item.rawValue)
                        .tag(CandidateStatus(rawValue: item.rawValue))
                }
            }
            .pickerStyle(.segmented)
            
            ScrollView(showsIndicators: false) {
                ForEach(viewModel.jobOpenings) { job in
                    JobCard(cardNamespace: cardNamespace,
                            detailNamespace: detailNamespace,
                            job: job,
                            showDetail: $showDetail) {
                        viewModel.selectedJob = job
                        withAnimation(.snappy(duration: 0.4)){
                            showDetail.toggle()
                        }
                    }
                    .padding(.vertical)
                }
            }
        }
    }
    
    private var headerView: some View {
        VStack {
            Group {
                Text("\(viewModel.jobOpenings.count) " + (viewModel.jobOpenings.count == 1 ? "job opportunity listed" : "job opportunities listed"))
                    .font(.JHtitleLarge)
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
