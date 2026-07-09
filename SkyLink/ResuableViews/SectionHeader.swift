//
//  SectionHeader.swift
//  SkyLink
//
//  Created by Himanshu Sharma on 08/07/26.
//

import SwiftUI

struct SectionHeader: View {
    let title: String
    let subtitle: String?
    var body: some View {
        VStack(alignment: .leading,
               spacing: 4) {
            Text(title)
                .font(.section)
            if let subtitle {
                Text(subtitle)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity,
               alignment: .leading)
    }
}
