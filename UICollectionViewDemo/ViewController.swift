//
//  ViewController.swift
//  UICollectionViewDemo
//
//  Created by Purnendu on 4/17/17.
//  Copyright © 2017 com.tringapps. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

  @IBOutlet var collectionView: UICollectionView!

  let labelTextArray = ["Beautiful destination of geneva", "Amsterdam", "Site of nevada", "View from the beautiful hill", "charm of effil tower", "Beautiful destination of geneva", "Amsterdam", "Site of nevada", "View from the beautiful hill", "charm of effil tower"]
  
  let imageArray = [UIImage.init(named: "BD1"), UIImage.init(named: "BD2"), UIImage.init(named: "BD3"), UIImage.init(named: "BD4"), UIImage.init(named: "BD5"), UIImage.init(named: "BD6"), UIImage.init(named: "BD7"), UIImage.init(named: "BD8"), UIImage.init(named: "BD9"), UIImage.init(named: "BD10")]
  
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
    cell.textLabel.text = labelTextArray[indexPath.row]
    return cell
  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let image = imageArray[indexPath.row]
    let cellHeight = (collectionView.frame.width * (image?.size.height)!) / (image?.size.width)!
    return CGSize(width: collectionView.frame.size.width, height: cellHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    performSegue(withIdentifier: "showImage", sender: indexPath)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let index = sender as! IndexPath
    if segue.identifier == "showImage" {
      let newVC = segue.destination as! NewViewController
      newVC.image = self.imageArray[index.row]!
    }
  }
  
}

