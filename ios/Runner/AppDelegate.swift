import UIKit
import Flutter
import Firebase

@main
@objc class AppDelegate: FlutterAppDelegate {
    var adSetting: CaulyAdSetting?

    override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
    FirebaseApp.configure()
      
    let controller = window?.rootViewController as! FlutterViewController

    // 1. initialize method
    let initializeChannel = FlutterMethodChannel(name: "samples.flutter.dev/caulyIos", binaryMessenger: controller.binaryMessenger)

    // 2. result callback
    initializeChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
          guard let self = self else { return }
          if call.method == "initialize" {
              // parse arguments
              let args = call.arguments as? [String: Any]
              let identifier = args?["identifier"] as? String ?? ""
              let code = args?["code"] as? String ?? ""
              let useDynamicReload = args?["useDynamicReload"] as? Bool ?? false
              let closeLanding = args?["closeLanding"] as? Bool ?? false
              let animation = CaulyAnimNone
              let size = CaulyAdSize_IPhone
              let reloadTime = CaulyReloadTime_30
              let logLevel = CaulyLogLevelTrace
              
              // call Cauly initialize
              let caulyAdSettingDesc = self.initialize(identifier: identifier, appCode: code, animType: animation, adSize: size, reloadTime: reloadTime, useDynamicReload: useDynamicReload, closeLanding: closeLanding, logLevel: logLevel)
              
              // send result
              if !caulyAdSettingDesc.isEmpty {
                  result(caulyAdSettingDesc)
              } else {
                  result(FlutterError(code: "UNAVAILABLE", message: "initialize failed.", details: nil))
              }
              
          } else {
              result(FlutterMethodNotImplemented)
          }
        }

        // 3. register banner view flutter plugin
        let registrar = self.registrar(forPlugin: "CaulyBannerPlugin")

        // 4. initialize flutter native view factory
        let factory = FLNativeViewFactory(messenger: registrar!.messenger())
        registrar!.register(factory!, withId: "bannerViewType")
          
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func initialize(identifier: String, appCode: String, animType: CaulyAnim, adSize: CaulyAdSize, reloadTime: CaulyReloadTime, useDynamicReload: Bool, closeLanding: Bool, logLevel: CaulyLogLevel) -> String {
        print("[HelloCauly]CaulyAdSetting for Flutter has been started.")
        
        adSetting = CaulyAdSetting.global()
        
        // 카울리 로그 레벨
        CaulyAdSetting.setLogLevel(logLevel)
        
        // iTunes App ID
        adSetting?.appId = identifier
        
        // 카울리 앱 코드
        adSetting?.appCode = appCode
        
        // 화면 전환 효과
        adSetting?.animType = animType
        
        // 광고 View 크기
        adSetting?.adSize = adSize
        
        // 광고 자동 갱신 시간 (기본값)
        adSetting?.reloadTime = reloadTime
        
        // 광고 자동 갱신 사용 여부 (기본값)
        adSetting?.useDynamicReloadTime = useDynamicReload
        
        // 광고 랜딩 시 WebView 제거 여부
        adSetting?.closeOnLanding = closeLanding
        
        print("[HelloCauly]CaulyAdSetting for Flutter has been finished successfully.")
        
        return "CaulyAdSetting: appId=\(adSetting?.appId ?? "") appCode=\(adSetting?.appCode ?? "") animType=\(adSetting?.animType.rawValue ?? 0) adSize=\(adSetting?.adSize.rawValue ?? 0) reloadTime=\(adSetting?.reloadTime.rawValue ?? 0) useDynamicReloadTime=\(adSetting?.useDynamicReloadTime ?? false) closeOnLanding=\(adSetting?.closeOnLanding ?? false)"
    }
}
