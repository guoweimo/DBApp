//
//  MovieListViewController.swift
//  DLApp
//
//  Created by Guowei Mo on 16/02/2017.
//  Copyright (c) 2017 Guowei Mo. All rights reserved.
//


import UIKit

protocol MovieListViewControllerInput
{
  func displayMovieList(with viewModel: MovieList.ViewModel)
}

protocol MovieListViewControllerOutput
{
  func queryMovieList(with request: MovieList.Request)
  func filterMovies(from minYear: String, to maxYear: String)
}

class MovieListViewController: UIViewController, MovieListViewControllerInput {
  var output: MovieListViewControllerOutput!
  var router: MovieListRouter!
  fileprivate var displayedMovies: [MovieList.ViewModel.DisplayedMovie]? {
    didSet {
      DispatchQueue.main.async {
        [unowned self] in
        self.moviesTableView?.reloadData()
      }
    }
  }
  
  fileprivate var currentPage: Int = 1
  
  @IBOutlet weak var moviesTableView: UITableView!
  
  // MARK: Object lifecycle
  override func awakeFromNib() {
    super.awakeFromNib()
    MovieListConfigurator.shared.configure(self)
  }
  
  // MARK: View lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchMoviesList(with: 1)
  }
  
  // MARK: Event handling
  
  func fetchMoviesList(with page: Int) {
    let request = MovieList.Request(page: page)
    output.queryMovieList(with: request)
  }
  
  // MARK: Display logic
  func displayMovieList(with viewModel: MovieList.ViewModel) {
    displayedMovies = viewModel.displayedMovies
    if displayedMovies?.count == 0 { //start fetch next page to avoid blank screen
      fetchNextPageMovies()
    }
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let actualPosition = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height - scrollView.bounds.height;
    if (actualPosition >= contentHeight) {
      fetchNextPageMovies()
    }
  }
  
  private func fetchNextPageMovies() {
    currentPage +=  1
    fetchMoviesList(with: currentPage)
  }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return displayedMovies?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: MOVIE_ITEM_CELL ) as? MovieItemCell ,
      let item = displayedMovies?[indexPath.row] {
      cell.updateUI(with: item)
      return cell
    }
    return UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let id = displayedMovies?[indexPath.row].id {
      router.navigateToMovieDetail(with:id)
    }
  }
}

extension MovieListViewController: UIPopoverPresentationControllerDelegate, FilterViewControllerDelegate {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == FILTER_POP_OVER_SEGUE {
      let popoverVC = segue.destination as? FilterViewController
      popoverVC?.modalPresentationStyle = .popover
      popoverVC?.popoverPresentationController?.delegate = self
      popoverVC?.delegate = self
    }
    
  }
  
  func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
    return .none
  }
  
  func filterUpdated(from minYear: String, to maxYear: String) {
    output.filterMovies(from: minYear, to: maxYear)
  }
}
