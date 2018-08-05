//
//  ProductCell.swift
//  DLApp
//
//  Created by Guowei Mo on 16/02/2017.
//  Copyright © 2017 Guowei Mo. All rights reserved.
//

import UIKit

class MovieItemCell: UITableViewCell {
  
  @IBOutlet weak var movieNameLabel: UILabel!
  @IBOutlet weak var rateLabel: UILabel!
  @IBOutlet weak var yearLabel: UILabel!
  @IBOutlet weak var posterImageView: UIImageView!
  
  func updateUI(with item: MovieList.ViewModel.DisplayedMovie) {
    movieNameLabel.text = item.title
    rateLabel.text = item.avgVotes
    yearLabel.text = item.releaseYear
    if let path = item.posterPath, let url = URL(string: "\(imageHost)\(path)"){
      if let cache = url.cachedImage {
        posterImageView.image = cache
      } else {
        url.fetchImage(completion: {
          [unowned self] (image) in
          self.posterImageView.image = image
        })
      }
    }
  }
}

extension UIButton {
  open override var isEnabled: Bool {
    didSet {
      alpha = isEnabled ? 1.0 : 0.5
    }
  }
}
