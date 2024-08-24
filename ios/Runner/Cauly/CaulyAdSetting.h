//
//  CaulyAdSetting.h
//  Runner
//
//  Created by 유용민 on 8/24/24.
//

#ifndef CaulyAdSetting_h
#define CaulyAdSetting_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Cauly.h"

@interface CaulyAdSetting : NSObject{
    NSArray* serverSettings;
}

+ (CaulyAdSetting *)adSettingWithAppCode:(NSString *)appCode appId:(NSString *)appId;
+ (CaulyAdSetting *)globalSetting;
+ (void)setLogLevel:(CaulyLogLevel)logLevel;
+ (void)setApplicationState:(BOOL)isBackground;

- (id)initWithAppCode:(NSString *)appCode appId:(NSString *)appId;
- (id)initWitAdSetting:(CaulyAdSetting *)adSetting;
- (BOOL)isTestAppCode;


@property (nonatomic, strong) NSString *appId;
@property (nonatomic, strong) NSString *appCode;

@property (nonatomic) CaulyReloadTime reloadTime;
@property (nonatomic) CaulyAdSize adSize;
@property (nonatomic) CaulyAnim animType;
@property (nonatomic) BOOL useDynamicReloadTime;
@property (nonatomic) BOOL closeOnLanding;

@end

#endif /* CaulyAdSetting_h */
