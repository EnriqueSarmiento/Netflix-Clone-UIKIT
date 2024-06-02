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
   
   func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
      guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
      
      let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _ , error in
         guard let data = data, error == nil else {
            return
         }
         
         do {
            /** useing JSONSerialization we can print pretty and formatted results on the terminal*/
            //let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
            //print("DEBUG: result trending ==>", results.results[0])
            let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
            completion(.success(results.results))
            
         } catch  {
            completion(.failure(APIError.failedToGetData))
         }
      }
      
      task.resume()
      
   }
   
   func getTrendingTvs(completion: @escaping (Result<[Title], Error>) -> Void){
      guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {return}
      
      let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _, error in
         guard let data = data, error == nil else {
            return
         }
         
         do {
            //let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
            let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
            completion(.success(results.results))
            
         } catch  {
            completion(.failure(APIError.failedToGetData))
         }
      }
      
      task.resume()
        
   }
   
   func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void){
      guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&lenguage=en-US&page=1") else {return}
      
      let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _ , error in
         guard let data = data, error == nil else {
            return
         }
         
         do {
            let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
            completion(.success(results.results))
            
         } catch  {
            completion(.failure(APIError.failedToGetData))
         }
      }
      
      task.resume()
   }
   
   func getTopRatedMovies(completion: @escaping (Result<[Title], Error>) -> Void){
      guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&lenguage=en-US&page=1") else {return}
      
      let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _ , error in
         guard let data = data, error == nil else {
            return
         }
         
         do {
            let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
            completion(.success(results.results))
            
         } catch  {
            completion(.failure(APIError.failedToGetData))
         }
      }
      
      task.resume()
   }
   
   func getPopularMovies(completion: @escaping (Result<[Title], Error>) -> Void){
      guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&lenguage=en-US&page=1") else {return}
      
      let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _ , error in
         guard let data = data, error == nil else {
            return
         }
         
         do {
            let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
            completion(.success(results.results))
            
         } catch  {
            completion(.failure(APIError.failedToGetData))
         }
      }
      
      task.resume()
   }
}
