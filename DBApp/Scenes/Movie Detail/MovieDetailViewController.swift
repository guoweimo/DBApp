//
//  MovieDetailViewController.swift
//  DLApp
//
//  Created by Guowei Mo on 17/02/2017.
//  Copyright (c) 2017 Guowei Mo. All rights reserved.
//
import UIKit

protocol MovieDetailViewControllerInput
{
  func displayMovieDetail(with viewModel: MovieDetail.ViewModel)
}

protocol MovieDetailViewControllerOutput
{
  func requestMovieDetail(with request: MovieDetail.Request)
}

class MovieDetailViewController: UIViewController, MovieDetailViewControllerInput
{
  var output: MovieDetailViewControllerOutput!
  var router: MovieDetailRouter!
  
  var movieId: Int? {
    didSet {
      fetchMovieDetailOnLoad()
    }
  }
  
  var displayedMovie: MovieDetail.ViewModel.DisplayedMovieDetail? {
    didSet {
      DispatchQueue.main.async {
        [unowned self] in
        self.movieDetailTableView?.reloadData()
      }
    }
  }
  
  @IBOutlet weak var movieDetailTableView: UITableView!
  
  // MARK: Object lifecycle
  override func awakeFromNib()
  {
    super.awakeFromNib()
    MovieDetailConfigurator.shared.configure(self)
  }
  
  // MARK: View lifecycle
  override func viewDidLoad()
  {
    super.viewDidLoad()
    fetchMovieDetailOnLoad()
  }
  
  // MARK: Event handling
  func fetchMovieDetailOnLoad() {
    if let id = movieId {
      let request = MovieDetail.Request(id: id)
      output.requestMovieDetail(with: request)
    }
  }
  
  // MARK: Display logic
  func displayMovieDetail(with viewModel: MovieDetail.ViewModel) {
    displayedMovie = viewModel.displayedMovieDetail
  }
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let viewModel = displayedMovie else { return UITableViewCell() }
    if indexPath.row == 0,
      let cell = tableView.dequeueReusableCell(withIdentifier: MOVIE_DETAIL_CELL_ID) as? MovieDetailCell {
      cell.updateUI(with: viewModel)
      return cell
    } else if indexPath.row == 1,
      let cell = tableView.dequeueReusableCell(withIdentifier: MOVIE_DESCRIPTION_CELL_ID) as? MovieDescriptionCell {
      cell.updateUI(with: viewModel.overview)
      return cell
    }
    return UITableViewCell()
  }
}
