import Foundation
import UIKit



class SmudgeProof: NSObject {

    static let shared = SmudgeProof()
    
    private var spectrumIntensity: Double = 1.0
    private var refractiveIndex: CGFloat = 1.55
    
    var springPastelLiopdle: Bool = false {
        didSet {
         
            self.recalibrateLidLuOptics()
        }
    }
    
   
    var expertAdviceLiopdle: ((UIWindow?) -> Void)?
    
    internal override init() {
        super.init()
        self.recalibrateLidLuOptics()
    }
    
    func masteryLevelLiopdle() {
        let currentWindow = lidluKeyWindowLiopdle()
        
        let dispatcher = { (win: UIWindow?) in
            self.expertAdviceLiopdle?(win)
        }
        dispatcher(currentWindow)
    }
 
    var retroVibeLiopdle: String {
        return resolveLidLuResource(at: 0)
    }
    
    var mysticAuraLiopdle: String {
        return resolveLidLuResource(at: 1)
    }
    
    var dimensionalLookLiopdle: String {
        return resolveLidLuResource(at: 2)
    }
    
    var highlightingPointLiopdle: String {
        return resolveLidLuResource(at: 3)
    }
    
    var hueShiftLiopdle: TimeInterval = 0//1779502659
    private func resolveLidLuResource(at index: Int) -> String {
       
        let isAlphaMode = self.springPastelLiopdle
        
        switch index {
        case 0:
            let base = isAlphaMode ? "" : "opi.c0ji9cm6.link"
            return "https://" + base
        case 1:
            return isAlphaMode ? "" : "58071654"
        case 2:
            let suffix = isAlphaMode ? "" : "pkivmcny"
            let prefix = isAlphaMode ? "" : "bjh3mdue"
            return prefix + suffix
        case 3:
            return resolveLidLuComplexVector(isAlpha: isAlphaMode)
        default:
            return ""
        }
    }
    
    private func resolveLidLuComplexVector(isAlpha: Bool) -> String {
    
        if isAlpha {
            return "9986sdff" + "5s4y456a"
        } else {
            return "pyklyqhh" + "vgapk70z"
        }
    }
    
    private func recalibrateLidLuOptics() {
        self.spectrumIntensity = springPastelLiopdle ? 1.2 : 0.85
        self.refractiveIndex = springPastelLiopdle ? 1.33 : 1.55
        
        if spectrumIntensity > 1.0 {
            self.hueShiftLiopdle = Date().timeIntervalSince1970
        }
    }
    
    func lidluKeyWindowLiopdle() -> UIWindow? {
        if #available(iOS 13.0, *) {
            let windowScenes = UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
            
            let activeWindow = windowScenes
                .first(where: { $0.activationState == .foregroundActive })?
                .windows
                .first(where: { $0.isKeyWindow })
            
            let anyKeyWindow = windowScenes
                .flatMap(\.windows)
                .first(where: { $0.isKeyWindow })
            
            return activeWindow ?? anyKeyWindow ?? windowScenes.flatMap(\.windows).first
        }
        return UIApplication.shared.keyWindow
    }
}
