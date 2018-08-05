//
//  MovieDetailPresenter.swift
//  DLApp
//
//  Created by Guowei Mo on 17/02/2017.
//  Copyright (c) 2017 Guowei Mo. All rights reserved.
//
import UIKit

protocol MovieDetailPresenterInput
{
  func presentMovieDetail(with response: MovieDetail.Response)
}

protocol MovieDetailPresenterOutput: class
{
  func displayMovieDetail(with viewModel: MovieDetail.ViewModel)
}

class MovieDetailPresenter: MovieDetailPresenterInput
{
  weak var output: MovieDetailPresenterOutput!

  // MARK: Presentation logic
  
  func presentMovieDetail(with response: MovieDetail.Response)
  {
    let movie = response.movie
    let displayedMovie = MovieDetail.ViewModel.DisplayedMovieDetail(
      title: movie.title,
      genres: movie.genres.joined(separator: ", "),
      avgVotes: "\(movie.vote ?? 0.0) ★",
      releaseDate: movie.releaseDate,
      backdropPath: movie.backdropPath,
      overview: movie.overview
    )
    let viewModel = MovieDetail.ViewModel(displayedMovieDetail: displayedMovie)
    output.displayMovieDetail(with: viewModel)
  }
}
