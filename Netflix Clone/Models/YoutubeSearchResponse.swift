//
//  YoutubeSearchResponse.swift
//  Netflix Clone
//
//  Created by Enrique Sarmiento on 6/2/24.
//

import Foundation

struct YoutubeSearchResponse: Codable {
   let items : [VideoElement]
}

struct VideoElement : Codable {
   let id: IdVideoElement
   let etag: String?
   let kind: String?
}

struct IdVideoElement: Codable {
   let kind: String
   let playlistId: String?
   let videoId: String
}

