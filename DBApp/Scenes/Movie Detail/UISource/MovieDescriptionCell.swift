//
//  MovieDescriptionCell.swift
//  DLApp
//
//  Created by Guowei Mo on 16/02/2017.
//  Copyright © 2017 Guowei Mo. All rights reserved.
//

import UIKit


class MovieDescriptionCell: UITableViewCell {
  
  @IBOutlet weak var overviewText: UITextView!
  
  func updateUI(with text: String?) {
    overviewText.text = text ?? "No more description."
  }
}
