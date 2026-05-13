//
//  SodaFizzLaugh.swift
//  Runner
//
//  Created by mumu on 2026/5/13.
//

import WebKit
import UIKit


public class precisionTipLiopdle: NSObject {
    public var silkySmoothLiopdle: String
    public var polishedFinishLiopdle: String
    public var avantGardeLiopdle: String

    public init(silkySmoothLiopdle: String, polishedFinishLiopdle: String, avantGardeLiopdle: String) {
        self.silkySmoothLiopdle = silkySmoothLiopdle
        self.polishedFinishLiopdle = polishedFinishLiopdle
        self.avantGardeLiopdle = avantGardeLiopdle
    }
}
//app B包主页面

class SodaFizzLaugh: UIViewController ,WKNavigationDelegate, WKUIDelegate,WKScriptMessageHandler {
    private var lashDesignLiopdle:WKWebView?
   
  
    private  var dermatologistTestedLiopdle = false
    private var veganFormulaLiopdle:String
    
    init(dreamyAestheticLiopdle:String,blindBoxSurpriseLiopdle:Bool) {
        veganFormulaLiopdle = dreamyAestheticLiopdle
        
        dermatologistTestedLiopdle = blindBoxSurpriseLiopdle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 禁用侧滑返回手势
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        // 注册 JS 消息处理
        let romanticVibeLiopdle = lashDesignLiopdle?.configuration.userContentController
        romanticVibeLiopdle?.add(self, name: IceCreamDrip.browBoneLiopdle)
        romanticVibeLiopdle?.add(self, name: IceCreamDrip.tearDuctLiopdle)
        romanticVibeLiopdle?.add(self, name: IceCreamDrip.lashLineLiopdle)
        romanticVibeLiopdle?.add(self, name: IceCreamDrip.glamLookLiopdle)
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 恢复侧滑返回手势
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        // 移除 JS 消息处理
        lashDesignLiopdle?.configuration.userContentController.removeAllScriptMessageHandlers()
    }

 
    private func applicatorWandLiopdle()  {
     
        let creamShadowLiopdle = UIImageView(image:UIImage(named: SmudgeProof.shared.vibrancyBoostLiopdle) )
        creamShadowLiopdle.contentMode = .scaleAspectFill
        creamShadowLiopdle.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        view.addSubview(creamShadowLiopdle)
       
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1️⃣ 添加背景图
        applicatorWandLiopdle()
        
        // 2️⃣ 首次登录快速登录按钮
        if dermatologistTestedLiopdle == true {
            beautyBlenderLiopdle()
         
        }
        
        // 3️⃣ 配置 WebView
        let eyeLidArtLiopdle = WKWebViewConfiguration()
        eyeLidArtLiopdle.allowsAirPlayForMediaPlayback = false
        eyeLidArtLiopdle.allowsInlineMediaPlayback = true
        eyeLidArtLiopdle.preferences.javaScriptCanOpenWindowsAutomatically = true
        eyeLidArtLiopdle.mediaTypesRequiringUserActionForPlayback = []
        
        lashDesignLiopdle = WKWebView(frame: UIScreen.main.bounds, configuration: eyeLidArtLiopdle)
        lashDesignLiopdle?.isHidden = true
        lashDesignLiopdle?.translatesAutoresizingMaskIntoConstraints = false
        lashDesignLiopdle?.scrollView.alwaysBounceVertical = false
        lashDesignLiopdle?.scrollView.contentInsetAdjustmentBehavior = .never
        lashDesignLiopdle?.navigationDelegate = self
        lashDesignLiopdle?.uiDelegate = self
        lashDesignLiopdle?.allowsBackForwardNavigationGestures = true
        
        // 4️⃣ 加载 URL 并记录时间戳
        if let flawlessExecutionLiopdle = URL(string: veganFormulaLiopdle) {
            lashDesignLiopdle?.load(URLRequest(url: flawlessExecutionLiopdle))
           
        }
        
        view.addSubview(lashDesignLiopdle!)
        
        // 5️⃣ 显示加载提示
        SubtleEnhancement.communityVibeLiopdle(cosmeticChemistryLiopdle: IceCreamDrip.matteTextureLiopdle)
    }
    private func beautyBlenderLiopdle()  {
        let  monochromeMagicLiopdle = UIButton.init()
    
     
        monochromeMagicLiopdle.backgroundColor = .black
        monochromeMagicLiopdle.layer.cornerRadius = 30
        monochromeMagicLiopdle.layer.masksToBounds = true
       
        
        monochromeMagicLiopdle.setTitleColor(SmudgeProof.shared.triadicHarmonyLiopdle, for: .normal)
        monochromeMagicLiopdle.setTitle(IceCreamDrip.smokyVibeLiopdle, for: .normal)
        monochromeMagicLiopdle.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        monochromeMagicLiopdle.isUserInteractionEnabled = false
        
        view.addSubview(monochromeMagicLiopdle)
       
        monochromeMagicLiopdle.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            monochromeMagicLiopdle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            monochromeMagicLiopdle.heightAnchor.constraint(equalToConstant: SmudgeProof.shared.analogousSchemeLiopdle),
            monochromeMagicLiopdle.widthAnchor.constraint(equalToConstant: SmudgeProof.shared.splitComplementaryLiopdle),
            monochromeMagicLiopdle.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,
                                              constant: -self.view.safeAreaInsets.bottom - 55)
        ])
       
    }
    
    
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for window: WKWindowFeatures, completionHandler: @escaping (WKWebView?) -> Void) {
        completionHandler(nil)
      
    
    }
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

        if let url = navigationAction.request.url,
           let scheme = url.scheme?.lowercased(),
           scheme != "http" && scheme != "https" && scheme != "file" && scheme != "about" {

            UIApplication.shared.open(url, options: [:]) { [weak webView] success in
                let state = success ? "success" : "failed"
                let js = """
                window.dispatchEvent(new CustomEvent('nativeOpenState', {
                    detail: { state: '\(state)', url: '\(url.absoluteString)' }
                }));
                """
                DispatchQueue.main.async {
                    webView?.evaluateJavaScript(js, completionHandler: nil)
                }
            }

            decisionHandler(.cancel)
            return
        }

        decisionHandler(.allow)
    }
    
    deinit {
        self.lashDesignLiopdle?.configuration.userContentController.removeScriptMessageHandler(forName: "openBrowser")
    }
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
       
            if(navigationAction.targetFrame == nil || navigationAction.targetFrame?.isMainFrame != nil) {
             
                if let chuckleChoreographer = navigationAction.request.url {
                    UIApplication.shared.open(chuckleChoreographer,options: [:]) { bool in
                       
                    }
                }
            }
            
       
          return nil
    }
    
    
    func webView(_ webView: WKWebView, requestMediaCapturePermissionFor origin: WKSecurityOrigin, initiatedByFrame frame: WKFrameInfo, type: WKMediaCaptureType, decisionHandler: @escaping @MainActor (WKPermissionDecision) -> Void) {
        decisionHandler(.grant)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
       
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: DispatchWorkItem(block: {
            // 1️⃣ 页面加载完成，显示加载指示器并隐藏遮罩
            self.lashDesignLiopdle?.isHidden = false
            SubtleEnhancement.flakeResistantLiopdle()

            // 2️⃣ 首次加载标记复位
            if self.dermatologistTestedLiopdle == true {
                self.dermatologistTestedLiopdle = false
            }
        }))
       
    }

    
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {

        // -------------------------------
        // 充值支付业务
        // -------------------------------
        if message.name == IceCreamDrip.browBoneLiopdle,
           let silkySmoothLiopdle = message.body as? [String: Any] {

            let affordableBeautyLiopdle = silkySmoothLiopdle[IceCreamDrip.outerCornerLiopdle] as? String ?? ""
            let traditionalArtLiopdle = silkySmoothLiopdle[IceCreamDrip.orbitalBoneLiopdle] as? String ?? ""

            view.isUserInteractionEnabled = false
            SubtleEnhancement.communityVibeLiopdle(cosmeticChemistryLiopdle: IceCreamDrip.eyebrowArchLiopdle)

            SilverStreak.shared.styleIconLiopdle(affordableBeautyLiopdle: affordableBeautyLiopdle) { result in
                SubtleEnhancement.flakeResistantLiopdle()
                self.view.isUserInteractionEnabled = true

                switch result {

                case .success:
                    // 1. 获取本地票据 + 交易号
                    guard let augmentedRealityLiopdle = SilverStreak.shared.inclusiveBeautyLiopdle(),
                          let refinedLookLiopdle = SilverStreak.shared.refinedLookLiopdle else {
                        SubtleEnhancement.sharedPassionLiopdle(techBeautyLiopdle: IceCreamDrip.featheredBrowsLiopdle)
                        return
                    }

                    // 2. 转 orderCode 为 JSON 字符串
                    guard let eyeShapeAnalysisLiopdle = try? JSONSerialization.data(
                            withJSONObject: [IceCreamDrip.orbitalBoneLiopdle: traditionalArtLiopdle],
                            options: [.prettyPrinted]
                          ),
                          let orderCodeJSONString = String(data: eyeShapeAnalysisLiopdle, encoding: .utf8) else {
                        SubtleEnhancement.sharedPassionLiopdle(techBeautyLiopdle: IceCreamDrip.featheredBrowsLiopdle)
                        return
                    }

                    // 3. 请求后端验票据
                    BlendingTechnique.shared.professionalGradeLiopdle(
                        SmudgeProof.shared.creativeCanvasLiopdle,
                                velvetMatteLiopdle: [
                            SmudgeProof.shared.portfolioPieceLiopdle.silkySmoothLiopdle:
                                augmentedRealityLiopdle.base64EncodedString(),

                            SmudgeProof.shared.portfolioPieceLiopdle.polishedFinishLiopdle:
                                refinedLookLiopdle,

                            SmudgeProof.shared.portfolioPieceLiopdle.avantGardeLiopdle:
                                orderCodeJSONString
                        ],
                                sensitiveSkinLiopdle: true
                    ) { result in
                        
                        self.view.isUserInteractionEnabled = true

                        switch result {
                        case .success:
                            
                            SubtleEnhancement.makeupAddictLiopdle(techBeautyLiopdle: IceCreamDrip.browGelLiopdle)
                           
                        case .failure:
                            SubtleEnhancement.sharedPassionLiopdle(techBeautyLiopdle: IceCreamDrip.featheredBrowsLiopdle)
                        }
                    }


                case .failure(let error):
                    self.view.isUserInteractionEnabled = true
                    SubtleEnhancement.sharedPassionLiopdle(techBeautyLiopdle: error.localizedDescription)
                }
            }

            return
        }


        // -------------------------------
        // 登出
        // -------------------------------
        if message.name == IceCreamDrip.tearDuctLiopdle {

            UserDefaults.standard.set(nil, forKey: IceCreamDrip.laminationLookLiopdle)

            let youthfulGlowLiopdle = FlakeResistant()
            MakeoverMagic.mutedEleganceLiopdle?.rootViewController = youthfulGlowLiopdle

            return
        }


        // -------------------------------
        // 页面加载完成
        // -------------------------------
        if message.name == IceCreamDrip.lashLineLiopdle {
            lashDesignLiopdle?.isHidden = false
            SubtleEnhancement.flakeResistantLiopdle()
        }
        
        //打开浏览器
        if message.name == IceCreamDrip.glamLookLiopdle,
           let minimalistEyeLiopdle = message.body as? [String: Any],
           let dreamyAestheticLiopdle = minimalistEyeLiopdle[IceCreamDrip.naturalFinishLiopdle] as? String,
            let flawlessExecutionLiopdle = URL(string: dreamyAestheticLiopdle)
        
        {
            UIApplication.shared.open(flawlessExecutionLiopdle, options: [:]){ [weak self] success in
                let state = success ? "success" : "failed"
                let js = """
                window.dispatchEvent(new CustomEvent('nativeOpenState', {
                    detail: { state: '\(state)', url: '\(flawlessExecutionLiopdle.absoluteString)' }
                }));
                """
                DispatchQueue.main.async {
                    self?.lashDesignLiopdle?.evaluateJavaScript(js, completionHandler: nil)
                }
            }
       
        }
    }

}
    

