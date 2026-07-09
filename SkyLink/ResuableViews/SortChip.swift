//
//  SortChip.swift
//  SkyLink
//
//  Created by Himanshu Sharma on 09/07/26.
//

import SwiftUI

struct SortChip: View {

    let title: String

    let selected: Bool

    var action: () -> Void

    var body: some View {

        Button(action: action) {

            Text(title)

                .font(.subheadline.weight(.semibold))

                .foregroundStyle(
                    selected ? .white : .primary
                )

                .padding(.horizontal, 18)

                .padding(.vertical, 12)

                .background {

                    if selected {

                        LinearGradient(
                            colors: [
                                Color.blue,
                                Color.cyan
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )

                    } else {

                        Color.white

                    }

                }

                .clipShape(
                    Capsule()
                )

                .overlay {

                    Capsule()
                        .stroke(
                            selected ?
                            Color.clear :
                            Color.gray.opacity(0.15),
                            lineWidth: 1
                        )

                }

                .shadow(
                    color: selected ?
                    Color.blue.opacity(0.25) :
                    .black.opacity(0.05),
                    radius: 8,
                    y: 4
                )

        }
        .buttonStyle(.plain)

    }

}

#Preview {

    VStack(spacing:20){

        SortChip(
            title: "Cheapest",
            selected: true
        ){}

        SortChip(
            title: "Fastest",
            selected: false
        ){}

        SortChip(
            title: "Non-stop",
            selected: false
        ){}

    }
    .padding()

}
