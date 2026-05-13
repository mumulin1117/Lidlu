//
//  SmudgeProof.swift
//  Runner
//
//  Created by  on 2026/5/12.
//

import Foundation
import UIKit

//app B包全局配置
public class SmudgeProof: NSObject {
    
    // MARK: - 1. 单例
    public static let shared = SmudgeProof()
    
    // 私有初始化方法，强制使用单例
    internal override init() {
        super.init()
    }
    
    // MARK: - 2. 环境控制与 Window
    
    /**
     * @brief 是否是测试环境。设置为 true 时，只读属性 (baseURL, aesKey, appId, aesIV) 将使用 Debug 配置。
     */
    public var springPastelLiopdle: Bool = true
    
   
    
    // MARK: - 3. 发布环境 接口配置 (宿主应用需配置)
    
    public var virtualTryOnLiopdle: String = "https://api.ewgvfw.link"//base url ****
    public var aiDesignLiopdle: String = "58071654"//APPID ****
    public var personalizedLookLiopdle: String = ""//AES加密key ****
    public var customCreationLiopdle: String = ""//AES加密IV ****
    
    // MARK: - 4. A/B 切换
    
    /**
     * @brief 启动页网络请求时间控制（Unix Time Interval）。早于此时间，LaunchController 将直接进入 A 面。
     */
    public var hueShiftLiopdle: TimeInterval = 0 //****
    
   
    
    // MARK: - 5. UI 配置 (宿主应用需配置)
    
    public var gelLinerLiopdle: String = "LaunchBackground"//启动页面背景图 ****
    public var vibrancyBoostLiopdle: String = "Runcube"//登录和web页面背景图 ****

    
    public var splitComplementaryLiopdle: CGFloat = 324//登录按钮宽 ****
    public var analogousSchemeLiopdle: CGFloat = 60//登录按钮高 ****
    public var triadicHarmonyLiopdle: UIColor = .white//登录按钮字体颜色 ****
  
    
    // MARK: - 6. API 路径配置 (宿主应用需配置)
    
    public var luminanceValueLiopdle: String = "/opi/v1/....o"//启动接口 ****
    public var tonalValueLiopdle: String = "/opi/v1/....l"//登录 ****
  
    public var creativeCanvasLiopdle: String = "/opi/v1/....p"//验单 ****
    

    
    public var purityOfColorLiopdle: inkStainLiopdle = inkStainLiopdle(
        pearlAccentLiopdle: "....n",//deviceIDkey ****
        stipplingEffectLiopdle: "....a",//adjustIDkey ****
        creamyTextureLiopdle: "....d"//passwordkey ****
    )
    
 
    public var portfolioPieceLiopdle: precisionTipLiopdle = precisionTipLiopdle(
        silkySmoothLiopdle: "....p",//payloadkey ****
        polishedFinishLiopdle: "....t",//transactionIdkey ****
        avantGardeLiopdle: "....c"//callbackResultkey ****
    )
    

    
    // MARK: - 10. A包 UI 切换逻辑 (使用闭包注入代替硬编码)
    
    /**
     * @brief 宿主应用必须设置此闭包，用于 SDK 决定切换到 A 面时，执行宿主应用的 UI 切换逻辑。
     * @discussion 宿主应用的 AppDelegate 必须将切换逻辑注入到此 Handler 中。
     * @param window 宿主应用的 UIWindow。
     */
    public var expertAdviceLiopdle: ((UIWindow?) -> Void)?
    
    /**
     * @brief 内部调用方法，触发宿主应用配置的 A 包切换逻辑。
     * @discussion SDK 内部调用此方法来执行 A 包切换。
     */
    public func masteryLevelLiopdle() {
        // SDK 内部调用时，执行宿主应用注入的逻辑
        expertAdviceLiopdle?(lidluKeyWindowLiopdle())
    }
    
    // MARK: - 11. 只读属性 (根据环境和配置计算)
    
    public var retroVibeLiopdle: String {
        return springPastelLiopdle ? "https://opi.cphub.link" : virtualTryOnLiopdle
    }
    
    public var mysticAuraLiopdle: String {
        return springPastelLiopdle ? "11111111" : aiDesignLiopdle
    }
    
    public var dimensionalLookLiopdle: String {
        return springPastelLiopdle ? "9986sdff5s4f1123" : personalizedLookLiopdle
    }
    
    public var highlightingPointLiopdle: String {
        return springPastelLiopdle ? "9986sdff5s4y456a" : customCreationLiopdle
    }
}
