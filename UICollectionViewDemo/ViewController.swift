//
//  ViewController.swift
//  UICollectionViewDemo
//
//  Created by Purnendu on 4/17/17.
//  Copyright © 2017 com.tringapps. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource {

  @IBOutlet var collectionView: UICollectionView!
  
  let imageArray = [UIImage.init(named: "Dog1"), UIImage.init(named: "Dog2"), UIImage.init(named: "Dog4"), UIImage.init(named: "Dog5"), UIImage.init(named: "Dog6"), UIImage.init(named: "Dog7")]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return imageArray.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
    cell.imageView.image = imageArray[indexPath.row]
    return cell
  }
}

