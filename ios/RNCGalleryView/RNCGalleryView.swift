//
//  RNCGalleryView.swift
//  RNNativeComponent
//
//  Created by 이희석 on 2022/03/06.
//

import UIKit

class RNCGalleryView: RCTView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  var _collectionView: UICollectionView? = nil
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    super.backgroundColor = UIColor.clear
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    _collectionView = UICollectionView.init(frame: self.bounds, collectionViewLayout: layout)
    
    if ((_collectionView) != nil) {
      if #available(iOS 11, *) {
        _collectionView!.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
      }
      _collectionView!.backgroundColor = UIColor.clear
      _collectionView!.dataSource = self
      _collectionView!.delegate = self
      
      _collectionView!.register(RNCGalleryViewCameraCell.self, forCellWithReuseIdentifier: RNCGalleryViewCameraCell.reuseIdentifier)
      
      self.addSubview(_collectionView!)
    }
    
    load()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    _collectionView?.frame = self.bounds
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: RNCGalleryViewCameraCell = collectionView.dequeueReusableCell(withReuseIdentifier: RNCGalleryViewCameraCell.reuseIdentifier, for: indexPath) as! RNCGalleryViewCameraCell
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 100, height: 100)
  }
  
  func load() {
    _collectionView?.reloadData()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
