//
//  MovieListConfigurator.swift
//  DLApp
//
//  Created by Guowei Mo on 16/02/2017.
//  Copyright (c) 2017 Guowei Mo. All rights reserved.
//


import UIKit

// MARK: Connect View, Interactor, and Presenter

extension MovieListViewController: MovieListPresenterOutput {
}

extension MovieListInteractor: MovieListViewControllerOutput {
  
}

extension MovieListPresenter: MovieListInteractorOutput {
}

class MovieListConfigurator
{
  // MARK: Object lifecycle
  
  static let shared = MovieListConfigurator()
  // MARK: Configuration
  
  func configure(_ viewController: MovieListViewController)
  {
    let router = MovieListRouter()
    router.viewController = viewController
    
    let presenter = MovieListPresenter()
    presenter.output = viewController
    
    let interactor = MovieListInteractor()
    interactor.output = presenter
    
    viewController.output = interactor
    viewController.router = router
  }
}
