//
//  CaulyAdView.h
//  Runner
//
//  Created by 유용민 on 8/24/24.
//

#ifndef CaulyAdView_h
#define CaulyAdView_h

#import <UIKit/UIKit.h>
#import "CaulyAdSetting.h"

@class CaulyAdView;

// Cauly 광고 이벤트 Delegate
@protocol CaulyAdViewDelegate <NSObject>

@optional

// 광고 정보 수신 성공
- (void)didReceiveAd:(CaulyAdView *)adView isChargeableAd:(BOOL)isChargeableAd;

// 광고 정보 수신 실패
- (void)didFailToReceiveAd:(CaulyAdView *)adView errorCode:(int)errorCode errorMsg:(NSString *)errorMsg;

// 랜딩 화면 표시
- (void)willShowLandingView:(CaulyAdView *)adView;

// 랜딩 화면이 닫혔을 때
- (void)didCloseLandingView:(CaulyAdView *)adView;

@end

@interface CaulyAdView : UIView

+ (id)caulyAdViewWithController:(UIViewController *)controller;

- (id)init;
- (id)initWithParentViewController:(UIViewController *)controller;

- (void)startBannerAdRequest;
- (void)stopAdRequest;

- (void)showWithParentViewController:(UIViewController *)controller target:(UIView*)target;

@property (nonatomic, weak) UIViewController * parentController;

@property (nonatomic, weak) id<CaulyAdViewDelegate> delegate;
@property (nonatomic, strong) CaulyAdSetting * localSetting;
@property (nonatomic, strong) NSObject * data;

@property (nonatomic, readonly) NSString * errorMsg;

@end

#endif /* CaulyAdView_h */
