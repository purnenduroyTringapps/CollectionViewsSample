//
//  NewViewController.swift
//  UICollectionViewDemo
//
//  Created by Purnendu on 4/18/17.
//  Copyright © 2017 com.tringapps. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {
  
  @IBOutlet var imageView: UIImageView!
  
  var image = UIImage()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    self.imageView.image = self.image
  }
  
}
