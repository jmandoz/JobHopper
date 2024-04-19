//
//  Font+Extension.swift
//  JobHopper
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
    case xtraLarge = 46
    case large = 32
    case mediun = 24
    case small = 16
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