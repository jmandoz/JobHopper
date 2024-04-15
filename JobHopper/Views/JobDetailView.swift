//
//  JobDetailView.swift
//  JobHopper
//
//  Created by Jason Mandozzi on 4/11/24.
//

import SwiftUI

struct JobDetailView: View {
    @ObservedObject var viewModel: ListViewModel
    var namespace: Namespace.ID
    @Binding var showDetail: Bool
    
    @State var job: JobOpening
    
    var body: some View {
        if showDetail {
            GeometryReader { proxy in
                RoundedRectangle(cornerRadius: 25.0)
                    .foregroundStyle(.blue)
                    .overlay {
                        jobDetailsView
                    }
            }
            .ignoresSafeArea(.all)
            .matchedGeometryEffect(id: job.id, in: namespace)
            .transition(.offset(x: 0, y: 1))
        }
    }
    
    private var jobDetailsView: some View {
        VStack {
            VStack(alignment: .leading, spacing: 15) {
                Text(job.jobTitle)
                    .font(.JHtitleXtraLarge)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 35)
                    .truncationMode(.tail)
                HStack {
                    Text(job.company)
                        .font(.JHtitleSmall)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .truncationMode(.tail)
                    Spacer()
                    Text(job.status.rawValue)
                        .font(.JHtitleSmall)
                        .truncationMode(.tail)
                }
                Spacer()
                Button(action: {
                    // todo: button action to
                }, label: {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(.white)
                        .overlay {
                            Text("Update")
                                .font(.JHtitleMedium)
                                .frame(maxWidth: .infinity)
                        }
                        .frame(height: 48)
                })
                .frame(maxWidth: .infinity)
                .padding(.bottom, 100)
            }
            .padding(.top, 35)
            .padding(.horizontal)
        }
    }
}

#Preview("JobDetail", body: {
    @Namespace var namespace
    return JobDetailView(viewModel: .init(), namespace: namespace, showDetail: .constant(true), job: .init(jobTitle: "Title", company: "Company", status: .applied, interviewProcess: nil))
})
