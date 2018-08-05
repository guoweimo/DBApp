//
//  MovieDetailModels.swift
//  DLApp
//
//  Created by Guowei Mo on 17/02/2017.
//  Copyright (c) 2017 Guowei Mo. All rights reserved.
//
import UIKit

struct MovieDetail {
  struct Request {
    var id: Int
  }
  
  struct Response {
    var movie: DBMovieDetail
  }
  
  struct ViewModel {
    var displayedMovieDetail: DisplayedMovieDetail
    struct DisplayedMovieDetail {
      var title: String
      var genres: String
      var avgVotes: String
      var releaseDate: String
      var backdropPath: String?
      var overview: String?
    }
  }
}
