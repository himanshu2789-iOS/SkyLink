//
//  PriceTag.swift
//  SkyLink
//
//  Created by Himanshu Sharma on 09/07/26.
//

import SwiftUI

struct PriceTag: View {

    let price: Double

    var body: some View {

        VStack(alignment: .trailing, spacing: 2) {

            Text("$\(Int(price))")
                .font(.system(size: 28,
                              weight: .bold,
                              design: .rounded))
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            Color.blue,
                            Color.cyan
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )

            Text("per passenger")
                .font(.caption2)
                .foregroundStyle(.secondary)

        }

    }

}

#Preview {

    PriceTag(price: 450)

}
