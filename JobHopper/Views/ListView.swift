//
//  ListView.swift
//  JobHopper
//
//  Created by Jason Mandozzi on 3/10/24.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var viewModel: ListViewModel
    @Binding var showDetail: Bool
    
    let namespace: Namespace.ID
    let statusSelectors: [CandidateStatus] = [.applied, .introCall, .interviewProcess]
    
    var body: some View {
            VStack {
                headerView
                listView
            }
            .padding()
    }
    
    private var listView: some View {
        VStack {
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
                                .foregroundColor(.gray.opacity(0.1))
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
                    .font(.customFont(type: .light, size: .medium))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.bottom)
    }
}

#Preview {
    @Namespace var namespace
    @State var showDetail: Bool = false
    return ListView(viewModel: .init(), showDetail: $showDetail, namespace: namespace)
}
