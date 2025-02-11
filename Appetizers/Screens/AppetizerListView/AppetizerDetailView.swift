//
//  AppetizerDetailView.swift
//  Appetizers
//
//  Created by Yeshwanth Chandrashekar on 2/10/25.
//

import SwiftUI

struct AppetizerDetailView: View {
    var appetizer: Appetizer
    var viewModel: AppetizerListViewModel
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var isPresented : Bool
    
    var body: some View {
        
        VStack{
            ZStack(alignment: .topTrailing){
                
                AsyncImage(url: URL(string: appetizer.imageURL),
                           content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 225)
                        .padding(.bottom, 10)
                    
                }, placeholder: {
                    Image("food-placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 225)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                })
                
                Button(action: {
                    dismiss()
                }, label: {
                    ZStack(alignment: .topTrailing){
                        Circle()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(.white)
                            .opacity(0.6)
                        
                        Image(systemName: "xmark")
                            .imageScale(.small)
                            .frame(width: 30 , height: 30)
                            .foregroundStyle(.black)
                    }
                })
            }
            
            Text(appetizer.name)
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Text(appetizer.description)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
            
            
            Spacer()
            
            HStack(spacing: 40){
                MacrosView(
                    macroType: "Calories",
                    macroValue: appetizer.calories
                )
                MacrosView(macroType: "Carbs", macroValue: appetizer.carbs)
                MacrosView(
                    macroType: "Protein",
                    macroValue: appetizer.protein
                )
            }
            
            Spacer()
            
            Button(action: {
                viewModel.addOrderItems(toOrder: appetizer)
                dismiss()
                print(viewModel.orderItems)
            }, label: {
                Text("$\(appetizer.price, specifier: "%.2f") - Add To Order")
                    .fontWeight(.semibold)
                    .frame(width: 240, height: 50)
                    .background(.brandPrimary)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            })
            Spacer()
        }.padding()
            . frame(width: 300, height: 600)
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(radius: 40)
    }
}

#Preview {
    AppetizerDetailView(
        appetizer: MockData.appetizers[0],
        viewModel: AppetizerListViewModel(),
        isPresented: .constant(false)
    )
}

struct MacrosView: View {
    var macroType : String
    var macroValue : Int
    
    var body: some View {
        VStack(spacing: 10){
            Text(macroType)
            Text(macroType == "Carbs" || macroType == "Protein" ? "\(macroValue) g" : "\(macroValue)")
                .foregroundStyle(.secondary)
                .fontWeight(.semibold)
        }
    }
}
