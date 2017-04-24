//
//  ViewController.swift
//  UICollectionViewDemo
//
//  Created by Purnendu on 4/17/17.
//  Copyright © 2017 com.tringapps. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {

  @IBOutlet var collectionView: UICollectionView!
  
//  let labelTextArray = ["Beautiful destination of geneva", "Amsterdam", "Site of nevada", "View from the beautiful hill", "charm of effil tower", "Beautiful destination of geneva", "Amsterdam", "Site of nevada", "View from the beautiful hill", "charm of effil tower"]
//  
//  let imageArray = [UIImage.init(named: "1"), UIImage.init(named: "2"), UIImage.init(named: "3"), UIImage.init(named: "4"), UIImage.init(named: "5"), UIImage.init(named: "6"), UIImage.init(named: "7"), UIImage.init(named: "8"), UIImage.init(named: "9"), UIImage.init(named: "10")]
  
  let imageURLs:NSMutableArray = []
  var responseData:Data?
  var news = [CollectionViewCellInfo]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    collectionView.backgroundColor = UIColor.clear
    
//    DispatchQueue.main.async {
//      self.news = CollectionViewCellInfo.getAllImagesInArray()
//      self.collectionView.dataSource = self
//      self.collectionView.delegate = self
//      self.collectionView.reloadData()
//    }

    getJsonObject()
  }

  
  
  //MARK: Getting the json data
  func getJsonObject() {
    let networkService = NetworkService.init(url: URL(string: "http://eol-feeds.eonline.com/arf/content/galleries/6.json?page=1&num=30")!)
    networkService.dataHandler { (data) in
      self.responseData = data
      self.parseJsonData(data: self.responseData!)
    }
  }
  
  
  //MARK: Json parsing
  func parseJsonData(data: Data?) {
    if let jsonData = data {
      do {
        let jsonDict = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:AnyObject]
        guard let items = jsonDict?["items"] as? [[String:AnyObject]] else {
          return
        }
        for (item) in items {
//          let imageObj = item["image"] as! [String:AnyObject]
//          imageURLs.add(URL(string: imageObj["src"] as! String)!)
          let singleModalObj = CollectionViewCellInfo.init(cellInfoDict: item)
          self.news.append(singleModalObj)
        }
      } catch let error as NSError {
        print("error processing json data: \(error.localizedDescription)")
      }
    }
    
    self.collectionView.dataSource = self
    self.collectionView.delegate = self
    
    DispatchQueue.main.async {
      self.collectionView.reloadData()
    }
  }
  
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return news.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
    let image = self.news[indexPath.row]
    cell.newsObj = image
    return cell
  }
  
  
//  func scrollViewDidScroll(_ scrollView: UIScrollView) {
//    for view in collectionView.visibleCells {
//      let view:CollectionViewCell = view as! CollectionViewCell
//      let yOffSet:CGFloat = ((collectionView.contentOffset.y - view.frame.origin.y) / (view.image.size.height)) * OffsetSpeed
//      view.imageOffSet(CGPoint.init(x: 0.0, y: yOffSet))
//    }
//  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let image = self.news[indexPath.row]
    let cellHeight = (collectionView.frame.width * CGFloat(image.imageHeight!)) / CGFloat(image.imagewidth!)
    return CGSize(width: collectionView.frame.size.width, height: cellHeight)
  }
  
//  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    performSegue(withIdentifier: "showImage", sender: indexPath)
//  }
  
//  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    let index = sender as! IndexPath
//    if segue.identifier == "showImage" {
//      let newVC = segue.destination as! NewViewController
//      newVC.image = self.imageArray[index.row]!
//    }
//  }
  
}

