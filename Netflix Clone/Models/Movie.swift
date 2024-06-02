//
//  Movie.swift
//  Netflix Clone
//
//  Created by Enrique Sarmiento on 6/2/24.
//

import Foundation

struct TrendingMoviesResponse: Codable {
  
   let results: [Movie]
   
}

struct Movie : Codable{
   
   let id: Int
   let media_type: String?
   let original_name: String?
   let original_title: String?
   let overview, poster_path: String?
   let vote_count: Int
   let release_date: String?
   let vote_average: Double

}
