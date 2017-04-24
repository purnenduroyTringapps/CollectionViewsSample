//
//  CollectionViewCellInfo.swift
//  UICollectionViewDemo
//
//  Created by Purnendu on 4/20/17.
//  Copyright © 2017 com.tringapps. All rights reserved.
//

import Foundation

class CollectionViewCellInfo {
  
  var imageTitle:String?
  var imageURL:URL?
  var imagewidth:Int?
  var imageHeight:Int?
  
  init(cellInfoDict: [String:AnyObject]) {
    self.imageTitle = cellInfoDict["title"] as? String
    let imgObj = cellInfoDict["image"] as! [String:AnyObject]
    self.imageURL = URL(string: imgObj["src"] as! String)
    self.imagewidth = imgObj["width"] as? Int
    self.imageHeight = imgObj["height"] as? Int
  }
  
  
  //MARK: Parse the json data
  static func getAllImagesInArray() -> [CollectionViewCellInfo] {
    
    var newsObject = [CollectionViewCellInfo]()
    
    let networkService = NetworkService.init(url: URL(string: "http://eol-feeds.eonline.com/arf/content/galleries/6.json?page=1&num=30")!)
    
    networkService.dataHandler { (data) in
      
      let responseData:Data? = data
      
      if let jsonData = responseData {
        do {
          let jsonDict = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:AnyObject]
          guard let items = jsonDict?["items"] as? [[String:AnyObject]] else {
            return
          }
          for (item) in items {
            let singleModalObj = CollectionViewCellInfo.init(cellInfoDict: item)
            newsObject.append(singleModalObj)
          }
        } catch let error as NSError {
          print("error processing json data: \(error.localizedDescription)")
        }
      }
    }
    
    return newsObject
  }
  
  
}
