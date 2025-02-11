//
//  NetworkManager.swift
//  Appetizers
//
//  Created by Yeshwanth Chandrashekar on 2/10/25.
//

import Foundation
import UIKit
import SwiftUI


final class NetworkManager {
    
    //Single instance of NetworkManager is used throught the app
    static let shared = NetworkManager()
    
    //No other part of the app is allowed to initialize networkManager class
    private init() {}
    
    static let baseURL =  "https://seanallen-course-backend.herokuapp.com/swiftui-fundamentals/"
    private let appetizerURL = baseURL + "appetizers"
    
    func getAppetizer(
        completed: @escaping (Result<[Appetizer], APError>) -> Void
    ){
        
        //check for URL
        guard let url = URL(string: appetizerURL) else{
            completed(.failure(.invalidURL))
            return
        }
        
        //create a task(network call) to fetch data asynchronously
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data , response, error in
            
            //if result is an error
            if let _ = error {
                completed(.failure(.unableToCompleterequest))
                return
            } 
            
            //uf response is nil or not valid response
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(APError.invalidResponse))
                return
                
            }
         
            //if invalid data
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            //check for all the possible errors above and then if everything passes, then we have good data.
            //We try to decode the data to our model, if fails to decode, then return invalidData error
            do{
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(AppetizerResponse.self, from: data)
                completed(.success(decodedResponse.request))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    /* No need to do all of this, we can just use AsyncImage which has buil-in cache & automatic error handling
     
     private var cache = NSCache<NSString, UIImage>()

        func downloadImage(fromURLString urlString: String, completed: @escaping (Image?) -> Void) {
            let cacheKey = NSString(string: urlString)
            
            // Check if the image is in cache
            if let cachedImage = cache.object(forKey: cacheKey) {
                completed(Image(uiImage: cachedImage)) // Convert UIImage to SwiftUI Image
                return
            }
            
            guard let url = URL(string: urlString) else {
                completed(nil)
                return
            }
            
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
                guard let data = data, let uiImage = UIImage(data: data) else {
                    completed(nil)
                    return
                }
                
                // Store in cache
                self.cache.setObject(uiImage, forKey: cacheKey)
                
                // Convert to SwiftUI Image
                completed(Image(uiImage: uiImage))
            }
            task.resume()
        }
    */
    
}
