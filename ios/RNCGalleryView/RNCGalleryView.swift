//
//  RNCGalleryView.swift
//  RNNativeComponent
//
//  Created by 이희석 on 2022/03/06.
//

import UIKit
import Photos

class RNCGalleryView: RCTView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  static let GAP: CGFloat = 2
  
  var collectionView: UICollectionView!
  var column: NSNumber! = 3
  var mediaType: NSString?
  var assets: [PHAsset] = []
  
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
    self.collectionView.register(RNCGalleryViewMediaCell.self, forCellWithReuseIdentifier: RNCGalleryViewMediaCell.reuseIdentifier)
    
    self.addSubview(collectionView)
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return self.getCellSize()
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets.zero
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return RNCGalleryView.GAP
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return RNCGalleryView.GAP
  }
    
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.assets.count + 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if (indexPath.row == 0) {
      return collectionView.dequeueReusableCell(withReuseIdentifier: RNCGalleryViewCameraCell.reuseIdentifier, for: indexPath) as! RNCGalleryViewCameraCell
    }
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RNCGalleryViewMediaCell.reuseIdentifier, for: indexPath) as! RNCGalleryViewMediaCell
    
    let asset = self.assets[indexPath.row - 1]
    
    if (asset.mediaType == PHAssetMediaType.video) {
      let duration = asset.duration
      let min = duration / 60
      let sec = duration.truncatingRemainder(dividingBy: 60)
      let timeString = "\(min):\(sec)"
      cell.timeLabel.text = timeString
      cell.timeLabel.isHidden = false
    } else {
      cell.timeLabel.isHidden = true
    }
    
    let imageRequestOptions = PHImageRequestOptions.init()
    imageRequestOptions.isNetworkAccessAllowed = true
    imageRequestOptions.isSynchronous = true
    imageRequestOptions.resizeMode = PHImageRequestOptionsResizeMode.none
    imageRequestOptions.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
    
    cell.representedAssetIdentifier = asset.localIdentifier
    cell.photoImageView.image = nil
    
    PHImageManager.default().requestImage(for: asset, targetSize: self.getCellSize(), contentMode: PHImageContentMode.aspectFill, options: imageRequestOptions) { image, info in
      if (cell.representedAssetIdentifier == asset.localIdentifier) {
        cell.photoImageView.image = image
      }
    }
    
    return cell
  }
  
  func getCellSize() -> CGSize {
    let column = self.column as! CGFloat
    let widthExcludingSpacing = self.bounds.size.width - (column - 1) * RNCGalleryView.GAP
    let width = widthExcludingSpacing / column
    return CGSize.init(width: width, height: width)
  }
  
    
  func load() {
    DispatchQueue.global().async {
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
    if (self.mediaType == "PHOTO") {
      fetchOptions.predicate = NSPredicate.init(format: "mediaType == %d", PHAssetMediaType.image.rawValue)
    } else if (self.mediaType == "VIDEO") {
      fetchOptions.predicate = NSPredicate.init(format: "mediaType == %d", PHAssetMediaType.video.rawValue)
    }
    
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
