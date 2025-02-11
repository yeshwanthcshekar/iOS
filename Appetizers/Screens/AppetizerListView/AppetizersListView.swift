//
//  AppetizersListView.swift
//  Appetizers
//
//  Created by Yeshwanth Chandrashekar on 2/8/25.
//

import SwiftUI

struct AppetizersListView: View {
    @ObservedObject var viewModel: AppetizerListViewModel
    
    var body: some View {
        ZStack{
            NavigationStack {
                List(viewModel.appetizers) { appetizer in
                    AppetizerListCell(appetizer: appetizer)
                        .onTapGesture{
                            viewModel.selectedItem = appetizer
                            viewModel.isPresented = true
                        }
                }
                .navigationTitle(Text("Appetizers"))
            }.onAppear() {                
                viewModel.getAppetizers()
            }
            .sheet(
                item: $viewModel.selectedItem,
                onDismiss: {
                    viewModel.isPresented.toggle()
                },
                content: { appetizer in
                    AppetizerDetailView(
                        appetizer: appetizer,
                        viewModel: viewModel,
                        isPresented: $viewModel.isPresented
                    )
                    .presentationDetents([.fraction(1)])
                    .presentationBackground(.ultraThinMaterial)
                })
            if viewModel.isLoading {
                LoadingView()
            }
        }
        .blur(radius:  viewModel.isPresented ?  10 : 0)
        .alert(item: $viewModel.alertItem){alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
    }
}

#Preview {
    AppetizersListView(viewModel: AppetizerListViewModel())
}
