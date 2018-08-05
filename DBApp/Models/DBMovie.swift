//
//  Movie.swift
//  DBApp
//
//  Created by Guowei Mo on 18/02/2017.
//  Copyright © 2017 Guowei Mo. All rights reserved.
//

import Foundation

struct DBMovie {
  
  var id: Int
  var title: String
  var vote: Float?
  var posterPath: String?
  var releaseYear: Int?

  init(with data: [String: Any]) {
    id = data["id"] as! Int
    title = data["title"] as! String
    vote = data["vote_average"] as? Float
    posterPath = data["poster_path"] as? String
    let releaseDateStr = data["release_date"] as! String
    if let yearStr = releaseDateStr.components(separatedBy: "-").first {
      releaseYear = Int(yearStr)
    }
  }
}
