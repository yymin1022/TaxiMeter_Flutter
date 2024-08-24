//
//  FLNativeView.h
//  Runner
//
//  Created by 유용민 on 8/24/24.
//

#ifndef FLNativeView_h
#define FLNativeView_h

#import <Flutter/Flutter.h>
#import "Cauly.h"
#import "CaulyAdView.h"

@interface FLNativeViewFactory : NSObject <FlutterPlatformViewFactory, CaulyAdViewDelegate>
- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;
@end

@interface FLNativeView : NSObject <FlutterPlatformView>

- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
              binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;

- (UIView*)view;

- (CaulyAdView*)caulyAdView;

@end


#endif /* FLNativeView_h */
