//
//  AirlineImageView.swift
//  SkyLink
//
//  Created by Himanshu Sharma on 09/07/26.
//

import SwiftUI

struct AirlineImageView: View {

    let urlString: String
    let fallbackName: String

    var body: some View {

        Group {
            if let url = URL(string: urlString), !urlString.isEmpty {

                AsyncImage(url: url) { phase in

                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 48, height: 48)
                            .clipShape(Circle())

                    case .failure:
                        AirlineBadge(name: fallbackName)

                    case .empty:
                        ProgressView()
                            .frame(width: 48, height: 48)

                    @unknown default:
                        AirlineBadge(name: fallbackName)
                    }
                }

            } else {

                AirlineBadge(name: fallbackName)

            }
        }
        .frame(width: 48, height: 48)
        .background(Color(.systemGray6))
        .clipShape(Circle())
    }
}
