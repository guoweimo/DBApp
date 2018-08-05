//
//  MovieDetailInteractor.swift
//  DLApp
//
//  Created by Guowei Mo on 17/02/2017.
//  Copyright (c) 2017 Guowei Mo. All rights reserved.
//
import UIKit

protocol MovieDetailInteractorInput
{
  func requestMovieDetail(with request: MovieDetail.Request)
}

protocol MovieDetailInteractorOutput
{
  func presentMovieDetail(with response: MovieDetail.Response)
}

class MovieDetailInteractor: MovieDetailInteractorInput
{
  var output: MovieDetailInteractorOutput!
  // MARK: Business logic
  
  func requestMovieDetail(with request: MovieDetail.Request)
  {
    APIConnection.shared.retrieveMovieDetail(with: request.id) {
      [unowned self] (data, err) in
      if let data = data, err == nil {
        let response = MovieDetail.Response(movie: DBMovieDetail(with: data))
        self.output.presentMovieDetail(with: response)
      }
    }
  }
}
