//
//  CabinSectionHeader.swift
//  SkyLink
//
//  Created by Himanshu Sharma on 09/07/26.
//

import SwiftUI

struct CabinSectionHeader: View {

    let cabinClass: CabinClass

    var body: some View {

        HStack {

            Capsule()
                .fill(color)
                .frame(width: 6,height: 30)

            VStack(alignment:.leading,spacing:2){

                Text(cabinClass.displayName)
                    .font(.headline)

                Text(description)
                    .font(.caption)
                    .foregroundStyle(.secondary)

            }

            Spacer()

        }
        .padding(.horizontal)
        .padding(.vertical,8)
        .background(color.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius:14))

    }

    private var color: Color {

        switch cabinClass {

        case .first:
            return .orange

        case .business:
            return .blue

        case .premium:
            return .purple

        case .economy:
            return .green

        }

    }

    private var description:String {

        switch cabinClass {

        case .first:
            return "Luxury Suites"

        case .business:
            return "Business Comfort"

        case .premium:
            return "Extra Legroom"

        case .economy:
            return "Standard Seating"

        }

    }

}
