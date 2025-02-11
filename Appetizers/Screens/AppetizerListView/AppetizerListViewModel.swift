//
//  AppetizerListViewModel.swift
//  Appetizers
//
//  Created by Yeshwanth Chandrashekar on 2/10/25.
//

import SwiftUI

final class AppetizerListViewModel: ObservableObject , Identifiable {
    
    @Published private(set) var appetizers: [Appetizer] = []
    @Published var alertItem : AlertItem?
    @Published var isLoading : Bool = false
    @Published var selectedItem : Appetizer?
    @Published private(set) var orderItems : [Appetizer] = []{
        didSet {
            orderTotal = orderItems.count > 0 ? orderItems
                .reduce(0) { $0 + $1.price } : 0
        }
    }
    
    @Published var isPresented : Bool = false
    @Published var orderTotal : Double = 0
    
    func addOrderItems(toOrder item : Appetizer){
        orderItems.append(item)
    }
    
    
    func deleteOrderItems(atOffset indexSet : IndexSet){
        orderItems.remove(atOffsets: indexSet)
    }
    
    
    func getAppetizers(){
        isLoading = true
        NetworkManager.shared.getAppetizer(completed:{ result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let appetizers):
                    self.appetizers = appetizers
                    
                case .failure(let error):
                    switch error {
                    case .invalidResponse:
                        self.alertItem = AlertContext.invalidResponse
                        
                    case .invalidURL:
                        self.alertItem = AlertContext.invalidURL
                        
                    case .invalidData:
                        self.alertItem = AlertContext.invalidData
                        
                    case .unableToCompleterequest:
                        self.alertItem = AlertContext.unableToComplete
                    }
                    
                }
            }
        })
    }
    
}
