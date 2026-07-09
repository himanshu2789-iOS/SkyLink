//
//  GradientButton.swift
//  SkyLink
//
//  Created by Himanshu Sharma on 08/07/26.
//

import SwiftUI

struct GradientButton: View {
    let title: String
    let icon: String

    var action: () -> Void
    
    var body: some View {

        Button {
            action()
        } label: {
            HStack(spacing: 10) {
                Text(title)
                    .fontWeight(.bold)
                Image(systemName: icon)

            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 58)
            .background(
                LinearGradient(
                    colors: [
                        Color.blue,
                        Color.cyan
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 18)
            )
            .shadow(
                color: .blue.opacity(0.35),
                radius: 12,
                y: 8
            )
        }
    }
}
