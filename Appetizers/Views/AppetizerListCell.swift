//
//  MenuItemView.swift
//  Appetizers
//
//  Created by Yeshwanth Chandrashekar on 2/8/25.
//

import SwiftUI

struct AppetizerListCell: View {
    
    let appetizer : Appetizer
    
    var body: some View {
        HStack(spacing: 20) {
            AsyncImage(
                url: URL(string: appetizer.imageURL),
                content: { image in
                    image.resizable()
                        .frame(width: 120, height: 90)
                        .clipShape(RoundedRectangle(cornerRadius: 8 ))
                },
                placeholder: {
                    Image("food-placeholder")
                        .resizable()
                        .frame(width: 120, height: 90)
                        .clipShape(RoundedRectangle(cornerRadius: 8 ))
                }
            )
            
            VStack(alignment: .leading, spacing: 10){
                Text("\(appetizer.name)")
                    .font(.title2)
                    .fontWeight(.medium)
                Text("$\(appetizer.price, specifier: "%.2f")")
                    .foregroundStyle(.secondary)
                    .fontWeight(.semibold)
            }
        }
         
    }
}

#Preview {
    AppetizerListCell(appetizer: MockData.sampleAppetizer)
}
