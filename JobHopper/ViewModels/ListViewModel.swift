//
//  ListViewModel.swift
//  JobHopper
//
//  Created by Jason Mandozzi on 3/23/24.
//

import Foundation

class ListViewModel: ObservableObject {
    @Published var jobOpenings: [JobOpening] = MockJobOpening.makeMocks()
    @Published var selectedJob: JobOpening?
}

struct MockJobOpening {
    static func makeMocks() -> [JobOpening] {
        return [.init(jobTitle: "Senior Software Engineer", company: "Uber", status: .applied, interviewProcess: nil),
                .init(jobTitle: "Lead Architect", company: "Google", status: .introCall, interviewProcess: nil),
                .init(jobTitle: "Lead Backend Developer", company: "Meta", status: .interviewProcess, interviewProcess: [.init(interviewSteps: [.init(title: "Take home coding", desctription: "Algo problem to complete and return within 24 hours", time: nil)], contact: .init(name: "Susan Boyle", email: "sBoyles@gmail.com"))]),
                .init(jobTitle: "Software Developer", company: "DrafKings", status: .applied, interviewProcess: [.init(interviewSteps: [.init(title: "Take home coding", desctription: "Algo problem to complete and return within 24 hours", time: nil)], contact: .init(name: "Susan Boyle", email: "sBoyles@gmail.com"))])]
    }
}
