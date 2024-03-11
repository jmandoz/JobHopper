//
//  Font+Extension.swift
//  JobHopper
//
//  Created by Jason Mandozzi on 3/23/24.
//

import Foundation
import SwiftUI

extension Font {
    static let JHtitleXtraLarge = Font.custom(CooperHewitt.heavy.rawValue, size: FontSize.xtraLarge.rawValue)
    static let JHtitleLarge = Font.custom(CooperHewitt.heavy.rawValue, size: FontSize.large.rawValue)
    static let JHtitleMedium = Font.custom(CooperHewitt.bold.rawValue, size: FontSize.mediun.rawValue)
    static let JHtitleSmall = Font.custom(CooperHewitt.semiBold.rawValue, size: FontSize.small.rawValue)
}

enum FontSize: CGFloat {
    case xtraLarge = 32
    case large = 28
    case mediun = 22
    case small = 18
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
