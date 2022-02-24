//
//  RNCGalleryView.swift
//  RNNativeComponent
//
//  Created by 이희석 on 2022/03/06.
//

import UIKit
import Photos

class RNCGalleryView: RCTView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

  var collectionView: UICollectionView!
  var column: NSNumber! = 3
  var mediaType: NSString?
  var assets: [PHAsset]?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    super.backgroundColor = UIColor.clear
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
      
    initCollectionView(layout)
    
    load()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    self.collectionView?.frame = self.bounds
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
    DispatchQueue.main.async {
      self.requestPhotoLibraryAccess({
        DispatchQueue.main.async {
          self.assets = self.fetchAssets()
          self.collectionView?.reloadData()
        }
      })
    }
  }
  
  func reload() {
    self.load()
  }
  
  func fetchAssets() -> [PHAsset] {
    let fetchOptions = PHFetchOptions()
    let sortDescriptor = NSSortDescriptor.init(key: "creationDate", ascending: false)
    let predicate = NSPredicate.init(format: "mediaType == %d", PHAssetMediaType.image.rawValue)
    
    fetchOptions.predicate = predicate
    fetchOptions.sortDescriptors = [sortDescriptor]
    let fetchResult = PHAsset.fetchAssets(with: fetchOptions)
    
    var assets: [PHAsset] = []
    fetchResult.enumerateObjects { object, Index, stop in
      assets.append(object)
    }
    
    return assets
  }
  
  func requestPhotoLibraryAccess(_ authorizedHandler: @escaping () -> Void) {
    let authStatus = PHPhotoLibrary.authorizationStatus()
    
    if (authStatus == PHAuthorizationStatus.authorized) {
      authorizedHandler()
    } else if (authStatus == PHAuthorizationStatus.notDetermined) {
      PHPhotoLibrary.requestAuthorization { _ in
        self.requestPhotoLibraryAccess(authorizedHandler)
      }
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc
  func setColumn(_ column: NSNumber) {
    self.column = column
  }
  
  @objc
  func setMediaType(_ mediaType: NSString) {
    self.mediaType = mediaType
    self.reload()
  }
}
