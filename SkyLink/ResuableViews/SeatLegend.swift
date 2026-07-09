//
//  SeatLegend.swift
//  SkyLink
//
//  Created by Himanshu Sharma on 09/07/26.
//

import Foundation
import SwiftUI

struct SeatLegend: View {

    var body: some View {

        HStack(spacing:18) {

            item(color: .gray.opacity(0.25),
                 border: .gray,
                 title: "Available")

            item(color: .red.opacity(0.18),
                 border: .red,
                 title: "Occupied")

            item(color: .green,
                 border: .green,
                 title: "Selected")

        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 18))

    }

    @ViewBuilder
    func item(color:Color,border:Color,title:String)->some View{

        HStack(spacing:6){

            RoundedRectangle(cornerRadius:4)
                .fill(color)
                .frame(width:14,height:14)
                .overlay{

                    RoundedRectangle(cornerRadius:4)
                        .stroke(border,lineWidth:1)

                }

            Text(title)
                .font(.caption)

        }
    }
}
