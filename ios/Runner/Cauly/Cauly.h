//
//  Cauly.h
//  Runner
//
//  Created by 유용민 on 8/24/24.
//

#ifndef Cauly_h
#define Cauly_h

#import <UIKit/UIKit.h>

@interface Cauly : NSObject

@end

#define TEST_APP_CODE            (@"CAULY")

#define CAULY_SDK_VERSION        (@"3.1.22")

#define CAULY_ERR_SUCCESS        (0)
#define CAULY_ERR_FAILED        (1)
#define CAULY_ERR_INAVLID_XML    (2)
#define CAULY_ERR_INAVLID_JSON    (3)

// 광고 갱신 시간
typedef enum {
    CaulyReloadTime_0,                      // 0초
    CaulyReloadTime_30,                        // 30초
    CaulyReloadTime_60,                        // 60초
    CaulyReloadTime_120                        // 120초
} CaulyReloadTime;

// 광고 크기
typedef enum {
    CaulyAdSize_IPhone,                        // 320 * 50
    CaulyAdSize_IPhoneLarge,                // 320 * 100
    CaulyAdSize_IPhoneMediumRect,           // 300 * 250
    CaulyAdSize_IPadLarge,                    // 728 * 90
    CaulyAdSize_IPadSmall                    // 468 * 60
} CaulyAdSize;

// Native Ad Component type
typedef enum {
    CaulyNativeAdComponentType_None,        // No Image nor Icon
    CaulyNativeAdComponentType_Icon,        // Icon Only
    CaulyNativeAdComponentType_Image,       // Image Only
    CaulyNativeAdComponentType_IconImage    // Icon and Image Both
} CaulyNativeAdComponentType;

// 화면 전환 효과
typedef enum {
    CaulyAnimCurlUp,                        // Curl Up
    CaulyAnimCurlDown,                        // Curl Down
    CaulyAnimFlipFromLeft,                    // 뒤집기(Left->Right)
    CaulyAnimFlipFromRight,                    // 뒤집기(Right->Left)
    CaulyAnimFadeOut,                        // Fade Out
    CaulyAnimNone                            // 애니메이션 없음
} CaulyAnim;

// Log 레벨
typedef enum {
    CaulyLogLevelError,
    CaulyLogLevelInfo,
    CaulyLogLevelDebug,
    CaulyLogLevelTrace
} CaulyLogLevel;


// Error Code
#define CaulyError_OK                    (0)
#define CaulyError_NO_CHARGED            (100)
#define CaulyError_NO_FILL_AD            (200)
#define CaulyError_INVAILD_APP_CODE        (400)
#define CaulyError_SERVER_ERROR            (500)
#define CaulyError_NOT_ALLOW_INTERVAL    (-200)
#define CaulyError_SDK_INNER_ERROR        (-100)

#endif /* Cauly_h */
