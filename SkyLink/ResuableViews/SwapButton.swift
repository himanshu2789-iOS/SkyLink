//
//  SwapButton.swift
//  SkyLink
//
//  Created by Himanshu Sharma on 08/07/26.
//

import SwiftUI

struct SwapButton: View {

    let rotate: Bool

    var action: () -> Void

    var body: some View {

        Button {

            action()

        } label: {

            Image(systemName: "arrow.up.arrow.down.circle.fill")
                .font(.system(size: 34))
                .foregroundStyle(.blue)
                .rotationEffect(
                    .degrees(rotate ? 180 : 0)
                )
        }
        .frame(maxWidth: .infinity)

    }

}
