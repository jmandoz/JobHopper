//
//  JobDetailView.swift
//  JobHopper
//
//  Created by Jason Mandozzi on 4/11/24.
//

import SwiftUI

struct JobDetailView: View {
    var detailNamespace: Namespace.ID
    var cardNamespace: Namespace.ID
    @Binding var showDetail: Bool
    
    @State var job: JobOpening
    
    var body: some View {
        ZStack {
            if !showDetail {
                RoundedRectangle(cornerRadius: 25.0)
                    .matchedGeometryEffect(id: "detail background \(job.id)", in: detailNamespace)
                    .transition(.scale(scale: 1))
                    .foregroundStyle(.blue)
            } else {
                RoundedRectangle(cornerRadius: 25.0)
                    .foregroundStyle(.blue)
                    .overlay {
                        VStack {
                            VStack(alignment: .leading, spacing: 15) {
                                Text(job.jobTitle)
                                    .matchedGeometryEffect(id: "jobTitle \(job.id)", in: cardNamespace)
                                    .transition(.scale(scale: 1))
                                    .font(.JHtitleXtraLarge)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.top, 35)
                                    .truncationMode(.tail)
                                HStack {
                                    Text(job.company)
                                        .matchedGeometryEffect(id: "company \(job.id)", in: cardNamespace)
                                        .transition(.scale(scale: 1))
                                        .font(.JHtitleSmall)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .truncationMode(.tail)
                                    Spacer()
                                    Text(job.status.rawValue)
                                        .matchedGeometryEffect(id: "jobStatus \(job.id)", in: cardNamespace)
                                        .transition(.scale(scale: 1))
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
                    .matchedGeometryEffect(id: "background \(job.id)", in: cardNamespace)
                    .transition(.scale(scale: 1))
                    .ignoresSafeArea(.all)
            }
        }
    }
}

#Preview("JobDetail", body: {
    @Namespace var detailNamespace
    @Namespace var cardNamespace
    return JobDetailView(detailNamespace: detailNamespace, cardNamespace: cardNamespace, showDetail: .constant(true), job: .init(jobTitle: "Title", company: "Company", status: .applied, interviewProcess: nil))
})
