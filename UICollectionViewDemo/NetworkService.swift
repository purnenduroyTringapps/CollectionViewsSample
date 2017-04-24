//
//  NetworkService.swift
//  UICollectionViewDemo
//
//  Created by Purnendu on 4/20/17.
//  Copyright © 2017 com.tringapps. All rights reserved.
//

import Foundation

class NetworkService {
  
  //let url = URL.init(string: "http://eol-feeds.eonline.com/arf/content/galleries/6.json?page=1&num=30")
  
  lazy var configuration:URLSessionConfiguration = URLSessionConfiguration.default
  lazy var session:URLSession = URLSession(configuration: self.configuration)
  let url:URL
  
  init(url:URL) {
    self.url = url
  }
  
  typealias jsonDataHandler = ((Data) -> Void)
  
  //MARK: Network call
  func dataHandler(completion: @escaping jsonDataHandler) {
    
    let request = URLRequest(url: url)
    
    let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
      
      if error == nil {
        if let httpResponse = response as? HTTPURLResponse {
          switch(httpResponse.statusCode) {
          case 200:
            if let data = data {
              completion(data)
            }
          default:
            print(httpResponse.statusCode)
            break
          }
        }
      } else {
        print("Error: \(String(describing: error?.localizedDescription))")
      }
      
    })
    dataTask.resume()
  }
}


//extension NetworkService
//{
//  static func parseJsonFromData(jsonData: Data?) -> [String:AnyObject]?
//  {
//    if let data = jsonData {
//      do {
//        let jsonDict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:AnyObject]
//        return jsonDict
//      } catch let error as NSError {
//        print("error processing json data: \(error.localizedDescription)")
//      }
//    }
//    return nil
//  }
//}
