//
//  JobCardComponent.swift
//  JobHopper
//
//  Created by Jason Mandozzi on 3/23/24.
//

import SwiftUI

struct JobCardComponent: View {
    var namespace: Namespace.ID
    @State var job: JobOpening
    @Binding var showDetail: Bool
    let buttonAction: (() -> Void)
    
    var body: some View {
        if !showDetail {
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.blue)
                VStack(alignment: .leading) {
                    Group {
                        Text(job.jobTitle)
                            .truncationMode(.tail)
                        Spacer()
                        HStack {
                            Text(job.company)
                            Spacer()
                            Text(job.status.rawValue)
                        }
                        .truncationMode(.tail)
                        .font(.customFont(type: .boldItalic, size: .large))
                    }
                }
                .padding()
            }
            .matchedGeometryEffect(id: job.id, in: namespace)
            .frame(height: 100)
            .transition(.offset(x: 0, y: 1))
            .onTapGesture {
                buttonAction()
            }
        } else {
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.blue)
                VStack(alignment: .leading) {
                    Group {
                        Text(job.jobTitle)
                            .font(.customFont(type: .medium, size: .mediun))
                            .truncationMode(.tail)
                        Spacer()
                        HStack {
                            Text(job.company)
                                .font(.customFont(type: .medium, size: .mediun))
                                .truncationMode(.tail)
                            Spacer()
                            Text(job.status.rawValue)
                                .font(.customFont(type: .medium, size: .mediun))
                                .truncationMode(.tail)
                        }
                    }
                }
                .padding()
            }
            .frame(height: 100)
        }
    }
}

#Preview(body: {
    @Namespace var namespace
    return JobCardComponent(namespace: namespace, job: .init(jobTitle: "Title", company: "Company", status: .applied, interviewProcess: nil), showDetail: .constant(false), buttonAction: { print("Button Action") })
})
