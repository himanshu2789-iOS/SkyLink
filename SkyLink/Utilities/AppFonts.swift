//
//  AppFonts.swift
//  SkyLink
//
//  Created by Himanshu Sharma on 08/07/26.
//

import SwiftUI

extension Font {
    static let hero = Font.system(size: 42,
                                  weight: .bold,
                                  design: .rounded)
    static let title = Font.system(size: 30,
                                   weight: .bold,
                                   design: .rounded)
    static let section = Font.system(size: 24,
                                     weight: .bold,
                                     design: .rounded)
    static let cardTitle = Font.system(size: 22,
                                       weight: .bold,
                                       design: .rounded)
    static let bodyText = Font.system(size: 17,
                                      weight: .medium)
    static let captionText = Font.system(size: 14,
                                         weight: .medium)
}
