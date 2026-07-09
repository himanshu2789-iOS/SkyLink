//
//  AppTheme.swift
//  SkyLink
//
//  Created by Himanshu Sharma on 08/07/26.
//

import SwiftUI

struct AppTheme {

    struct Colors {

        static let primary = Color(red: 0.07, green: 0.49, blue: 0.95)

        static let secondary = Color(red: 0.10, green: 0.72, blue: 0.92)

        static let background = Color(.systemGroupedBackground)

        static let card = Color.white

        static let textPrimary = Color.black

        static let textSecondary = Color.gray

        static let success = Color.green

        static let warning = Color.orange

        static let shadow = Color.black.opacity(0.08)
    }

    struct Radius {

        static let small: CGFloat = 14

        static let medium: CGFloat = 22

        static let large: CGFloat = 30
    }

    struct Padding {

        static let small: CGFloat = 10

        static let medium: CGFloat = 18

        static let large: CGFloat = 24
    }

}
