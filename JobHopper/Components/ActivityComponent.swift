//
//  ActivityComponent.swift
//  JobHopper
//
//  Created by Jason Mandozzi on 4/19/24.
//

import SwiftUI

struct ActivityComponent: View {
    let width: CGFloat
    var body: some View {
        VStack(alignment: .leading) {
            Text("Activity")
                .font(.customFont(type: .light, size: .small))
            Grid(alignment: .center,
                 horizontalSpacing: 1,
                 verticalSpacing: 1) {
                ForEach(0..<5) { _ in
                    GridRow {
                        ForEach(0..<7) { _ in
                            RoundedRectangle(cornerRadius: 8)
                                .frame(width: width/14,
                                       height: width/14)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}
