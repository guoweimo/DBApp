//
//  MovieListModels.swift
//  DLApp
//
//  Created by Guowei Mo on 16/02/2017.
//  Copyright (c) 2017 Guowei Mo. All rights reserved.
//


import UIKit

struct MovieList
{
  struct Request {
    var page: Int = 1
  }
  
  struct Response
  {
    var movies: [DBMovie] = []
    var page: Int
  }
  
  struct ViewModel
  {
    var displayedMovies: [DisplayedMovie]
    struct DisplayedMovie {
      var id: Int
      var title: String
      var releaseYear: String
      var avgVotes: String
      var posterPath: String?
    }
  }

}



