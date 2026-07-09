//
//  AirlineBadge.swift
//  SkyLink
//
//  Created by Himanshu Sharma on 09/07/26.
//

import SwiftUI

struct AirlineBadge: View {

    let name: String

    var body: some View {

        ZStack {

            Circle()
                .fill(gradient)

            Text(initials)
                .font(.system(size: 18,
                              weight: .bold,
                              design: .rounded))
                .foregroundStyle(.white)

        }
        .frame(width: 58, height: 58)
        .shadow(
            color: gradientColors.first!.opacity(0.35),
            radius: 8,
            x: 0,
            y: 5
        )
    }
}

// MARK: - Helpers

private extension AirlineBadge {

    var initials: String {

        let words = name.split(separator: " ")

        if words.count >= 2 {

            return "\(words[0].first!)\(words[1].first!)"
                .uppercased()

        } else {

            return String(name.prefix(2))
                .uppercased()

        }
    }

    var gradient: LinearGradient {

        LinearGradient(
            colors: gradientColors,
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    var gradientColors: [Color] {

        switch name {

        case "Aura Air":
            return [
                Color.blue,
                Color.cyan
            ]

        case "Stellar Wings":
            return [
                Color.purple,
                Color.indigo
            ]

        case "Pacific Express":
            return [
                Color.orange,
                Color.red
            ]

        case "SkyJet":
            return [
                Color.teal,
                Color.blue
            ]

        case "Blue Horizon":
            return [
                Color.blue,
                Color.mint
            ]

        case "Nimbus Airways":
            return [
                Color.indigo,
                Color.purple
            ]

        default:
            return [
                Color.gray,
                Color.blue
            ]

        }

    }

}

#Preview {

    VStack(spacing: 20) {

        AirlineBadge(name: "Aura Air")

        AirlineBadge(name: "Stellar Wings")

        AirlineBadge(name: "Pacific Express")

        AirlineBadge(name: "SkyJet")

        AirlineBadge(name: "Blue Horizon")

    }
    .padding()

}
