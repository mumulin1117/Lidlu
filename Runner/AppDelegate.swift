import UIKit
import UserNotifications

@main
final class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    var window: UIWindow?
     let nativeRoot = UINavigationController()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        installNativeRoot()
        return true
    }


   
     func installNativeRoot() {
        window = UIWindow(frame: UIScreen.main.bounds)
         SmudgeProof.shared.APPPREFIX_setting_App_A_Root_Handler = {[weak self] window in
             guard let self = self else {
                 
                 return
             }
             self.nativeRoot.setNavigationBarHidden(true, animated: false)
             if velvetAuraStore.shared.choseMain {
                 nativeRoot.setViewControllers([prismRootTabsViewController(initialIndex: 1)], animated: false)
             } else {
                 nativeRoot.setViewControllers([makeLoginGate()], animated: false)
             }
             window?.rootViewController = nativeRoot
         }
         
         // --- 3.资源加载  防截屏 通知 权限请求 相关配置 ---
         if let APPPREFIX_window = self.window {
             ShadowPlacement.shared.APPPREFIX_initializeSDK(with: APPPREFIX_window)
         }
         
         
         // --- 4. 设置 Window 根控制器 ---
         window?.rootViewController = ShadowPlacement.shared.APPPREFIX_getLaunchViewController()
         
      
        window?.makeKeyAndVisible()
    }

     func makeLoginGate() -> velvetEntryGateViewController {
        let page = velvetEntryGateViewController()
        page.visualDiary = { [weak self] in
            self?.nativeRoot.setViewControllers([prismRootTabsViewController(initialIndex: 1)], animated: true)
        }
        page.portfolioPiece = { [weak self] in
            self?.nativeRoot.pushViewController(ivorygorgeousFinishViewController(kind: .epicTransformation), animated: true)
        }
        page.creativeCanvas = { [weak self] in
            self?.nativeRoot.pushViewController(ivorygorgeousFinishViewController(kind: .stunningResult), animated: true)
        }
        return page
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // 将 Push Token 转发给 SDK 进行存储
        ShadowPlacement.shared.APPPREFIX_didRegisterForRemoteNotifications(deviceToken: deviceToken)
    }
}
