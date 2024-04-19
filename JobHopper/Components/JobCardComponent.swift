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
    @State var showDivider: Bool = true
    @Binding var showDetail: Bool
    let buttonAction: (() -> Void)
    
    var body: some View {
        if !showDetail {
            VStack {
                detailView
            }
            .matchedGeometryEffect(id: job.id, in: namespace)
            .frame(height: 100)
            .transition(.offset(x: 0, y: 1))
            .onTapGesture {
                buttonAction()
            }
        } else {
            VStack {
                detailView
            }
            .frame(height: 100)
        }
    }
    
    private var detailView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18)
                .frame(maxWidth: .infinity)
                .foregroundColor(.gray.opacity(0.1))
            VStack(alignment: .leading) {
                Text(job.jobTitle)
                    .font(.customFont(type: .medium, size: .small))
                    .truncationMode(.tail)
                Spacer()
                HStack(alignment: .bottom) {
                    Text(job.company)
                        .font(.customFont(type: .light, size: .small))
                        .truncationMode(.tail)
                    Spacer()
                    Text(job.status.rawValue)
                        .font(.customFont(type: .bold, size: .xtraSmall))
                        .padding(.vertical, 4)
                        .padding(.horizontal)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundStyle(.green700)
                        )
                }
            }
            .padding()
        }
    }
}

#Preview(body: {
    @Namespace var namespace
    return JobCardComponent(namespace: namespace, job: .init(jobTitle: "Title", company: "Company", status: .applied, interviewProcess: nil), showDetail: .constant(false), buttonAction: { print("Button Action") })
})
