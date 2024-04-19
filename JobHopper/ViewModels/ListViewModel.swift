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
        return [.init(jobTitle: "Senior Software Engineer",
                      company: "Uber",
                      status: .interviewProcess,
                      interviewProcess: .init(interviewSteps: [.init(title: "intro call",
                                                                     desctription: "15 minute call with the recruiter",
                                                                     time: 15),
                                                               .init(title: "First round interview",
                                                                     desctription: "Coding with an engineer",
                                                                     time: 45),
                                                               .init(title: "Second round interview",
                                                                     desctription: "In-person interview that will take 2 hours",
                                                                     time: 120)],
                                              contact: .init(name: "Susan Salamander",
                                                             email: "Susan@SofaKingAmazing.com"))),
                
                .init(jobTitle: "Lead Architect",
                      company: "Google",
                      status: .applied,
                      interviewProcess: nil),
                
                .init(jobTitle: "Lead Backend Developer",
                      company: "Meta",
                      status: .interviewProcess,
                      interviewProcess: .init(interviewSteps: [.init(title: "Take home coding",
                                                                      desctription: "Algo problem to complete and return within 24 hours",
                                                                      time: 60)],
                                               contact: .init(name: "Susan Boyle",
                                                              email: "sBoyles@gmail.com"))),
                .init(jobTitle: "Software Developer",
                      company: "DrafKings",
                      status: .interviewProcess,
                      interviewProcess: .init(interviewSteps: [.init(title: "Take home coding",
                                                                      desctription: "Algo problem to complete and return within 24 hours",
                                                                      time: 120)],
                                               contact: .init(name: "Susan Boyle",
                                                              email: "sBoyles@gmail.com"))),
                .init(jobTitle: "Lead Architect",
                      company: "Google",
                      status: .introCall,
                      interviewProcess: nil),
                
                .init(jobTitle: "React Developer",
                      company: "eBay",
                      status: .interviewProcess,
                      interviewProcess: .init(interviewSteps: [.init(title: "Take home coding",
                                                                      desctription: "Algo problem to complete and return within 24 hours",
                                                                      time: 60)],
                                               contact: .init(name: "Susan Boyle",
                                                              email: "sBoyles@gmail.com"))),
                .init(jobTitle: "iOS Developer",
                      company: "Fanatics",
                      status: .interviewProcess,
                      interviewProcess: .init(interviewSteps: [.init(title: "Take home coding",
                                                                      desctription: "Algo problem to complete and return within 24 hours",
                                                                      time: 120)],
                                               contact: .init(name: "Susan Boyle",
                                                              email: "sBoyles@gmail.com")))
        ]
    }
}
