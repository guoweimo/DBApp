//
//  File.swift
//  DBApp
//
//  Created by Guowei Mo on 18/02/2017.
//  Copyright © 2017 Guowei Mo. All rights reserved.
//

import Foundation

class DBGenres {
  
  static let shared = DBGenres()
  
  var dict: [Int: String] = [:]
  
  func update(with data: [[String: Any]]) {
    data.forEach { (item) in
      let id = item["id"] as! Int
      let name = item["name"] as! String
      dict[id] = name
    }
  }
  
  func names(of ids: [Int]) -> [String] {
    return ids.map { dict[$0] ?? "" }
  }
}
