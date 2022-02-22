//
//  RNCGalleryViewManager.swift
//  RNNativeComponent
//
//  Created by 이희석 on 2022/03/06.
//

import UIKit

@objc(RNCGalleryViewManager)
class RNCGalleryViewManager: RCTViewManager {
  
  override func view() -> UIView! {
    return RNCGalleryView()
  }
}
