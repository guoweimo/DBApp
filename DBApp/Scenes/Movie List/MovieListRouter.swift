//
//  MovieListRouter.swift
//  DLApp
//
//  Created by Guowei Mo on 16/02/2017.
//  Copyright (c) 2017 Guowei Mo. All rights reserved.
//


import UIKit

protocol MovieListRouterInput
{
}

class MovieListRouter: MovieListRouterInput
{
  weak var viewController: MovieListViewController!
  
  // MARK: Navigation
  func navigateToMovieDetail(with id: Int) {
    if let target = mainStoryboard.instantiateViewController(withIdentifier: MOVIE_DETAIL_VC_ID ) as? MovieDetailViewController {
      target.movieId = id
      viewController.navigationController?.pushViewController(target, animated: true)
    }
  }
  
}
