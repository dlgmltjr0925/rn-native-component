//
//  RNCGalleryView.swift
//  RNNativeComponent
//
//  Created by 이희석 on 2022/03/06.
//

import UIKit

class RNCGalleryView: RCTView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  var collectionView: UICollectionView!
  var column: NSNumber! = 3
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    super.backgroundColor = UIColor.clear
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
      
    initCollectionView(layout)
    
    load()
  }
  
  func initCollectionView(_ layout: UICollectionViewLayout) {
    self.collectionView = UICollectionView.init(frame: self.bounds, collectionViewLayout: layout)
    
    if #available(iOS 11, *) {
      self.collectionView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
    }
    self.collectionView.backgroundColor = UIColor.clear
    self.collectionView.dataSource = self
    self.collectionView.delegate = self
    
    self.collectionView.register(RNCGalleryViewCameraCell.self, forCellWithReuseIdentifier: RNCGalleryViewCameraCell.reuseIdentifier)
    
    self.addSubview(collectionView)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    self.collectionView?.frame = self.bounds
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: RNCGalleryViewCameraCell = collectionView.dequeueReusableCell(withReuseIdentifier: RNCGalleryViewCameraCell.reuseIdentifier, for: indexPath) as! RNCGalleryViewCameraCell
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let column = self.column as! CGFloat
    let gap = (column - 1) * 2
    let size = self.bounds.size.width / column - gap
    
    return CGSize(width: size, height: size)
  }
  
  func load() {
    self.collectionView?.reloadData()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc
  func setColumn(_ column: NSNumber) {
    self.column = column
  }
}
