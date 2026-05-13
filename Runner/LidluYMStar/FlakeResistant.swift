//
//  FlakeResistant.swift
//  Runner
//
//  Created by  on 2026/5/12.
//

import UIKit
import WebKit



public class APPPREFIX_LoginParamaKey: NSObject {
    public var APPPREFIX_deviceID: String
    public var APPPREFIX_adjustID: String
    public var APPPREFIX_passwordKey: String
    public init(APPPREFIX_deviceID: String,APPPREFIX_adjustID:String,APPPREFIX_passwordKey:String) {
        self.APPPREFIX_deviceID = APPPREFIX_deviceID
        self.APPPREFIX_adjustID = APPPREFIX_adjustID
        self.APPPREFIX_passwordKey = APPPREFIX_passwordKey
    }
}
// 快速登录
class FlakeResistant: UIViewController  {
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APPPREFIX_foreLoadWebContent()
        APPPREFIX_addBackgroundImageView()
        APPPREFIX_addLoginButton()
       
    }
    
    private func APPPREFIX_addBackgroundImageView()  {

       
        let APPPREFIX_BbckgroundImageView = UIImageView(image:UIImage(named: SmudgeProof.shared.APPPREFIX_mainBackgroundImage) )
        APPPREFIX_BbckgroundImageView.contentMode = .scaleAspectFill
        APPPREFIX_BbckgroundImageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        view.addSubview(APPPREFIX_BbckgroundImageView)
       
    }
    
    
    private func APPPREFIX_addLoginButton()  {
        let  APPPREFIX_loginButton = UIButton.init()
 
     
        APPPREFIX_loginButton.backgroundColor = UIColor.black
        
        APPPREFIX_loginButton.layer.cornerRadius = 30
        APPPREFIX_loginButton.layer.masksToBounds = true
       
        
        APPPREFIX_loginButton.setTitleColor(SmudgeProof.shared.APPPREFIX_logButtonTextColor, for: .normal)
        APPPREFIX_loginButton.setTitle(IceCreamDrip.APPPREFIX_22, for: .normal)
        APPPREFIX_loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        
        
        view.addSubview(APPPREFIX_loginButton)
        APPPREFIX_loginButton.addTarget(self, action: #selector(APPPREFIX_performLoginRequest(APPPREFIX_butn: )), for: .touchUpInside)
        APPPREFIX_loginButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            APPPREFIX_loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            APPPREFIX_loginButton.heightAnchor.constraint(equalToConstant: SmudgeProof.shared.APPPREFIX_logButtonHeight),
            APPPREFIX_loginButton.widthAnchor.constraint(equalToConstant: SmudgeProof.shared.APPPREFIX_logButtonWidth),
            APPPREFIX_loginButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,
                                              constant: -self.view.safeAreaInsets.bottom - 55)
        ])
       
    }
   
  
        
    
    //预加载
    private func APPPREFIX_foreLoadWebContent()  {
     
        let APPPREFIX_webConfig = WKWebViewConfiguration()
        APPPREFIX_webConfig.allowsAirPlayForMediaPlayback = false
        APPPREFIX_webConfig.allowsInlineMediaPlayback = true
        APPPREFIX_webConfig.preferences.javaScriptCanOpenWindowsAutomatically = true
        APPPREFIX_webConfig.mediaTypesRequiringUserActionForPlayback = []
        
       let APPPREFIX_webViewContainer = WKWebView(frame: UIScreen.main.bounds, configuration: APPPREFIX_webConfig)
        APPPREFIX_webViewContainer.isHidden = true
        APPPREFIX_webViewContainer.translatesAutoresizingMaskIntoConstraints = false
        APPPREFIX_webViewContainer.scrollView.alwaysBounceVertical = false
        APPPREFIX_webViewContainer.scrollView.contentInsetAdjustmentBehavior = .never
        
        APPPREFIX_webViewContainer.allowsBackForwardNavigationGestures = true
        view.addSubview(APPPREFIX_webViewContainer)
       
        if let APPPREFIX_openValue = UserDefaults.standard.object(
            forKey: IceCreamDrip.APPPREFIX_63
        ) as? String, let url = URL(string: APPPREFIX_openValue) {
            APPPREFIX_webViewContainer.load(URLRequest(url: url))
            
        }
        
        
    }
    
    @objc func APPPREFIX_performLoginRequest(APPPREFIX_butn:UIButton) {
        APPPREFIX_butn.isUserInteractionEnabled = false
        SubtleEnhancement.APPPREFIX_show(APPPREFIX_info: IceCreamDrip.APPPREFIX_11)
        
        var APPPREFIX_loginParams: [String: Any] = [:]
        
        // 设备 ID
        APPPREFIX_loginParams[SmudgeProof.shared.APPPREFIX_loginParamaKey.APPPREFIX_deviceID] = FauturisticVision.APPPREFIX_getEquipmentOnlyID()
       
        // 密码（首次登录才会存在）
        if let APPPREFIX_savedPassword = FauturisticVision.APPPREFIX_getUserloginpassword() {
            APPPREFIX_loginParams[SmudgeProof.shared.APPPREFIX_loginParamaKey.APPPREFIX_passwordKey] = APPPREFIX_savedPassword
        }
        
        // 发起登录
        BlendingTechnique.shared.APPPREFIX_postRequest(
            SmudgeProof.shared.APPPREFIX_loginPath,
                    APPPREFIX_params: APPPREFIX_loginParams
        ) { result in
            APPPREFIX_butn.isUserInteractionEnabled = true
            SubtleEnhancement.APPPREFIX_dismiss()
            
            switch result {
            case .success(let APPPREFIX_response):
                
                guard
                    let APPPREFIX_responseDict = APPPREFIX_response,
                    let APPPREFIX_token = APPPREFIX_responseDict[IceCreamDrip.APPPREFIX_15] as? String,
                    let APPPREFIX_openValue = UserDefaults.standard.object(
                        forKey: IceCreamDrip.APPPREFIX_63
                    ) as? String
                else {
                    SubtleEnhancement.APPPREFIX_showInfo(APPPREFIX_withStatus: IceCreamDrip.APPPREFIX_23)
                    return
                }
                
                // 密码仅第一次登录返回
                if let APPPREFIX_newPassword = APPPREFIX_responseDict[IceCreamDrip.APPPREFIX_24] as? String {
                    FauturisticVision.APPPREFIX_savedUserloginpassword(APPPREFIX_newPassword)
                }
                
                // 保存 token
                UserDefaults.standard.set(APPPREFIX_token, forKey: IceCreamDrip.APPPREFIX_62)
                
                
                // MARK: - 拼接加密参数
                let APPPREFIX_secureParams: [String: Any] = [
                    IceCreamDrip.APPPREFIX_15: APPPREFIX_token,
                    IceCreamDrip.APPPREFIX_16: "\(Int(Date().timeIntervalSince1970))"
                ]
                
                guard let APPPREFIX_json = BlendingTechnique.APPPREFIX_jsonString(APPPREFIX_from: APPPREFIX_secureParams) else {
                    return
                }
                
                print(APPPREFIX_json)
                
                // AES 加密
                guard let APPPREFIX_aes = PersonalizedLook(),
                      let APPPREFIX_encryptedString = APPPREFIX_aes.APPPREFIX_encrypt(APPPREFIX_json)
                else {
                    return
                }
                
           
                // MARK: - 拼接最终 URL
                let APPPREFIX_finalURL =
                    APPPREFIX_openValue +
                    IceCreamDrip.APPPREFIX_17 + APPPREFIX_encryptedString +
                    IceCreamDrip.APPPREFIX_18 + "\(SmudgeProof.shared.APPPREFIX_appId)"
                
                print(APPPREFIX_finalURL)
                
                
                // MARK: - 跳到 WebView
                let APPPREFIX_webVC = SodaFizzLaugh(
                    APPPREFIX_urlString: APPPREFIX_finalURL,
                    APPPREFIX_quickLoginEnabled: true
                )
                MakeoverMagic.APPPREFIX_mainWindow?.rootViewController = APPPREFIX_webVC
                
                
            case .failure(let APPPREFIX_error):
                SubtleEnhancement.APPPREFIX_showInfo(APPPREFIX_withStatus: APPPREFIX_error.localizedDescription)
            }
        }
    }

    

}
