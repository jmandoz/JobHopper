//
//  JobCard.swift
//  JobHopper
//
//  Created by Jason Mandozzi on 3/23/24.
//

import SwiftUI

struct JobCard: View {
    var cardNamespace: Namespace.ID
    var detailNamespace: Namespace.ID
    @State var job: JobOpening
    @Binding var showDetail: Bool
    let buttonAction: (() -> Void)
    
    var body: some View {
        ZStack {
            if showDetail {
                RoundedRectangle(cornerRadius: 25.0)
                    .matchedGeometryEffect(id: "detail background \(job.id)", in: detailNamespace)
                    .transition(.scale(scale: 1))
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.blue)
                    .frame(height: 150)
                
            }
            if !showDetail {
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .matchedGeometryEffect(id: "detail background \(job.id)", in: detailNamespace)
                        .transition(.scale(scale: 1))
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.blue)
                    VStack(alignment: .leading) {
                        Group {
                            Text(job.jobTitle)
                                .matchedGeometryEffect(id: "jobTitle \(job.id)", in: cardNamespace)
                                .transition(.scale(scale: 1))
                                .font(.JHtitleMedium)
                                .truncationMode(.tail)
                            Spacer()
                            HStack {
                                Text(job.company)
                                    .matchedGeometryEffect(id: "company \(job.id)", in: cardNamespace)
                                    .transition(.scale(scale: 1))
                                    .font(.JHtitleSmall)
                                    .truncationMode(.tail)
                                Spacer()
                                Text(job.status.rawValue)
                                    .matchedGeometryEffect(id: "jobStatus \(job.id)", in: cardNamespace)
                                    .transition(.scale(scale: 1))
                                    .font(.JHtitleSmall)
                                    .truncationMode(.tail)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    }
                }
                .matchedGeometryEffect(id: "background \(job.id)", in: cardNamespace)
                .transition(.scale(scale: 1))
                .frame(height: 150)
                .onTapGesture {
                    buttonAction()
                }
            }
        }
    }
}

#Preview(body: {
    @Namespace var detailNamespace
    @Namespace var cardNamespace
    return JobCard(cardNamespace: cardNamespace, detailNamespace: detailNamespace, job: .init(jobTitle: "Title", company: "Company", status: .applied, interviewProcess: nil), showDetail: .constant(true), buttonAction: { print("Button Action") })
})
