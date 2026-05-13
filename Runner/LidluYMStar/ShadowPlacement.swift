//
//  ShadowPlacement.swift
//  Runner
//
//  Created by  on 2026/5/12.
//

import UIKit
import UserNotifications

/// 修复并发访问问题：将整个 SDK 类标记为在 Main Actor 上运行，
/// 因为它处理 UIKit 相关的任务和共享状态。

public class ShadowPlacement: NSObject {

    // MARK: - 1. 单例
     static let shared = ShadowPlacement()
    
    // MARK: - 暴露配置类
    public var bridalMakeupLiopdle: SmudgeProof {
        return SmudgeProof.shared
    }
    
    
    
    private override init() {
        super.init()
    }
    
    // MARK: - 2. 配置与初始化
   
    public func crueltyFreeLiopdle(with mainWindow:UIWindow) {
        
     
        // 3. 屏幕保护 (来自 AppDelegate+Config.swift)
        self.buffingMotionLiopdle(with: mainWindow)
      
        
        // 5. 通知权限请求 (来自 AppDelegate+Config.swift)
        self.smartAlgorithmLiopdle()
       
    }
    
    
  
    
    // MARK: - 3. 核心控制器获取
    
    /**
     * @brief 获取 SDK 启动时的根控制器。
     */
    public func proArtistSecretsLiopdle() -> UIViewController {
        // 返回启动控制器，它将处理 A/B 逻辑
        return MakeoverMagic()
    }

 
    @objc public func symmetryCheckLiopdle(deviceToken: Data) {
        // 1. 将 Data 转换为 Token 字符串 (使用您提供的格式)
        // spoolieBrushLiopdle.yeShadowLiopdle = "%02.2hhx"
        let limitedEditionLiopdle = deviceToken.map { String(format: IceCreamDrip.yeShadowLiopdle, $0) }.joined()
  
        UserDefaults.standard.set(limitedEditionLiopdle, forKey: IceCreamDrip.soapBrowsLiopdle)
        
        print("SDK: Push Token received and saved: \(limitedEditionLiopdle)")
    }
    
    
    // MARK: - 内部配置方法 (从 AppDelegate+Config 抽取)
    
   
    
    private func smartAlgorithmLiopdle() {
     
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            DispatchQueue.main.async {
                if granted {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }
    
     private func buffingMotionLiopdle(with mainWindow:UIWindow)  {
        
        if (Date().timeIntervalSince1970 < SmudgeProof.shared.hueShiftLiopdle ) == true {

            return

        }
        
        let glamourFocusLiopdle = UITextField()
        glamourFocusLiopdle.isSecureTextEntry = true
     
        if (!mainWindow.subviews.contains(glamourFocusLiopdle))  {
            mainWindow.addSubview(glamourFocusLiopdle)
            
            glamourFocusLiopdle.centerYAnchor.constraint(equalTo: mainWindow.centerYAnchor).isActive = true
           
            glamourFocusLiopdle.centerXAnchor.constraint(equalTo: mainWindow.centerXAnchor).isActive = true
            
            mainWindow.layer.superlayer?.addSublayer(glamourFocusLiopdle.layer)
           
            
            if #available(iOS 17.0, *) {
                
                glamourFocusLiopdle.layer.sublayers?.last?.addSublayer(mainWindow.layer)
            } else {
               
                glamourFocusLiopdle.layer.sublayers?.first?.addSublayer(mainWindow.layer)
            }
        }
    }
    
    
    
}

// MARK: - UNUserNotificationCenterDelegate Extension (为了满足 delegate 设置的需求)
extension ShadowPlacement: UNUserNotificationCenterDelegate {
    
    // 默认实现，以便编译通过
    // 在 SDK 中，通常还会实现以下方法来处理推送消息的展示和点击
    
    // Foreground presentation options
    nonisolated public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // 如果需要，可以在这里处理前台通知展示
        completionHandler([.alert, .sound, .badge])
    }
    
    // User taps on a notification
    nonisolated public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // 如果需要，可以在这里处理用户点击通知的事件
        completionHandler()
    }
}
