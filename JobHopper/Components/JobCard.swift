//
//  JobCard.swift
//  JobHopper
//
//  Created by Jason Mandozzi on 3/23/24.
//

import SwiftUI

struct JobCard: View {
    var namespace: Namespace.ID
    @State var job: JobOpening
    @Binding var showDetail: Bool
    let buttonAction: (() -> Void)
    
    var body: some View {
        if !showDetail {
            ZStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.blue)
                VStack(alignment: .leading) {
                    Group {
                        Text(job.jobTitle)
                            .font(.JHtitleMedium)
                            .truncationMode(.tail)
                        Spacer()
                        HStack {
                            Text(job.company)
                                .font(.JHtitleSmall)
                                .truncationMode(.tail)
                            Spacer()
                            Text(job.status.rawValue)
                                .font(.JHtitleSmall)
                                .truncationMode(.tail)
                        }
                    }
                }
                .padding()
            }
            .matchedGeometryEffect(id: job.id, in: namespace)
            .frame(height: 170)
            .transition(.scale(scale: 1))
            .onTapGesture {
                buttonAction()
            }
        } else {
            ZStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.blue)
                VStack(alignment: .leading) {
                    Group {
                        Text(job.jobTitle)
                            .font(.JHtitleMedium)
                            .truncationMode(.tail)
                        Spacer()
                        HStack {
                            Text(job.company)
                                .font(.JHtitleSmall)
                                .truncationMode(.tail)
                            Spacer()
                            Text(job.status.rawValue)
                                .font(.JHtitleSmall)
                                .truncationMode(.tail)
                        }
                    }
                }
                .padding()
            }
            .frame(height: 170)
        }
    }
}

#Preview(body: {
    @Namespace var namespace
    return JobCard(namespace: namespace, job: .init(jobTitle: "Title", company: "Company", status: .applied, interviewProcess: nil), showDetail: .constant(false), buttonAction: { print("Button Action") })
})
