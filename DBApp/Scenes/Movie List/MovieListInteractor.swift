//
//  MovieListInteractor.swift
//  DLApp
//
//  Created by Guowei Mo on 16/02/2017.
//  Copyright (c) 2017 Guowei Mo. All rights reserved.
//


import UIKit

protocol MovieListInteractorInput
{
  func queryMovieList(with request: MovieList.Request)
  func filterMovies(from minYear: String, to maxYear: String)
}

protocol MovieListInteractorOutput
{
  func presentMovieList(with response: MovieList.Response)
}

class MovieListInteractor: MovieListInteractorInput
{
  var output: MovieListInteractorOutput!
  
  var movies: [DBMovie] = []
  var pageInResponse: Int = 0
  // MARK: Business logic
 
  func queryMovieList(with request: MovieList.Request) {
    APIConnection.shared.retrieveMovies(at: request.page ,completed: {
      [unowned self]  (data, err) in
      if let data = data{
        if let result = data["results"] as? [[String: Any]] {
          if request.page != self.pageInResponse {
            let newMovies = result.map { DBMovie(with: $0) }
            self.movies.append(contentsOf: newMovies)
            
            if let savedMin = Filter.minYear,
              let savedMax = Filter.maxYear {
              self.filterMovies(from: savedMin, to: savedMax)
            }
          }
        }
        self.pageInResponse = data["page"] as? Int ?? self.pageInResponse
        self.passResultToPresenter()
      }
    })
  }
  
  func filterMovies(from minYear: String, to maxYear: String) {
    let filteredMovies = movies.filter { (movie) -> Bool in
        movie.releaseYear != nil &&
        movie.releaseYear! >= Int(minYear)! &&
        movie.releaseYear! <= Int(maxYear)!
    }
    movies = filteredMovies
    passResultToPresenter()
  }
  
  func passResultToPresenter() {
    let response = MovieList.Response(movies: movies, page: pageInResponse)
    self.output.presentMovieList(with: response)
  }
}
