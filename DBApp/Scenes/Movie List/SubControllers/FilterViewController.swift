//
//  FilterViewController.swift
//  DBApp
//
//  Created by Guowei Mo on 19/02/2017.
//  Copyright © 2017 Guowei Mo. All rights reserved.
//

import UIKit

protocol FilterViewControllerDelegate: class {
  func filterUpdated(from minYear: String, to maxYear: String)
}

class FilterViewController: UIViewController {
  
  @IBOutlet weak var minYearField: UITextField!
  @IBOutlet weak var maxYearField: UITextField!
  
  weak var delegate: FilterViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    minYearField.text = Filter.minYear
    maxYearField.text = Filter.maxYear
  }
  
  @IBAction func resetButtonDidtap(_ sender: Any) {
    Filter.minYear = nil
    Filter.maxYear = nil
    minYearField.text = ""
    maxYearField.text = ""
  }
  
  @IBAction func doneButtonDidTap(_ sender: Any) {
    resignFirstResponder()
    let minYear = minYearField.text
    let maxYear = maxYearField.text
    if let min = minYear, !min.isEmpty,
    let max = maxYear, !max.isEmpty {
      if min.isValidYear() && max.isValidYear() {
        Filter.minYear = min
        Filter.maxYear = max
        delegate?.filterUpdated(from: min, to: max)
      }
    }
    
    dismiss(animated: true, completion: nil)
  }  
}
