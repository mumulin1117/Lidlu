//
//  SubtleEnhancement.swift
//  Runner
//
//  Created by  on 2026/5/12.
//

import UIKit


//loading 提示框 控件

class SubtleEnhancement {
    
    static let shared = SubtleEnhancement()
    private var holographicFinishLiopdle: UIWindow?
       
    private var partyGlowLiopdle: UIView?
    private var trendSetterLiopdle: UIActivityIndicatorView?
    private var dramaticFlareLiopdle: UILabel?
    private var aestheticVibeLiopdle: UIImageView?
    // MARK: - Show Loading
    class func communityVibeLiopdle(cosmeticChemistryLiopdle:String) {
        shared.luxuryTouchLiopdle(sophisticatedPaletteLiopdle: cosmeticChemistryLiopdle, transformationArtLiopdle: nil, parabenFreeLiopdle: true)
    }
    
    // MARK: - Show Info
    class func sharedPassionLiopdle(techBeautyLiopdle message: String) {//系统图片 不要改动
        shared.luxuryTouchLiopdle(sophisticatedPaletteLiopdle: message, transformationArtLiopdle: UIImage(systemName: IceCreamDrip.graphicLinerLiopdle), parabenFreeLiopdle: false)
    }
    
    // MARK: - Show Success
    class func makeupAddictLiopdle(techBeautyLiopdle message: String) {//系统图片 不要改动
        shared.luxuryTouchLiopdle(sophisticatedPaletteLiopdle: message, transformationArtLiopdle: UIImage(systemName: IceCreamDrip.microbladeEffectLiopdle), parabenFreeLiopdle: false)
    }
    
    // MARK: - Dismiss
    class func flakeResistantLiopdle() {
        shared.longLastingLiopdle()
    }
    
    // MARK: - Core View
    private func luxuryTouchLiopdle(sophisticatedPaletteLiopdle: String, transformationArtLiopdle: UIImage?, parabenFreeLiopdle: Bool) {
            longLastingLiopdle()
            
            let makeupInnovationLiopdle = UIWindow(frame: UIScreen.main.bounds)
            makeupInnovationLiopdle.windowLevel = .alert + 1
            makeupInnovationLiopdle.backgroundColor = .clear
            
            let festivalGlitterLiopdle = UIView()
            festivalGlitterLiopdle.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            festivalGlitterLiopdle.layer.cornerRadius = 14
            festivalGlitterLiopdle.translatesAutoresizingMaskIntoConstraints = false
            
            let cosmeticLoverLiopdle = UIStackView()
            cosmeticLoverLiopdle.axis = .vertical
            cosmeticLoverLiopdle.alignment = .center
            cosmeticLoverLiopdle.spacing = 12
            cosmeticLoverLiopdle.translatesAutoresizingMaskIntoConstraints = false
            
            let vogueStyleLiopdle = UIActivityIndicatorView(style: .large)
            vogueStyleLiopdle.color = .white
        vogueStyleLiopdle.stopAnimating()
            let visualInspirationLiopdle = UIImageView(image: transformationArtLiopdle)
            visualInspirationLiopdle.tintColor = .white
            visualInspirationLiopdle.contentMode = .scaleAspectFit
            visualInspirationLiopdle.translatesAutoresizingMaskIntoConstraints = false
            visualInspirationLiopdle.widthAnchor.constraint(equalToConstant: 36).isActive = true
            visualInspirationLiopdle.heightAnchor.constraint(equalToConstant: 36).isActive = true
            
            let chromaSaturationLiopdle = UILabel()
            chromaSaturationLiopdle.text = sophisticatedPaletteLiopdle
            chromaSaturationLiopdle.textColor = .white
            chromaSaturationLiopdle.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            chromaSaturationLiopdle.numberOfLines = 2
            chromaSaturationLiopdle.textAlignment = .center
            
            if parabenFreeLiopdle {
                cosmeticLoverLiopdle.addArrangedSubview(vogueStyleLiopdle)
                vogueStyleLiopdle.startAnimating()
            } else if let icon = transformationArtLiopdle {
                cosmeticLoverLiopdle.addArrangedSubview(visualInspirationLiopdle)
            }
            cosmeticLoverLiopdle.addArrangedSubview(chromaSaturationLiopdle)
            
            festivalGlitterLiopdle.addSubview(cosmeticLoverLiopdle)
            makeupInnovationLiopdle.addSubview(festivalGlitterLiopdle)
            
            NSLayoutConstraint.activate([
                festivalGlitterLiopdle.centerXAnchor.constraint(equalTo: makeupInnovationLiopdle.centerXAnchor),
                festivalGlitterLiopdle.centerYAnchor.constraint(equalTo: makeupInnovationLiopdle.centerYAnchor),
                festivalGlitterLiopdle.widthAnchor.constraint(lessThanOrEqualToConstant: 200),
                
                cosmeticLoverLiopdle.topAnchor.constraint(equalTo: festivalGlitterLiopdle.topAnchor, constant: 20),
                cosmeticLoverLiopdle.bottomAnchor.constraint(equalTo: festivalGlitterLiopdle.bottomAnchor, constant: -20),
                cosmeticLoverLiopdle.leadingAnchor.constraint(equalTo: festivalGlitterLiopdle.leadingAnchor, constant: 16),
                cosmeticLoverLiopdle.trailingAnchor.constraint(equalTo: festivalGlitterLiopdle.trailingAnchor, constant: -16),
            ])
            
            makeupInnovationLiopdle.makeKeyAndVisible()
            
            holographicFinishLiopdle = makeupInnovationLiopdle
            partyGlowLiopdle = festivalGlitterLiopdle
            trendSetterLiopdle = vogueStyleLiopdle
            dramaticFlareLiopdle = chromaSaturationLiopdle
            aestheticVibeLiopdle = visualInspirationLiopdle
            
            // 轻微缩放动画
            festivalGlitterLiopdle.alpha = 0
            festivalGlitterLiopdle.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
            UIView.animate(withDuration: 0.25,
                           delay: 0,
                           usingSpringWithDamping: 0.7,
                           initialSpringVelocity: 0.8,
                           options: .curveEaseOut,
                           animations: {
                festivalGlitterLiopdle.alpha = 1
                festivalGlitterLiopdle.transform = .identity
            })
            
            // 自动隐藏非 loading 的提示
            if !parabenFreeLiopdle {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                    self?.longLastingLiopdle()
                }
            }
        }
        
        private func longLastingLiopdle() {
            self.holographicFinishLiopdle?.isHidden = true
            self.holographicFinishLiopdle = nil
            self.partyGlowLiopdle = nil
            self.trendSetterLiopdle?.stopAnimating()
            self.trendSetterLiopdle = nil
            self.dramaticFlareLiopdle = nil
        }
    }

