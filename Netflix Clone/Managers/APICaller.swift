//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Enrique Sarmiento on 6/2/24.
//

import Foundation

struct Constants {
   static let API_KEY = "6c7d036e5d76f227599844be7788ca6a"
   static let baseURL = "https://api.themoviedb.org"
}

enum APIError : Error {
   case failedToGetData
}

class APICaller {
   
   static let shared = APICaller()
   
   func getTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
      guard let url = URL(string: "\(Constants.baseURL)/3/trending/all/day?api_key=\(Constants.API_KEY)") else {return}
      
      let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _ , error in
         guard let data = data, error == nil else {
            return
         }
         
         do {
            //let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
            let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
            print("DEBUG: result trending ==>", results.results[0])
            completion(.success(results.results))
            
         } catch let error as NSError {
            completion(.failure(error))
         }
      }
      
      task.resume()
      
   }
   
   
}
