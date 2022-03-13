//
//  RNCGalleryViewModule.m
//  RNNativeComponent
//
//  Created by 이희석 on 2022/03/06.
//

#import <React/RCTBridgeModule.h>
#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(RNCGalleryViewManager, RCTViewManager)

+ (BOOL)requiresMainQueueSetup { return YES; }

RCT_EXPORT_VIEW_PROPERTY(column, NSNumber);
RCT_EXPORT_VIEW_PROPERTY(mediaType, NSString) // ALL, PHOTO, VIDEO
RCT_EXPORT_VIEW_PROPERTY(onSelectMedia, RCTDirectEventBlock)

@end
