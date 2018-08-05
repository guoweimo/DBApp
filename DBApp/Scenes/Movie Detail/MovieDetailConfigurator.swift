//
//  MovieDetailConfigurator.swift
//  DLApp
//
//  Created by Guowei Mo on 17/02/2017.
//  Copyright (c) 2017 Guowei Mo. All rights reserved.
//
import UIKit

// MARK: Connect View, Interactor, and Presenter

extension MovieDetailViewController: MovieDetailPresenterOutput
{

}

extension MovieDetailInteractor: MovieDetailViewControllerOutput
{
}

extension MovieDetailPresenter: MovieDetailInteractorOutput
{
}

class MovieDetailConfigurator
{
  // MARK: Object lifecycle
  
  static let shared = MovieDetailConfigurator()
  
  // MARK: Configuration
  
  func configure(_ viewController: MovieDetailViewController)
  {
    let router = MovieDetailRouter()
    router.viewController = viewController
    
    let presenter = MovieDetailPresenter()
    presenter.output = viewController
    
    let interactor = MovieDetailInteractor()
    interactor.output = presenter
    
    viewController.output = interactor
    viewController.router = router
  }
}
