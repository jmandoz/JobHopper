//
//  Font+Extension.swift
//  JobHoppr
//
//  Created by Jason Mandozzi on 3/23/24.
//

import Foundation
import SwiftUI

extension Font {
    static func customFont(type: CooperHewitt, size: FontSize) -> Font {
        return Font.custom(type.rawValue, size: size.rawValue)
    }
}

enum FontSize: CGFloat {
    case xtraLarge = 42
    case large = 34
    case medium = 26
    case small = 18
    case xtraSmall = 14
}

enum CooperHewitt: String {
    case thin = "CooperHewitt-Thin"
    case semiboldItalic = "CooperHewitt-SemiboldItalic"
    case bold = "CooperHewitt-Bold"
    case boldItalic = "CooperHewitt-BoldItalic"
    case thinItalic = "CooperHewitt-ThinItalic"
    case book = "CooperHewitt-Book"
    case bookItalic = "CooperHewitt-BookItalic"
    case lightItalic = "CooperHewitt-LightItalic"
    case heavyItalic = "CooperHewitt-HeavyItalic"
    case heavy = "CooperHewitt-Heavy"
    case light = "CooperHewitt-Light"
    case medium = "CooperHewitt-Medium"
    case mediumItalic = "CooperHewitt-MediumItalic"
    case semiBold = "CooperHewitt-Semibold"
}
