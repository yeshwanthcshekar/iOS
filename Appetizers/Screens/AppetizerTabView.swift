//
//  AppetizerTabView.swift
//  Appetizers
//
//  Created by Yeshwanth Chandrashekar on 2/8/25.
//

import SwiftUI

struct AppetizerTabView: View {
    @StateObject var viewModel = AppetizerListViewModel()
    
    var body: some View {
        TabView{
            Tab("Home", systemImage: "house", content: {
                AppetizersListView(viewModel: viewModel)
            })
            Tab("Account", systemImage: "person", content: {
                AccountView()
            })
            Tab(
                "Order",
                systemImage: "bag",
                content: {
                    OrderView(
                        orderItems: viewModel.orderItems,
                        orderTotal: viewModel.orderTotal,
                        deleteOrderItems: { indexSet in
                            viewModel.deleteOrderItems(atOffset: indexSet)
                        })
                }).badge(viewModel.orderItems.count)
        }
        .tint(.brandPrimary)
    }
}

#Preview {
    AppetizerTabView()
}

