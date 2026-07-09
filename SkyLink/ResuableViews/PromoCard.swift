//
//  PromoCard.swift
//  SkyLink
//
//  Created by Himanshu Sharma on 08/07/26.
//

import SwiftUI

struct PromoCard: View {

    let city: String
    let image: String
    let price: String

    @State private var isPressed = false

    var body: some View {

        ZStack(alignment: .bottomLeading) {

            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 260,
                       height: 320)
                .clipped()

            LinearGradient(
                colors: [
                    .clear,
                    .black.opacity(0.15),
                    .black.opacity(0.85)
                ],
                startPoint: .top,
                endPoint: .bottom
            )

            VStack(alignment: .leading,
                   spacing: 14) {

                Spacer()

                HStack {

                    Text(city)
                        .font(.cardTitle)
                        .foregroundStyle(.white)

                    Spacer()

                    Image(systemName: "heart")
                        .foregroundStyle(.white)
                }

                Text(country)
                    .foregroundStyle(.white.opacity(0.85))

                HStack {

                    Label("4.9",
                          systemImage: "star.fill")
                        .font(.caption)

                    Spacer()

                    Text("Direct")
                        .font(.caption.bold())
                        .padding(.horizontal,12)
                        .padding(.vertical,6)
                        .background(.white.opacity(0.25))
                        .clipShape(Capsule())

                }
                .foregroundStyle(.white)

                HStack {

                    VStack(alignment:.leading){

                        Text("Starting from")
                            .font(.caption)

                        Text(price)
                            .font(.title3.bold())

                    }

                    Spacer()

                    Circle()
                        .fill(.white)
                        .frame(width:48,height:48)
                        .overlay {

                            Image(systemName:"arrow.up.right")
                                .foregroundStyle(AppTheme.Colors.primary)
                                .font(.title3.bold())

                        }

                }
                .foregroundStyle(.white)

            }
            .padding(22)

        }
        .frame(width:260,
               height:320)
        .clipShape(
            RoundedRectangle(cornerRadius:32)
        )
        .shadow(color: .black.opacity(0.18),
                radius:18,
                y:12)
        .scaleEffect(isPressed ? 0.96 : 1)
        .animation(.spring(response:0.35),
                   value:isPressed)
        .onLongPressGesture(minimumDuration:0.01,
                            pressing: { pressing in
            isPressed = pressing
        }, perform: {})
    }

    var country: String {

        switch city {

        case "London":
            return "United Kingdom"

        case "Paris":
            return "France"

        case "Tokyo":
            return "Japan"

        default:
            return ""

        }

    }

}

#Preview {

    ScrollView(.horizontal) {
        HStack(spacing:24){
            PromoCard(city:"London",
                      image:"london",
                      price:"$450")
            PromoCard(city:"Tokyo",
                      image:"tokyo",
                      price:"$850")
            PromoCard(city:"Paris",
                      image:"paris",
                      price:"$520")

        }
        .padding()

    }

}
