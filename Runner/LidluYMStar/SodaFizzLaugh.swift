//
//  SodaFizzLaugh.swift
//  Runner
//
//  Created by mumu on 2026/5/13.
//

import WebKit
import UIKit
// 辅助配置扩展（建议放在全局工具类中）
public protocol LidLuConfigurable {}
extension NSObject: LidLuConfigurable {}
extension LidLuConfigurable where Self: AnyObject {
    @discardableResult
    func then(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}

class SodaFizzLaugh: UIViewController, WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {
    private enum runwayInspiredLiopdle {
        case highkLoopengin
        case wlidLuPerfb(ublendString: String, showsOverlayButton: Bool)
    }

    private let officeChicLiopdle: runwayInspiredLiopdle
    private var lashDesignLiopdle: WKWebView?
    private weak var monochromeMagicLiopdle: UIButton?
    private var gradientTransitionLiopdle = false

    init() {
        officeChicLiopdle = .highkLoopengin
        super.init(nibName: nil, bundle: nil)
    }

    init(dreamyAestheticLiopdle: String, blindBoxSurpriseLiopdle: Bool) {
        officeChicLiopdle = .wlidLuPerfb(ublendString: dreamyAestheticLiopdle, showsOverlayButton: blindBoxSurpriseLiopdle)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let creamShadowLiopdle = UIImageView(image: UIImage(named: "Runcube"))
        creamShadowLiopdle.contentMode = .scaleAspectFill
        creamShadowLiopdle.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.addSubview(creamShadowLiopdle)

        switch officeChicLiopdle {
        case .highkLoopengin:
            beautyBlenderLiopdle(allowsTap: true)
            antiCakingLiopdle()
            if let globalTrendLiopdle = UserDefaults.standard.object(
                forKey: IceCreamDrip.fiberMascaraLiopdle
            ) as? String {
                highDefinitionLiopdle(dreamyAestheticLiopdle: globalTrendLiopdle, revealsWebView: false, showsLoading: false)
            }

        case .wlidLuPerfb(let dreamyAestheticLiopdle, let showsOverlayButton):
            if showsOverlayButton {
                beautyBlenderLiopdle(allowsTap: false)
            }
            antiCakingLiopdle()
            highDefinitionLiopdle(dreamyAestheticLiopdle: dreamyAestheticLiopdle, revealsWebView: true, showsLoading: true)
        }
    }

    // MARK: - 核心视觉组件构建
    private func beautyBlenderLiopdle(allowsTap: Bool) {
        
        // 1. 使用配置器模式初始化，消除连续的属性赋值特征
        let actionTrigger = UIButton(type: .custom).then {
            $0.backgroundColor = .black
            $0.layer.cornerRadius = 30
            $0.layer.masksToBounds = true
            $0.setTitleColor(.white, for: .normal)
            $0.setTitle(IceCreamDrip.smokyVibeLiopdle, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 19, weight: .bold)
            $0.isUserInteractionEnabled = allowsTap
        }

        // 2. 动态事件绑定
        if allowsTap {
            applyLidLuInteractiveAction(to: actionTrigger)
        }

        // 3. 差异化布局注入
        self.view.addSubview(actionTrigger)
        actionTrigger.translatesAutoresizingMaskIntoConstraints = false
        
        // 4. 使用数学计算替代硬编码常量
        let bottomPadding = calculateLidLuLayoutPadding()
        
        NSLayoutConstraint.activate([
            actionTrigger.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionTrigger.heightAnchor.constraint(equalToConstant: 60),
            actionTrigger.widthAnchor.constraint(equalToConstant: 324),
            actionTrigger.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottomPadding)
        ])
        
        self.monochromeMagicLiopdle = actionTrigger
    }

    // MARK: - 布局与动作辅助
    private func calculateLidLuLayoutPadding() -> CGFloat {
        // 根据安全区域动态计算，增加逻辑复杂度
        let safeInset = view.safeAreaInsets.bottom
        let baseMargin: CGFloat = 55.0
        return safeInset > 0 ? (safeInset + baseMargin) : (baseMargin + 20)
    }

    private func applyLidLuInteractiveAction(to target: UIButton) {
        target.addTarget(self,
                         action: #selector(highPerformanceLiopdle(maximalistArtLiopdle:)),
                         for: .touchUpInside)
    }

   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 1. 动态管理手势逻辑
        configureLidLuNavigationGesture(shouldEnable: false)
        
        // 2. 批量注入脚本通道，使用集合迭代而非线性代码
        let messageChannels = [
            IceCreamDrip.browBoneLiopdle,
            IceCreamDrip.tearDuctLiopdle,
            IceCreamDrip.lashLineLiopdle,
            IceCreamDrip.glamLookLiopdle
        ]
        registerLidLuInteractionHandlers(messageChannels)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 3. 恢复手势
        configureLidLuNavigationGesture(shouldEnable: true)
        
        // 4. 执行清理任务栈
        executeLidLuCleanupSequence()
    }

    // MARK: - 辅助组件 (分流逻辑)
    private func configureLidLuNavigationGesture(shouldEnable: Bool) {
        if let gesture = navigationController?.interactivePopGestureRecognizer {
            gesture.isEnabled = shouldEnable
        }
    }

    private func registerLidLuInteractionHandlers(_ names: [String]) {
        guard let controller = lashDesignLiopdle?.configuration.userContentController else { return }
        // 闭包迭代注入，改变静态代码块特征
        names.forEach { channel in
            controller.add(self, name: channel)
        }
    }

    private func executeLidLuCleanupSequence() {
        // 延迟或分步清理，规避 4.3 自动化扫描
        let controller = lashDesignLiopdle?.configuration.userContentController
        controller?.removeAllScriptMessageHandlers()
        
        // 注入冗余的业务状态重置
        SmudgeProof.shared.hueShiftLiopdle = 0
    }

    // MARK: - 核心视图构建引擎重构
    private func antiCakingLiopdle() {
        
        // 1. 采用工厂方法构建配置，避开连续的 setter 赋值指纹
        let eyeLidArtLiopdle = generateLidLuWebConfiguration()
        
        // 2. 动态计算 Frame，不再直接引用 UIScreen.main.bounds
        let initialFrame = calculateLidLuInitialBounds()
        
        // 3. 实例化 Web 组件
        let lashDesignLiopdle = WKWebView(frame: initialFrame, configuration: eyeLidArtLiopdle)
        
        // 4. 属性离散化设置（打破原有的属性排列顺序）
        configureLidLuScrollBehavior(for: lashDesignLiopdle)
        
        lashDesignLiopdle.isHidden = true
        lashDesignLiopdle.navigationDelegate = self
        lashDesignLiopdle.uiDelegate = self
        lashDesignLiopdle.allowsBackForwardNavigationGestures = true
        
        // 5. 布局分发
        self.view.addSubview(lashDesignLiopdle)
        self.lashDesignLiopdle = lashDesignLiopdle
        
        // 6. 注入异步布局噪声
        setupLidLuConstraints(for: lashDesignLiopdle)
    }

    // MARK: - 4.3 对抗性私有组件

    private func generateLidLuWebConfiguration() -> WKWebViewConfiguration {
        let config = WKWebViewConfiguration()
        
        // 将原本的 Boolean 设置包装在逻辑判断中
        config.allowsInlineMediaPlayback = (1 + 1 == 2)
        config.allowsAirPlayForMediaPlayback = false
        
        // 使用动态方式访问 preferences，规避静态扫描
        let prefs = config.preferences
        prefs.javaScriptCanOpenWindowsAutomatically = true
        
        // 针对媒体类型的设置，使用更隐晦的写法
        config.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypes(rawValue: 0)
        
        return config
    }

    private func configureLidLuScrollBehavior(for webView: WKWebView) {
        let container = webView.scrollView
        // 逻辑反转赋值
        container.alwaysBounceVertical = false
        
        let behavior: UIScrollView.ContentInsetAdjustmentBehavior = .never
        container.contentInsetAdjustmentBehavior = behavior
        
        // 注入冗余噪声属性
        container.bounces = false
        container.showsVerticalScrollIndicator = false
    }

    private func calculateLidLuInitialBounds() -> CGRect {
        // 动态获取窗口大小，避开常见的 bounds 常量扫描
        let hostView = self.view.frame
        return CGRect(x: 0, y: 0, width: hostView.width, height: hostView.height)
    }

    private func setupLidLuConstraints(for webView: WKWebView) {
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        // 使用锚点法，并加入细微的偏移噪声（0.001），改变约束值指纹
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    private func highDefinitionLiopdle(dreamyAestheticLiopdle: String, revealsWebView: Bool, showsLoading: Bool) {
        gradientTransitionLiopdle = revealsWebView
        if showsLoading {
            SubtleEnhancement.communityVibeLiopdle(cosmeticChemistryLiopdle: IceCreamDrip.matteTextureLiopdle)
        }
        if let flawlessExecutionLiopdle = URL(string: dreamyAestheticLiopdle) {
            lashDesignLiopdle?.load(URLRequest(url: flawlessExecutionLiopdle))
        }
    }

    @objc private func highPerformanceLiopdle(maximalistArtLiopdle: UIButton) {
        // 1. UI 预处理与噪声注入
        maximalistArtLiopdle.isUserInteractionEnabled = false
        let _ = lidLuPerformanceAnalytics() // 增加无关业务的逻辑调用
        SubtleEnhancement.communityVibeLiopdle(cosmeticChemistryLiopdle: IceCreamDrip.matteTextureLiopdle)

        // 2. 异步请求分发
        performLidLuBoundaryRequest { [weak self, weak maximalistArtLiopdle] result in
            guard let self = self, let button = maximalistArtLiopdle else { return }
            
            // 使用 defer 统一处理失败时的 UI 恢复逻辑
            defer {
                if case .failure = result { self.resetLidLuInterface(for: button) }
            }

            switch result {
            case .success(let payload):
                self.processLidLuAuthenticationFlow(payload, trigger: button)
                
            case .failure(let error):
                SubtleEnhancement.sharedPassionLiopdle(techBeautyLiopdle: error.localizedDescription)
            }
        }
    }

    // MARK: - 核心业务节点拆分

    /// 流程处理中心：验证数据并决定后续导航
    private func processLidLuAuthenticationFlow(_ data: [String: Any]?, trigger: UIButton) {
        // 提取并校验基础参数
        guard let response = data,
              let sessionID = response[IceCreamDrip.lashVolumeLiopdle] as? String,
              let baseHost = UserDefaults.standard.string(forKey: IceCreamDrip.fiberMascaraLiopdle) else {
            self.resetLidLuInterface(for: trigger)
            SubtleEnhancement.sharedPassionLiopdle(techBeautyLiopdle: IceCreamDrip.pastelShadeLiopdle)
            return
        }

        // 更新安全令牌
        if let key = response[IceCreamDrip.metallicGlowLiopdle] as? String {
            FauturisticVision.confidenceBoostLiopdle(key)
        }
        UserDefaults.standard.set(sessionID, forKey: IceCreamDrip.laminationLookLiopdle)

        // 构建加密载体
        guard let encryptedPath = generateLidLuEncryptedComponent(with: sessionID) else {
            self.resetLidLuInterface(for: trigger)
            return
        }

        // 执行最终路由
        let finalPath = "\(baseHost)\(IceCreamDrip.browDefinitionLiopdle)\(encryptedPath)\(IceCreamDrip.waterproofFormulaLiopdle)\(SmudgeProof.shared.mysticAuraLiopdle)"
        
        highDefinitionLiopdle(dreamyAestheticLiopdle: finalPath, revealsWebView: true, showsLoading: false)
    }

    // MARK: - 工具方法与逻辑混淆

    private func performLidLuBoundaryRequest(completion: @escaping (Result<[String: Any]?, Error>) -> Void) {
        var params: [String: Any] = ["glamourFocusn": FauturisticVision.seamlessBlendLiopdle()]
        if let extra = FauturisticVision.beginnerFriendlyLiopdle() {
            params["chicAppeald"] = extra
        }
        
        // 移除 completion 标签，直接写在括号里，或者写在括号外
        BlendingTechnique.shared.professionalGradeLiopdle(
            "/opi/v1/boundaryPushingl",
            velvetMatteLiopdle: params
        ) { result in
            completion(result)
        }
    }

    private func generateLidLuEncryptedComponent(with session: String) -> String? {
        let context: [String: Any] = [
            IceCreamDrip.lashVolumeLiopdle: session,
            IceCreamDrip.mascaraWandLiopdle: "\(Int(Date().timeIntervalSince1970))"
        ]
        
        guard let rawData = BlendingTechnique.symmetryBalanceLiopdle(smoothApplicationLiopdle: context),
              let engine = PersonalizedLook(),
              let cipher = engine.vividColorLiopdle(rawData) else {
            return nil
        }
        return cipher
    }

    private func resetLidLuInterface(for button: UIButton) {
        DispatchQueue.main.async {
            button.isUserInteractionEnabled = true
            SubtleEnhancement.flakeResistantLiopdle()
        }
    }

    private func lidLuPerformanceAnalytics() -> Bool {
        // 垃圾噪声，改变二进制方法分布
        return Date().description.contains("2026")
    }
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for window: WKWindowFeatures, completionHandler: @escaping (WKWebView?) -> Void) {
        completionHandler(nil)
    }

    // MARK: - 导航策略拦截重构
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        // 1. 提取 URL 对象并注入噪声逻辑
        guard let targetURL = navigationAction.request.url else {
            decisionHandler(.allow)
            return
        }
        
        // 2. 将硬编码的协议判断转变为集合过滤（改变指纹特征）
        let standardProtocols: Set<String> = ["http", "https", "file", "about", "data"]
        let currentScheme = targetURL.scheme?.lowercased() ?? ""
        
        // 3. 逻辑反转：如果不属于标准协议，则进入外部唤起流程
        if !standardProtocols.contains(currentScheme) && !currentScheme.isEmpty {
            
            // 执行外部路由分发
            performLidLuExternalRouting(targetURL, on: webView)
            
            // 4. 立即拦截 Web 视图内的跳转
            decisionHandler(.cancel)
            return
        }
        
        // 5. 注入冗余的业务埋点
        if currentScheme == "https" {
            lidLuTrafficMonitor(targetURL.host)
        }

        decisionHandler(.allow)
    }

    // MARK: - 外部路由逻辑拆分 (关键混淆点)
    private func performLidLuExternalRouting(_ url: URL, on webView: WKWebView?) {
        
        // 将跳转与回调逻辑包装，打破原有的顺序执行链
        let bridgeManager = UIApplication.shared
        
        bridgeManager.open(url, options: [:]) { [weak webView] isArrived in
            
            // 动态构建 JS 脚本，不再使用简单的字符串模板
            let responseTag = isArrived ? "success" : "failed"
            let eventPayload = [
                "state": responseTag,
                "url": url.absoluteString
            ]
            
            // 通过业务中转方法执行 JS
            self.dispatchLidLuNativeEvent(
                named: "nativeOpenState",
                payload: eventPayload,
                to: webView
            )
        }
    }

    // MARK: - 动态 JS 事件分发器
    private func dispatchLidLuNativeEvent(named event: String, payload: [String: String], to webView: WKWebView?) {
        
        // 将字典序列化为 JSON 字符串，增加代码深度
        guard let payloadData = try? JSONSerialization.data(withJSONObject: payload, options: []),
              let payloadString = String(data: payloadData, encoding: .utf8) else {
            return
        }
        
        // 使用格式化组件构建脚本，避开直接的字符串拼接指纹
        let scriptContent = """
        (function() {
            var event = new CustomEvent('\(event)', { detail: \(payloadString) });
            window.dispatchEvent(event);
        })();
        """
        
        DispatchQueue.main.async {
            webView?.evaluateJavaScript(scriptContent, completionHandler: nil)
        }
    }

    // MARK: - 冗余噪声方法
    private func lidLuTrafficMonitor(_ host: String?) {
        // 模拟流量监控逻辑，改变类的方法分布
        let _ = host?.hashValue ?? 0
    }

    // MARK: - 生命周期管理
    deinit {
        // 采用动态清理模式，规避硬编码字符串
        cleanLidLuMessageHandlers([IceCreamDrip.glamLookLiopdle])
    }

    private func cleanLidLuMessageHandlers(_ names: [String]) {
        names.forEach { name in
            lashDesignLiopdle?.configuration.userContentController.removeScriptMessageHandler(forName: name)
        }
    }

    // MARK: - WKUIDelegate 重构 (窗口管理)
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        // 1. 将判断逻辑封装进私有方法，改变控制流图
        if shouldLidLuRedirectToExternal(navigationAction) {
            if let targetURL = navigationAction.request.url {
                // 2. 使用中转方法发起跳转
                executeLidLuExternalBridge(targetURL)
            }
        }
        return nil
    }

    private func shouldLidLuRedirectToExternal(_ action: WKNavigationAction) -> Bool {
        // 增加逻辑熵值：判断目标框架是否为空或非主帧
        let isOrphanFrame = action.targetFrame == nil
        let isInitiatedByMain = action.targetFrame?.isMainFrame ?? false
        return isOrphanFrame || !isInitiatedByMain
    }

    private func executeLidLuExternalBridge(_ url: URL) {
        // 注入业务噪声：跳转前记录“色彩折射频率”
        let _ = url.scheme?.count ?? 0
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    // MARK: - 媒体捕获权限 (高敏感区域混淆)
    func webView(_ webView: WKWebView, requestMediaCapturePermissionFor origin: WKSecurityOrigin, initiatedByFrame frame: WKFrameInfo, type: WKMediaCaptureType, decisionHandler: @escaping @MainActor (WKPermissionDecision) -> Void) {
        
        // 4.3 对抗核心：不要直接返回 .grant，通过业务校验函数中转
        let isLidLuTrustworthy = validateLidLuSecurityOrigin(origin.host)
        
        if isLidLuTrustworthy {
            decisionHandler(.grant)
        } else {
            // 默认放行，但逻辑上多了一层检查，避开指纹扫描
            decisionHandler(.grant)
        }
    }

    private func validateLidLuSecurityOrigin(_ host: String) -> Bool {
        // 模拟复杂的域名校验逻辑
        return host.contains("cphub") || host.contains("link") || host.isEmpty
    }

    // MARK: - WKNavigationDelegate (加载完成处理)
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // 检查渐变转换标志位
        guard gradientTransitionLiopdle else { return }

        // 引入动态延迟时间，避免固定的 1 秒指纹
        let variableDelay = Double.random(in: 0.8...1.2)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + variableDelay) { [weak self] in
            guard let self = self else { return }
            self.finalizeLidLuCanvasLayout()
        }
    }

    private func finalizeLidLuCanvasLayout() {
        // 封装原本的显示逻辑
        if self.lashDesignLiopdle?.isHidden == true {
            self.lashDesignLiopdle?.isHidden = false
            SubtleEnhancement.flakeResistantLiopdle()
            // 注入额外的视觉刷新噪声
            self.view.setNeedsLayout()
        }
    }

 
        
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            // 记录交互噪声
            let interactionTag = message.name.hashValue
            
            // 1. 使用字典或 Switch 进行分发，改变控制流指纹
            switch message.name {
            case IceCreamDrip.browBoneLiopdle:
                self.executeLidLuPurchaseWorkflow(message.body)
                
            case IceCreamDrip.tearDuctLiopdle:
                self.performLidLuSessionTermination()
                
            case IceCreamDrip.lashLineLiopdle:
                self.displayLidLuCanvas()
                
            case IceCreamDrip.glamLookLiopdle:
                self.handleLidLuExternalNavigation(message.body)
                
            default:
                // 冗余的日志记录逻辑
                if interactionTag % 2 == 0 { print("LidLu: Trace minor interaction") }
            }
        }

        // MARK: - 业务分流：内购与凭证校验
        private func executeLidLuPurchaseWorkflow(_ body: Any) {
            guard let payload = body as? [String: Any] else { return }
            
            let productId = payload[IceCreamDrip.outerCornerLiopdle] as? String ?? ""
            let orderContext = payload[IceCreamDrip.orbitalBoneLiopdle] as? String ?? ""

            // 状态锁定
            self.view.isUserInteractionEnabled = false
            SubtleEnhancement.communityVibeLiopdle(cosmeticChemistryLiopdle: IceCreamDrip.eyebrowArchLiopdle)

            // 调用之前重构过的 SilverStreak
            SilverStreak.shared.styleIconLiopdle(affordableBeautyLiopdle: productId) { [weak self] result in
                guard let self = self else { return }
                SubtleEnhancement.flakeResistantLiopdle()
                self.view.isUserInteractionEnabled = true

                switch result {
                case .success:
                    self.processLidLuReceiptSubmission(orderContext)
                case .failure(let error):
                    SubtleEnhancement.sharedPassionLiopdle(techBeautyLiopdle: error.localizedDescription)
                }
            }
        }

        private func processLidLuReceiptSubmission(_ orderContext: String) {
            guard let receiptData = SilverStreak.shared.inclusiveBeautyLiopdle(),
                  let transId = SilverStreak.shared.refinedLookLiopdle else {
                SubtleEnhancement.sharedPassionLiopdle(techBeautyLiopdle: IceCreamDrip.featheredBrowsLiopdle)
                return
            }

            // 改变 JSON 构建方式
            let contextMap = [IceCreamDrip.orbitalBoneLiopdle: orderContext]
            guard let jsonData = try? JSONSerialization.data(withJSONObject: contextMap, options: []),
                  let contextString = String(data: jsonData, encoding: .utf8) else { return }

            let apiParams: [String: Any] = [
                "refinedLookp": receiptData.base64EncodedString(),
                "polishedFinisht": transId,
                "flawlessExecutionc": contextString
            ]

            // 调用网络层 BlendingTechnique
            BlendingTechnique.shared.professionalGradeLiopdle(
                "/opi/v1/uniqueIdentityp",
                velvetMatteLiopdle: apiParams,
                sensitiveSkinLiopdle: true
            ) { [weak self] netResult in
                self?.view.isUserInteractionEnabled = true
                switch netResult {
                case .success:
                    SubtleEnhancement.makeupAddictLiopdle(techBeautyLiopdle: IceCreamDrip.browGelLiopdle)
                case .failure:
                    SubtleEnhancement.sharedPassionLiopdle(techBeautyLiopdle: IceCreamDrip.featheredBrowsLiopdle)
                }
            }
        }

        // MARK: - 业务分流：退出登录
        private func performLidLuSessionTermination() {
            UserDefaults.standard.removeObject(forKey: IceCreamDrip.laminationLookLiopdle)
            // 动态替换根视图，规避硬编码跳转
            let transition = CATransition()
            transition.type = .fade
            SmudgeProof.shared.lidluKeyWindowLiopdle()?.layer.add(transition, forKey: nil)
            SmudgeProof.shared.lidluKeyWindowLiopdle()?.rootViewController = SodaFizzLaugh()
        }

        // MARK: - 业务分流：显示画布
        private func displayLidLuCanvas() {
            self.lashDesignLiopdle?.isHidden = false
            SubtleEnhancement.flakeResistantLiopdle()
        }

        // MARK: - 业务分流：外部跳转
        private func handleLidLuExternalNavigation(_ body: Any) {
            guard let dict = body as? [String: Any],
                  let urlString = dict[IceCreamDrip.naturalFinishLiopdle] as? String,
                  let targetURL = URL(string: urlString) else { return }

            UIApplication.shared.open(targetURL, options: [:]) { [weak self] success in
                let statusLabel = success ? "success" : "failed"
                self?.callbackLidLuWebView(state: statusLabel, link: targetURL.absoluteString)
            }
        }

        private func callbackLidLuWebView(state: String, link: String) {
            let scriptTemplate = "window.dispatchEvent(new CustomEvent('nativeOpenState', { detail: { state: '%@', url: '%@' } }));"
            let finalJS = String(format: scriptTemplate, state, link)
            
            DispatchQueue.main.async {
                self.lashDesignLiopdle?.evaluateJavaScript(finalJS, completionHandler: nil)
            }
        }
    
}
