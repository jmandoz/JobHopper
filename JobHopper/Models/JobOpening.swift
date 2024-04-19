//
//  JobOpening.swift
//  JobHopper
//
//  Created by Jason Mandozzi on 3/23/24.
//

import Foundation

struct JobOpening: Identifiable {
    let id = UUID().uuidString
    
    let jobTitle: String
    let company: String
    let status: CandidateStatus
    let interviewProcess: InterviewProcess?
}

enum CandidateStatus: String, CaseIterable, Identifiable {
    case applied = "Applied"
    case introCall = "Intro Call"
    case interviewProcess = "Interview Process"
    case offer = "Offer"
    case ghosted = "Ghosted"
    
    var id: Self { self }
}
