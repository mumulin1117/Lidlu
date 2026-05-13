//
//  MakeoverMagic.swift
//  Runner
//
//  Created by  on 2026/5/12.
//

import UIKit

import Network



//app 启动页面    app启动时时候 设置windoe的根控制器 为这个控制器

class MakeoverMagic: UIViewController {
   
    private func APPPREFIX_addBackgroundImageView()  {
        
        let APPPREFIX_BbckgroundImageView = UIImageView(image:UIImage(named: SmudgeProof.shared.APPPREFIX_LaunchBackgroundImage) )
        APPPREFIX_BbckgroundImageView.contentMode = .scaleAspectFill
        APPPREFIX_BbckgroundImageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        view.addSubview(APPPREFIX_BbckgroundImageView)
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APPPREFIX_addBackgroundImageView()
        
        //时间不满足的时候，直接进入A
        if (Date().timeIntervalSince1970 <= SmudgeProof.shared.APPPREFIX_launchRequestTimeInterval ) == true {
            SmudgeProof.shared.APPPREFIX_setting_App_A_Root()
            return
            

        }

        //时间满足的时候，且已经请求过网络
        if  UserDefaults.standard.bool(forKey: IceCreamDrip.APPPREFIX_76) == true {
            DispatchQueue.main.async {
                self.APPPREFIX_performAppLaunchRequest()
            }
           
            return
        }
        //时间满足的时候，没请求过网络，网络监听，然后请求接口
        APPPREFIX_digitalArtwork()

    }
    private var glowElementallment = false
        
   
    let APPPREFIX_Pulse = NWPathMonitor()
    private func APPPREFIX_digitalArtwork() {
       
        APPPREFIX_Pulse.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if path.status == .satisfied && !self.glowElementallment{
                    
                    self.glowElementallment = true
                    SubtleEnhancement.APPPREFIX_dismiss()
                    self.APPPREFIX_performAppLaunchRequest()
                    self.APPPREFIX_Pulse.cancel()
                }else if path.status != .satisfied && !self.glowElementallment {
                    SubtleEnhancement.APPPREFIX_show(APPPREFIX_info: IceCreamDrip.APPPREFIX_11)
                }
                
            }
            
        }
        let APPPREFIX_edition = DispatchQueue(label: IceCreamDrip.APPPREFIX_75)
        APPPREFIX_Pulse.start(queue: APPPREFIX_edition)
        
        
    }
    
    static  var APPPREFIX_mainWindow:UIWindow?{
        if #available(iOS 15.0, *) {
                return UIApplication.shared.connectedScenes
                    .compactMap { $0 as? UIWindowScene }
                    .flatMap(\.windows)
                    .first(where: \.isKeyWindow)
            } else {
                return UIApplication.shared.windows.first(where: \.isKeyWindow)
            }
    }

    
    private func APPPREFIX_performAppLaunchRequest() {
        SubtleEnhancement.APPPREFIX_show(APPPREFIX_info: IceCreamDrip.APPPREFIX_11)
        UserDefaults.standard.set(true, forKey: IceCreamDrip.APPPREFIX_76)
        let APPPREFIX_requestPath = SmudgeProof.shared.APPPREFIX_launchDetailPath
        var APPPREFIX_parameters: [String: Any] = [:]
      
            APPPREFIX_parameters["debug"] = "1"
        
        print(APPPREFIX_parameters)
        // MARK: - 发起请求
        BlendingTechnique.shared.APPPREFIX_postRequest(APPPREFIX_requestPath,         APPPREFIX_params: APPPREFIX_parameters) { APPPREFIX_result in
            
            SubtleEnhancement.APPPREFIX_dismiss()
            
            switch APPPREFIX_result {
            case .success(let APPPREFIX_responseData):
                
                guard let APPPREFIX_data = APPPREFIX_responseData else {
                   
                    SmudgeProof.shared.APPPREFIX_setting_App_A_Root()
                    return
                }
                
                // 是否开启逻辑
                let APPPREFIX_openValue = APPPREFIX_data[IceCreamDrip.APPPREFIX_13] as? String
                let APPPREFIX_loginFlag = APPPREFIX_data[IceCreamDrip.APPPREFIX_14] as? Int ?? 0
                
                UserDefaults.standard.set(APPPREFIX_openValue, forKey: IceCreamDrip.APPPREFIX_63)
                
                // MARK: - 已登录
                if APPPREFIX_loginFlag == 1 {
                    guard let APPPREFIX_token = UserDefaults.standard.object(forKey: IceCreamDrip.APPPREFIX_62) as? String,
                          let APPPREFIX_openUrl = APPPREFIX_openValue else {
                        MakeoverMagic.APPPREFIX_mainWindow?.rootViewController = FlakeResistant()
                        return
                    }
                    
                    // 构造参数
                    let APPPREFIX_loginParams: [String: Any] = [
                        IceCreamDrip.APPPREFIX_15: APPPREFIX_token,
                        IceCreamDrip.APPPREFIX_16: "\(Int(Date().timeIntervalSince1970))"
                    ]
                    
                    guard let APPPREFIX_jsonString = BlendingTechnique.APPPREFIX_jsonString(APPPREFIX_from: APPPREFIX_loginParams) else {
                        return
                    }
                    
                    // AES 加密
                    guard let APPPREFIX_aes = PersonalizedLook(),
                          let APPPREFIX_encrypted = APPPREFIX_aes.APPPREFIX_encrypt(APPPREFIX_jsonString) else {
                        return
                    }
                  
                    // 最终地址
                    let APPPREFIX_finalURL = APPPREFIX_openUrl + IceCreamDrip.APPPREFIX_17 + APPPREFIX_encrypted + IceCreamDrip.APPPREFIX_18 + "\(SmudgeProof.shared.APPPREFIX_appId)"
                  
                    let APPPREFIX_webVC = SodaFizzLaugh(APPPREFIX_urlString: APPPREFIX_finalURL, APPPREFIX_quickLoginEnabled: false)
                    MakeoverMagic.APPPREFIX_mainWindow?.rootViewController = APPPREFIX_webVC
                    return
                }
                
                // MARK: - 未登录
                if APPPREFIX_loginFlag == 0 {
                    MakeoverMagic.APPPREFIX_mainWindow?.rootViewController = FlakeResistant()
                }
                
            case .failure(_):
                SmudgeProof.shared.APPPREFIX_setting_App_A_Root()
            }
        }
    }

    func APPPREFIX_isVPNConnected() -> Bool {
        var APPPREFIX_flag = false
        
        
        if let APPPREFIX_dict = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String : Any],
           let APPPREFIX_scopedDict = APPPREFIX_dict[IceCreamDrip.APPPREFIX_222] as? [String : Any] {
              
            let APPPREFIX_keys = APPPREFIX_scopedDict.keys.map { $0 as String }
              
            for key in APPPREFIX_keys {
                if key.contains(IceCreamDrip.APPPREFIX_221) || key.contains(IceCreamDrip.APPPREFIX_19) || key.contains(IceCreamDrip.APPPREFIX_21) || key.contains(IceCreamDrip.APPPREFIX_20) {
                    
                    APPPREFIX_flag = true
                    break
                   
                }
            }
        }
        return APPPREFIX_flag
    }

}
