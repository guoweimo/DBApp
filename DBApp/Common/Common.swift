//
//  Common.swift
//  DLApp
//
//  Created by Guowei Mo on 18/02/2017.
//  Copyright © 2017 Guowei Mo. All rights reserved.
//

import Foundation
import UIKit

public let SERVER_HOST_KEY = "Server_Host";
public let API_KEY = "api_key";
public let IMAGE_HOST_KEY = "Image_Host";
public let MOVIE_ITEM_CELL = "movie item";
public let FILTER_POP_OVER_SEGUE = "filterPopover";
public let MOVIE_DETAIL_VC_ID = "movie detail";
public let MOVIE_DETAIL_CELL_ID = "basic info";
public let MOVIE_DESCRIPTION_CELL_ID = "overview";

var mainStoryboard: UIStoryboard {
  return UIStoryboard(name: "Main", bundle: nil)
}

var imageHost: String {
  return Bundle.main.infoDictionary![IMAGE_HOST_KEY] as? String ?? ""
}

struct Filter {
  static var minYear: String?
  static var maxYear: String?
}

extension URL {
  
  private class ImageCache: NSCache<AnyObject, AnyObject> {
    static let shared = {
      () -> NSCache<AnyObject, AnyObject> in
      let cache = NSCache<AnyObject, AnyObject>()
      cache.name = "ImageCache"
      cache.countLimit = 50
      cache.totalCostLimit = 20*1024*1024
      return cache
    }()
  }
  
  typealias ImageCompletion = (UIImage) -> Void
  
  var cachedImage: UIImage? {
    return ImageCache.shared.object(forKey: absoluteString as AnyObject) as? UIImage
  }
  
  func fetchImage(completion: @escaping ImageCompletion) {
    URLSession.shared.dataTask(with: self) {
      data, response, error in
      if let  data = data,
        let image = UIImage(data: data) {
        ImageCache.shared.setObject(image,forKey: self.absoluteString as AnyObject, cost: data.count)
        DispatchQueue.main.async {
          completion(image)
        }
      }
      }.resume()
  }
}

extension String {
  func isValidYear() -> Bool {
    return Int(self) != nil && Int(self)! > 1900 && Int(self)! < 2017
  }
}
