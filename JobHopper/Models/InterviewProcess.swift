//
//  Interview.swift
//  JobHopper
//
//  Created by Jason Mandozzi on 3/23/24.
//

import Foundation

struct InterviewProcess: Identifiable {
    let id = UUID().uuidString
    let interviewSteps: [Interview]
    let contact: CompanyContact
}

struct CompanyContact {
    let name: String
    let email: String
}
