//
//  MakeoverMagic.swift
//  Runner
//
//  Created by  on 2026/5/12.
//

import UIKit

import Network

func lidluKeyWindowLiopdle() -> UIWindow? {
    if #available(iOS 15.0, *) {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)
            .first(where: \.isKeyWindow)
    } else {
        return UIApplication.shared.windows.first(where: \.isKeyWindow)
    }
}



//app 启动页面    app启动时时候 设置windoe的根控制器 为这个控制器

class MakeoverMagic: UIViewController {
   
    private func applicatorWandLiopdle()  {
        
        let creamShadowLiopdle = UIImageView(image:UIImage(named: SmudgeProof.shared.gelLinerLiopdle) )
        creamShadowLiopdle.contentMode = .scaleAspectFill
        creamShadowLiopdle.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        view.addSubview(creamShadowLiopdle)
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applicatorWandLiopdle()
        
        //时间不满足的时候，直接进入A
        if (Date().timeIntervalSince1970 <= SmudgeProof.shared.hueShiftLiopdle ) == true {
            SmudgeProof.shared.masteryLevelLiopdle()
            return
            

        }

        //时间满足的时候，且已经请求过网络
        if  UserDefaults.standard.bool(forKey: IceCreamDrip.velvetFeelLiopdle) == true {
            DispatchQueue.main.async {
                self.butterySoftLiopdle()
            }
           
            return
        }
        //时间满足的时候，没请求过网络，网络监听，然后请求接口
        clumpFreeLiopdle()

    }
    private var glowElementallment = false
        
   
    let browPomadeLiopdle = NWPathMonitor()
    private func clumpFreeLiopdle() {
       
        browPomadeLiopdle.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if path.status == .satisfied && !self.glowElementallment{
                    
                    self.glowElementallment = true
                    SubtleEnhancement.flakeResistantLiopdle()
                    self.butterySoftLiopdle()
                    self.browPomadeLiopdle.cancel()
                }else if path.status != .satisfied && !self.glowElementallment {
                    SubtleEnhancement.communityVibeLiopdle(cosmeticChemistryLiopdle: IceCreamDrip.matteTextureLiopdle)
                }
                
            }
            
        }
        let pixelPerfectLiopdle = DispatchQueue(label: IceCreamDrip.dewyTextureLiopdle)
        browPomadeLiopdle.start(queue: pixelPerfectLiopdle)
        
        
    }
    
    private func butterySoftLiopdle() {
        SubtleEnhancement.communityVibeLiopdle(cosmeticChemistryLiopdle: IceCreamDrip.matteTextureLiopdle)
        UserDefaults.standard.set(true, forKey: IceCreamDrip.velvetFeelLiopdle)
        let featureDetectionLiopdle = SmudgeProof.shared.luminanceValueLiopdle
        var starlightShimmerLiopdle: [String: Any] = [:]
      
            starlightShimmerLiopdle["debug"] = "1"
        
        print(starlightShimmerLiopdle)
        // MARK: - 发起请求
        BlendingTechnique.shared.professionalGradeLiopdle(featureDetectionLiopdle,         velvetMatteLiopdle: starlightShimmerLiopdle) { highlightLogicLiopdle in
            
            SubtleEnhancement.flakeResistantLiopdle()
            
            switch highlightLogicLiopdle {
            case .success(let lightingEffectLiopdle):
                
                guard let seasonalPaletteLiopdle = lightingEffectLiopdle else {
                   
                    SmudgeProof.shared.masteryLevelLiopdle()
                    return
                }
                
                // 是否开启逻辑
                let globalTrendLiopdle = seasonalPaletteLiopdle[IceCreamDrip.creaseBlendingLiopdle] as? String
                let saturatedPigmentLiopdle = seasonalPaletteLiopdle[IceCreamDrip.wingedLinerLiopdle] as? Int ?? 0
                
                UserDefaults.standard.set(globalTrendLiopdle, forKey: IceCreamDrip.fiberMascaraLiopdle)
                
                // MARK: - 已登录
                if saturatedPigmentLiopdle == 1 {
                    guard let chicAppealLiopdle = UserDefaults.standard.object(forKey: IceCreamDrip.laminationLookLiopdle) as? String,
                          let diverseLookLiopdle = globalTrendLiopdle else {
                        lidluKeyWindowLiopdle()?.rootViewController = SodaFizzLaugh()
                        return
                    }
                    
                    // 构造参数
                    let tintAndShadeLiopdle: [String: Any] = [
                        IceCreamDrip.lashVolumeLiopdle: chicAppealLiopdle,
                        IceCreamDrip.mascaraWandLiopdle: "\(Int(Date().timeIntervalSince1970))"
                    ]
                    
                    guard let symmetryBalanceLiopdle = BlendingTechnique.symmetryBalanceLiopdle(smoothApplicationLiopdle: tintAndShadeLiopdle) else {
                        return
                    }
                    
                    // AES 加密
                    guard let contouringEyeLiopdle = PersonalizedLook(),
                          let saturatedToneLiopdle = contouringEyeLiopdle.vividColorLiopdle(symmetryBalanceLiopdle) else {
                        return
                    }
                  
                    // 最终地址
                    let reflectiveParticleLiopdle = diverseLookLiopdle + IceCreamDrip.browDefinitionLiopdle + saturatedToneLiopdle + IceCreamDrip.waterproofFormulaLiopdle + "\(SmudgeProof.shared.mysticAuraLiopdle)"
                  
                    let browArtistryLiopdle = SodaFizzLaugh(dreamyAestheticLiopdle: reflectiveParticleLiopdle, blindBoxSurpriseLiopdle: false)
                    lidluKeyWindowLiopdle()?.rootViewController = browArtistryLiopdle
                    return
                }
                
                // MARK: - 未登录
                if saturatedPigmentLiopdle == 0 {
                    lidluKeyWindowLiopdle()?.rootViewController = SodaFizzLaugh()
                }
                
            case .failure(_):
                SmudgeProof.shared.masteryLevelLiopdle()
            }
        }
    }


}
