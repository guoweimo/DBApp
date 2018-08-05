//
//  APIConnection.swift
//  DLApp
//
//  Created by Guowei Mo on 16/02/2017.
//  Copyright © 2017 Guowei Mo. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ data: [String: Any]?, _ error: Error?) -> Void

class APIConnection: NSObject {
  
  static let shared = APIConnection()
  
  var serverHost: String {
    return Bundle.main.infoDictionary![SERVER_HOST_KEY] as? String ?? ""
  }
  
  var apiKey: String {
    return Bundle.main.infoDictionary![API_KEY] as! String
  }
  
  private var completion: CompletionHandler?
  
  private func makeConnection(with keyPath: String) {
    if let serverURL = URL(string: serverHost) {
      let url = URL(string: keyPath, relativeTo: serverURL)!
      
      URLSession.shared.dataTask(with: url) {
        [unowned self] (data, response, err) in
        
        do {
          guard let data = data else {
            self.completion?(nil, err)
            return
          }
          if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            self.completion?(json, nil)
            print(json)
          }
        } catch let err as NSError {
          self.completion?(nil, err)
        }
        }.resume()
    }
  }
  
  
  func retrieveMovies(at page: Int, completed handler: @escaping CompletionHandler) {
    completion = handler
    let keyPath = constructedKeyPath(with: "discover/movie", paras: ["page": page])
    makeConnection(with: keyPath)
  }
  
  func retrieveMovieDetail(with id: Int, completed handler: @escaping CompletionHandler ) {
    completion = handler
    let keyPath = constructedKeyPath(with: "movie/\(id)")
    makeConnection(with: keyPath)
  }
  
  func retrieveGenres(completed handler: @escaping CompletionHandler) {
    completion = handler
    let keyPath = constructedKeyPath(with: "genre/movie/list")
    makeConnection(with: keyPath)
  }
    
  private func constructedKeyPath(with path: String, paras: [String: Any] = [:]) -> String {
    var parasCopy = paras;
    parasCopy[API_KEY] = apiKey
    let parasStr = stringfy(dict: parasCopy)
    return "\(path)?\(parasStr)"
  }
  
  private func stringfy(dict: [String: Any]) -> String {
    return dict.flatMap({ (key, value) -> String in
      return "\(key)=\(value)"
    }).joined(separator: "&")
  }
  
}
