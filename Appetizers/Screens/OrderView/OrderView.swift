//
//  OrderView.swift
//  Appetizers
//
//  Created by Yeshwanth Chandrashekar on 2/8/25.
//

import SwiftUI

struct OrderView: View {
    var orderItems: [Appetizer]
    var orderTotal: Double
    var deleteOrderItems : ( IndexSet ) -> Void = { _ in }
    
    var body: some View {
        NavigationStack {
            
            if orderItems.isEmpty {
                VStack (spacing: 20){
                    Image("empty-order")
                        .resizable()
                        .frame(width: 250, height: 200)
                    Text("You have no items in your order")
                }
                .navigationTitle( "Order" )
            }
            
            else {
                VStack{
                    
                    List{
                        ForEach(orderItems){item in
                            AppetizerListCell(appetizer: item)
                        }
                        .onDelete{offsets in
                            deleteOrderItems(offsets)
                        }
                    }.listStyle(PlainListStyle())
                    
                    Button(action: {}, label: {
                        Text("$\(orderTotal , specifier: "%.2f") - Place Order")
                            .fontWeight(.semibold)
                            .frame(width: 240, height: 50)
                            .background(.brandPrimary)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    })
                    .navigationTitle(Text("Order"))
                }
            }
        }
    }
}

#Preview {
    OrderView(orderItems: MockData.appetizers, orderTotal: 20.00)
}
