//
//  InfoCard.swift
//  SkyLink
//
//  Created by Himanshu Sharma on 08/07/26.
//

import SwiftUI

struct InfoCard<Content: View,
                Title: View,
                Icon: View>: View {
    
    @ViewBuilder var content: Content
    
    @ViewBuilder var icon: Icon
    
    @ViewBuilder var title: Title
    
    var body: some View {
        
        VStack(alignment: .leading,
               spacing: 10) {
            
            HStack {
                
                icon
                    .foregroundStyle(.blue)
                title
                    .font(.caption)
                
            }
            content
            
        }
               .frame(maxWidth: .infinity,
                      alignment: .leading)
               .padding()
               .background(
                
                Color(.systemGray6)
                
               )
               .clipShape(
                RoundedRectangle(cornerRadius: 18)
               )
    }
}
