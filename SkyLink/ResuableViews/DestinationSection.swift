//
//  DestinationSection.swift
//  SkyLink
//
//  Created by Himanshu Sharma on 08/07/26.
//

import SwiftUI

struct DestinationSection: View {
    var body: some View {
        
        VStack(alignment: .leading,
               spacing: 18) {

            SectionHeader(
                title: "Featured Destinations",
                subtitle: "Popular routes this week"
            )
            .padding(.horizontal)

            ScrollView(.horizontal,
                       showsIndicators: false) {

                HStack(spacing: 22) {

                    PromoCard(
                        city: "London",
                        image: "london",
                        price: "$450"
                    )

                    PromoCard(
                        city: "Tokyo",
                        image: "tokyo",
                        price: "$850"
                    )

                    PromoCard(
                        city: "Paris",
                        image: "paris",
                        price: "$520"
                    )

                }
                .padding(.horizontal)
            }

        }
    }
}
