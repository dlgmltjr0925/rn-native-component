//
//  RNCGalleryViewCameraCell.swift
//  RNNativeComponent
//
//  Created by 이희석 on 2022/03/06.
//

import UIKit

class RNCGalleryViewCameraCell: UICollectionViewCell {
  static let reuseIdentifier = "RNCGalleryViewCameraCell"
  
  let iconCameraImageView = UIImageView.init(image: UIImage.init(named: "IconCameraWhite"))
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.backgroundColor = UIColor.init(red: 0.18, green: 0.25, blue: 0.3, alpha: 1.0)
    
    iconCameraImageView.frame = CGRect(x: 0, y: 0, width: 26, height: 26)
    iconCameraImageView.center = self.center
    self.addSubview(iconCameraImageView)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    iconCameraImageView.center = center
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
