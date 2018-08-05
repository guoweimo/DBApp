//
//  MovieDetailCell.swift
//  DLApp
//
//  Created by Guowei Mo on 16/02/2017.
//  Copyright © 2017 Guowei Mo. All rights reserved.
//

import UIKit


class MovieDetailCell: UITableViewCell {
  
  @IBOutlet weak var backdropImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var releaseDateLabel: UILabel!
  @IBOutlet weak var genreLabel: UILabel!
  @IBOutlet weak var voteLabel: UILabel!
  
  func updateUI(with item: MovieDetail.ViewModel.DisplayedMovieDetail) {
    titleLabel.text = item.title
    genreLabel.text = item.genres
    releaseDateLabel.text = item.releaseDate
    voteLabel.text = item.avgVotes
    if let path = item.backdropPath, let url = URL(string: "\(imageHost)\(path)"){
      if let cache = url.cachedImage {
        backdropImageView.image = cache
      } else {
        url.fetchImage(completion: {
          [unowned self] (image) in
          self.backdropImageView.image = image
        })
      }
    }

  }
}
