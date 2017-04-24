//
//  CollectionViewCell.swift
//  UICollectionViewDemo
//
//  Created by Purnendu on 4/17/17.
//  Copyright © 2017 com.tringapps. All rights reserved.
//

import UIKit
import CoreGraphics

let ImageHeight: CGFloat = 200.0
let OffsetSpeed: CGFloat = 25.0


class CollectionViewCell: UICollectionViewCell {
  
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var textLabel: UILabel!
  
  var newsObj:CollectionViewCellInfo! {
    didSet {
      self.updateUI()
    }
  }
  
		
  func updateUI() {
    textLabel.text = newsObj.imageTitle
    if let imageURL = newsObj.imageURL {
      let networkService = NetworkService.init(url: imageURL)
      networkService.dataHandler(completion: { (imageData) in
        let image = UIImage.init(data: imageData as Data)
        DispatchQueue.main.async(execute: {
          self.imageView.image = image
        })
      })
    }
  }
  
  //  var image: UIImage = UIImage() {
  //    didSet {
  //      imageView.image = image
  //    }
  //  }
  //
  //  var text:String = String() {
  //    didSet {
  //      textLabel.text = text
  //    }
  //  }
  //
  //  func imageOffSet(_ offset: CGPoint)
  //  {
  //    imageView.frame = self.imageView.bounds.offsetBy(dx: offset.x, dy: offset.y)
  //  }
  
}
