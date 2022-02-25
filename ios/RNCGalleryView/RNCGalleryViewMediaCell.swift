//
//  RNCGalleryViewMediaCell.swift
//  RNNativeComponent
//
//  Created by 이희석 on 2022/03/06.
//

import UIKit

let padding: CGFloat = 5
let indicatorWidth: CGFloat = 24

enum IndicatorType {
  case None
  case Selected
}

class RNCGalleryViewMediaCell : UICollectionViewCell {
  static let reuseIdentifier = "RNCGalleryViewMediaCell"
    
  var photoImageView: UIImageView!
  var overlayView: UIView!
  var indicatorView: UIView!
  var timeLabel: UILabel!
  var representedAssetIdentifier: String!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.backgroundColor = UIColor.init(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
    
    self.photoImageView = UIImageView.init(frame: self.bounds)
    self.photoImageView.backgroundColor = UIColor.gray
    self.photoImageView.contentMode = UIImageView.ContentMode.scaleAspectFill
    self.photoImageView.clipsToBounds = true
    self.addSubview(self.photoImageView)
    
    self.overlayView = UIView.init(frame: self.bounds)
    self.overlayView.backgroundColor = UIColor.init(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.30)
    self.overlayView.isHidden = true
    self.addSubview(self.overlayView)
    
    let indicatorFrame = CGRect.init(x: 0, y: 0, width: indicatorWidth, height:  indicatorWidth)
    self.indicatorView = UIView.init(frame: indicatorFrame)
    self.indicatorView.layer.cornerRadius = indicatorWidth / 2
    self.indicatorView.layer.borderWidth = 1
    self.setIndicatorType(IndicatorType.None)
    
    self.timeLabel = UILabel.init()
    self.timeLabel.textColor = UIColor.white
    self.timeLabel.layer.shadowColor = UIColor.black.cgColor
    self.timeLabel.layer.shadowOpacity = 0.45
    self.timeLabel.layer.shadowOffset = CGSize(width: 0, height: 1)
    self.timeLabel.layer.shadowRadius = 1
    self.addSubview(self.timeLabel)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    self.photoImageView.frame = self.bounds
    self.overlayView.frame = self.bounds
    
    let indicatorViewX = self.bounds.size.width - padding - indicatorWidth
    self.indicatorView.frame = CGRect(x: indicatorViewX, y: padding, width: indicatorWidth, height: indicatorWidth)
    
    self.timeLabel.sizeToFit()
    
    let timeLabelX = self.bounds.size.width - padding - self.timeLabel.frame.size.width
    let timeLabelY = self.bounds.size.height - padding - self.timeLabel.frame.size.height
    self.timeLabel.frame = CGRect(x: timeLabelX, y: timeLabelY, width: self.timeLabel.frame.size.width, height: self.timeLabel.frame.size.height)
  }
  
  func setIndicatorType(_ indicatorType: IndicatorType) {
    if (indicatorType == IndicatorType.None) {
      self.indicatorView.backgroundColor = UIColor.init(red: 0.64, green: 0.64, blue: 0.64, alpha: 0.50)
      self.indicatorView.layer.borderColor = UIColor.init(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.50).cgColor
    } else {
      self.indicatorView.backgroundColor = UIColor.init(red: 0.17, green: 0.22, blue: 0.20, alpha: 1.00)
      self.indicatorView.layer.borderColor = UIColor.white.cgColor
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
