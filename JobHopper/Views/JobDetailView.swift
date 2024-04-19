//
//  JobDetailView.swift
//  JobHopper
//
//  Created by Jason Mandozzi on 4/11/24.
//

import SwiftUI

struct JobDetailView: View {
    var namespace: Namespace.ID
    @Binding var showDetail: Bool
    
    @State var job: JobOpening
    
    var body: some View {
        if showDetail {
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundStyle(.primaryBackground)
                .overlay {
                    jobDetailsView
                }
                .matchedGeometryEffect(id: job.id, in: namespace)
                .transition(.offset(x: 0, y: 1))
                .ignoresSafeArea(edges: .all)
        }
    }
    
    private var jobDetailsView: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                Text(job.jobTitle)
                    .font(.customFont(type: .light, size: .xtraLarge))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 35)
                    .truncationMode(.tail)
                HStack {
                    Text(job.company)
                        .font(.customFont(type: .medium, size: .medium))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .truncationMode(.tail)
                    Spacer()
                    Text(job.status.rawValue)
                        .font(.customFont(type: .medium, size: .medium))
                        .truncationMode(.tail)
                }
                if let interviewProcess = job.interviewProcess {
                    VStack(alignment: .leading) {
                        ForEach(interviewProcess.interviewSteps) { step in
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 1)
                                        .frame(width: 4, height: 60)
                                        .foregroundStyle(step.id != interviewProcess.interviewSteps.last?.id ? .primary500 : .clear)
                                        .transformEffect(.init(translationX: 0, y: 23))
                                    
                                    Circle()
                                        .frame(width: 30, height: 30)
                                        .foregroundStyle(.primary500)
                                }
                                Text(step.title)
                                    .font(.customFont(type: .medium, size: .small))
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                }
                
                Spacer()
                Button(action: {
                    // todo: button action to
                }, label: {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(.primary500)
                        .overlay {
                            Text("Update")
                                .font(.customFont(type: .semiBold, size: .small))
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(.primary900)
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
    return JobDetailView(namespace: namespace,
                         showDetail: .constant(true),
                         job: .init(jobTitle: "Title",
                                    company: "Company",
                                    status: .applied,
                                    interviewProcess: .init(interviewSteps: [.init(title: "Title", desctription: "Description", time: 15),
                                        .init(title: "Title", desctription: "Description", time: 30), .init(title: "Title", desctription: "Description", time: 45), 
                                        .init(title: "Title", desctription: "Description", time: 60)], contact: .init(name: "Contact name", email: "email"))))
})
