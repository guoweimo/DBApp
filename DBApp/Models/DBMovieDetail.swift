//
//  DBMovieDetail.swift
//  DBApp
//
//  Created by Guowei Mo on 19/02/2017.
//  Copyright © 2017 Guowei Mo. All rights reserved.
//

import Foundation

struct DBMovieDetail {
  
  var id: Int
  var title: String
  var vote: Float?
  var backdropPath: String?
  var releaseDate: String
  var genres: [String] = []
  var overview: String?

  init(with data: [String: Any]) {
    id = data["id"] as! Int
    title = data["title"] as! String
    vote = data["vote_average"] as? Float
    backdropPath = data["backdrop_path"] as? String
    releaseDate = data["release_date"] as! String
    overview = data["overview"] as? String
    
    if let genreObjs = data["genres"] as? [[String: Any]] {
      genres = genreObjs.map { $0["name"] as! String }
    }
  }
  
}
