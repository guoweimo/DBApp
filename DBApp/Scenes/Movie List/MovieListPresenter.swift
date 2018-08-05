//
//  MovieListPresenter.swift
//  DLApp
//
//  Created by Guowei Mo on 16/02/2017.
//  Copyright (c) 2017 Guowei Mo. All rights reserved.
//


import UIKit

protocol MovieListPresenterInput
{
  func presentMovieList(with response: MovieList.Response)
}

protocol MovieListPresenterOutput: class
{
  func displayMovieList(with viewModel: MovieList.ViewModel)
}

class MovieListPresenter: MovieListPresenterInput
{
  weak var output: MovieListPresenterOutput!
  
  // MARK: Presentation logic
  
  func presentMovieList(with response: MovieList.Response) {
    var displayedMovies: [MovieList.ViewModel.DisplayedMovie] = []
    response.movies.forEach { (movie) in
        let displayedMovie = MovieList.ViewModel.DisplayedMovie(
          id: movie.id,
          title: movie.title,
          releaseYear: "\(movie.releaseYear!)",
          avgVotes: "\(movie.vote ?? 0.0) ★",
          posterPath: movie.posterPath)
        
      displayedMovies.append(displayedMovie)
    }
    let viewModel = MovieList.ViewModel(displayedMovies: displayedMovies)
    output.displayMovieList(with: viewModel)
  }
}
