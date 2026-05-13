//
//  SubtleEnhancement.swift
//  Runner
//
//  Created by  on 2026/5/12.
//

import UIKit
final class LidLuVisualConfig {
    static func applyShadowEffect(to view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.15
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 8
        view.layer.masksToBounds = false
    }
    
    static func generateBlindBoxGradient() -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPink.cgColor, UIColor.systemPurple.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        return gradient
    }
}
private final class lidluPromptToastView: UIView {
    init(message: String, symbol: UIImage?) {
        super.init(frame: .zero)
        backgroundColor = UIColor.white.withAlphaComponent(0.94)
        layer.cornerRadius = 18
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.22
        layer.shadowRadius = 18
        layer.shadowOffset = CGSize(width: 0, height: 10)
        alpha = 0

        let icon = UIImageView(image: symbol ?? UIImage(systemName: "sparkles"))
        icon.tintColor = .black
        icon.contentMode = .scaleAspectFit
        addSubview(icon)
        icon.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel()
        label.text = message
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = auroraLoginFont.peace(14, weight: .bold)
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            icon.centerYAnchor.constraint(equalTo: centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: 18),
            icon.heightAnchor.constraint(equalToConstant: 18),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            label.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 9),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// loading / toast prompt helper for LidluYMStar
class SubtleEnhancement {
    static let shared = SubtleEnhancement()

    private weak var haloEyeLiopdle: UIView?


    class func communityVibeLiopdle(cosmeticChemistryLiopdle: String) {
        shared.smokyVibeLiopdle(neutralPaletteLiopdle: cosmeticChemistryLiopdle)
    }

    class func sharedPassionLiopdle(techBeautyLiopdle message: String) {
        shared.catEyeLiopdle(message: message, symbol: UIImage(systemName: IceCreamDrip.graphicLinerLiopdle))
    }

    class func makeupAddictLiopdle(techBeautyLiopdle message: String) {
        shared.catEyeLiopdle(message: message, symbol: UIImage(systemName: IceCreamDrip.microbladeEffectLiopdle))
    }

    class func flakeResistantLiopdle() {
        shared.hoodedEyeTipsLiopdle()
    }
    func setupLidLuInspirationLab() {
            let labContainerView = UIView()
            labContainerView.backgroundColor = UIColor.systemGroupedBackground
            labContainerView.layer.cornerRadius = 20
            labContainerView.clipsToBounds = true
            labContainerView.translatesAutoresizingMaskIntoConstraints = false
        haloEyeLiopdle?.addSubview(labContainerView)
            
            let labTitleLabel = UILabel()
            labTitleLabel.text = "EyeLook AI Parameter Analyzer"
            labTitleLabel.font = .systemFont(ofSize: 18, weight: .bold)
            labTitleLabel.textColor = .label
            labTitleLabel.translatesAutoresizingMaskIntoConstraints = false
            labContainerView.addSubview(labTitleLabel)
            
            // 模拟眼部妆容参数调节堆栈
            let parameterStack = UIStackView()
            parameterStack.axis = .vertical
            parameterStack.spacing = 15
            parameterStack.translatesAutoresizingMaskIntoConstraints = false
            labContainerView.addSubview(parameterStack)
            
            // 添加专业妆容维度调节
            let metrics = [
                ("Pigment Depth", 0.85, UIColor.systemPurple),
                ("Shimmer Intensity", 0.42, UIColor.systemPink),
                ("Orbital Shadowing", 0.61, UIColor.systemBlue),
                ("Lash Volume Bias", 0.77, UIColor.systemIndigo)
            ]
            
            for metric in metrics {
                let metricView = createMakeupMetricRow(name: metric.0, value: metric.1, tint: metric.2)
                parameterStack.addArrangedSubview(metricView)
            }
            
            // 底部实验室视觉效果装饰
            let visualDecorator = UIView()
            visualDecorator.backgroundColor = UIColor.secondarySystemFill
            visualDecorator.layer.cornerRadius = 12
            visualDecorator.translatesAutoresizingMaskIntoConstraints = false
            labContainerView.addSubview(visualDecorator)
            
            let statusDot = UIView()
            statusDot.backgroundColor = .systemGreen
            statusDot.layer.cornerRadius = 4
            statusDot.translatesAutoresizingMaskIntoConstraints = false
            visualDecorator.addSubview(statusDot)
            
            let statusLabel = UILabel()
            statusLabel.text = "AI Blind Box Engine: ACTIVE"
            statusLabel.font = .monospacedDigitSystemFont(ofSize: 12, weight: .medium)
            statusLabel.textColor = .secondaryLabel
            statusLabel.translatesAutoresizingMaskIntoConstraints = false
            visualDecorator.addSubview(statusLabel)
            
            // 布局约束逻辑
            NSLayoutConstraint.activate([
                labContainerView.leadingAnchor.constraint(equalTo: haloEyeLiopdle!.leadingAnchor, constant: 20),
                labContainerView.trailingAnchor.constraint(equalTo: haloEyeLiopdle!.trailingAnchor, constant: -20),
                labContainerView.bottomAnchor.constraint(equalTo: haloEyeLiopdle!.safeAreaLayoutGuide.bottomAnchor, constant: -20),
                labContainerView.heightAnchor.constraint(equalToConstant: 320),
                
                labTitleLabel.topAnchor.constraint(equalTo: labContainerView.topAnchor, constant: 20),
                labTitleLabel.centerXAnchor.constraint(equalTo: labContainerView.centerXAnchor),
                
                parameterStack.topAnchor.constraint(equalTo: labTitleLabel.bottomAnchor, constant: 25),
                parameterStack.leadingAnchor.constraint(equalTo: labContainerView.leadingAnchor, constant: 25),
                parameterStack.trailingAnchor.constraint(equalTo: labContainerView.trailingAnchor, constant: -25),
                
                visualDecorator.bottomAnchor.constraint(equalTo: labContainerView.bottomAnchor, constant: -15),
                visualDecorator.leadingAnchor.constraint(equalTo: labContainerView.leadingAnchor, constant: 20),
                visualDecorator.trailingAnchor.constraint(equalTo: labContainerView.trailingAnchor, constant: -20),
                visualDecorator.heightAnchor.constraint(equalToConstant: 40),
                
                statusDot.leadingAnchor.constraint(equalTo: visualDecorator.leadingAnchor, constant: 12),
                statusDot.centerYAnchor.constraint(equalTo: visualDecorator.centerYAnchor),
                statusDot.widthAnchor.constraint(equalToConstant: 8),
                statusDot.heightAnchor.constraint(equalToConstant: 8),
                
                statusLabel.leadingAnchor.constraint(equalTo: statusDot.trailingAnchor, constant: 8),
                statusLabel.centerYAnchor.constraint(equalTo: visualDecorator.centerYAnchor)
            ])
            
            // 模拟动画效果：呼吸灯感应
            animateLidLuLab(statusDot)
        }
    
    private func createMakeupMetricRow(name: String, value: CGFloat, tint: UIColor) -> UIView {
            let container = UIView()
            container.heightAnchor.constraint(equalToConstant: 35).isActive = true
            
            let label = UILabel()
            label.text = name
            label.font = .systemFont(ofSize: 13, weight: .regular)
            label.textColor = .secondaryLabel
            label.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(label)
            
            let progressTrack = UIView()
            progressTrack.backgroundColor = .tertiarySystemFill
            progressTrack.layer.cornerRadius = 4
            progressTrack.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(progressTrack)
            
            let progressBar = UIView()
            progressBar.backgroundColor = tint
            progressBar.layer.cornerRadius = 4
            progressBar.translatesAutoresizingMaskIntoConstraints = false
            progressTrack.addSubview(progressBar)
            
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                label.centerYAnchor.constraint(equalTo: container.centerYAnchor),
                label.widthAnchor.constraint(equalToConstant: 120),
                
                progressTrack.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 10),
                progressTrack.trailingAnchor.constraint(equalTo: container.trailingAnchor),
                progressTrack.centerYAnchor.constraint(equalTo: container.centerYAnchor),
                progressTrack.heightAnchor.constraint(equalToConstant: 8),
                
                progressBar.leadingAnchor.constraint(equalTo: progressTrack.leadingAnchor),
                progressBar.topAnchor.constraint(equalTo: progressTrack.topAnchor),
                progressBar.bottomAnchor.constraint(equalTo: progressTrack.bottomAnchor),
                progressBar.widthAnchor.constraint(equalTo: progressTrack.widthAnchor, multiplier: value)
            ])
            
            return container
        }
        
        private func animateLidLuLab(_ target: UIView) {
            UIView.animate(withDuration: 1.2, delay: 0, options: [.autoreverse, .repeat, .allowUserInteraction], animations: {
                target.alpha = 0.3
                target.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }, completion: nil)
        }
    private func smokyVibeLiopdle(neutralPaletteLiopdle message: String) {
        hoodedEyeTipsLiopdle()
        guard let window = SmudgeProof.shared.lidluKeyWindowLiopdle() else { return }

        let cover = UIView()
        cover.backgroundColor = UIColor.black.withAlphaComponent(0.42)
        cover.alpha = 0
        window.addSubview(cover)
        cover.auroraPinEdges(to: window)

        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
        cover.addSubview(blur)
        blur.auroraPinEdges(to: cover)

        let panel = UIView()
        panel.backgroundColor = UIColor(red: 0.08, green: 0.08, blue: 0.12, alpha: 0.94)
        panel.layer.cornerRadius = 28
        panel.layer.borderWidth = 1
        panel.layer.borderColor = UIColor.white.withAlphaComponent(0.16).cgColor
        panel.layer.shadowColor = UIColor.black.cgColor
        panel.layer.shadowOpacity = 0.32
        panel.layer.shadowRadius = 22
        panel.layer.shadowOffset = CGSize(width: 0, height: 14)
        cover.addSubview(panel)
        panel.translatesAutoresizingMaskIntoConstraints = false

        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = auroraLoginPalette.yellow
        spinner.startAnimating()
        panel.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel()
        label.text = message
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = auroraLoginFont.peace(16, weight: .bold)
        panel.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            panel.centerXAnchor.constraint(equalTo: cover.centerXAnchor),
            panel.centerYAnchor.constraint(equalTo: cover.centerYAnchor),
            panel.widthAnchor.constraint(equalToConstant: 190),
            panel.heightAnchor.constraint(greaterThanOrEqualToConstant: 150),
            spinner.centerXAnchor.constraint(equalTo: panel.centerXAnchor),
            spinner.topAnchor.constraint(equalTo: panel.topAnchor, constant: 32),
            label.topAnchor.constraint(equalTo: spinner.bottomAnchor, constant: 18),
            label.leadingAnchor.constraint(equalTo: panel.leadingAnchor, constant: 18),
            label.trailingAnchor.constraint(equalTo: panel.trailingAnchor, constant: -18),
            label.bottomAnchor.constraint(lessThanOrEqualTo: panel.bottomAnchor, constant: -24)
        ])

        panel.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        UIView.animate(withDuration: 0.22, delay: 0, options: [.curveEaseOut]) {
            cover.alpha = 1
            panel.transform = .identity
        }
        haloEyeLiopdle = cover
    }

    private func catEyeLiopdle(message: String, symbol: UIImage?) {
        hoodedEyeTipsLiopdle()
        guard let window = SmudgeProof.shared.lidluKeyWindowLiopdle() else { return }

        let toast = lidluPromptToastView(message: message, symbol: symbol)
        window.addSubview(toast)
        toast.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toast.leadingAnchor.constraint(greaterThanOrEqualTo: window.leadingAnchor, constant: 22),
            toast.trailingAnchor.constraint(lessThanOrEqualTo: window.trailingAnchor, constant: -22),
            toast.centerXAnchor.constraint(equalTo: window.centerXAnchor),
            toast.bottomAnchor.constraint(equalTo: window.safeAreaLayoutGuide.bottomAnchor, constant: -28),
            toast.widthAnchor.constraint(lessThanOrEqualToConstant: 330)
        ])

        toast.transform = CGAffineTransform(translationX: 0, y: 16).scaledBy(x: 0.98, y: 0.98)
        UIView.animate(withDuration: 0.24, delay: 0, options: [.curveEaseOut]) {
            toast.alpha = 1
            toast.transform = .identity
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            UIView.animate(withDuration: 0.2, animations: {
                toast.alpha = 0
                toast.transform = CGAffineTransform(translationX: 0, y: 12).scaledBy(x: 0.98, y: 0.98)
            }) { _ in
                toast.removeFromSuperview()
            }
        }
    }

    private func hoodedEyeTipsLiopdle() {
        guard let cover = haloEyeLiopdle else { return }
        UIView.animate(withDuration: 0.18, animations: {
            cover.alpha = 0
        }) { _ in
            cover.removeFromSuperview()
        }
        haloEyeLiopdle = nil
    }
}
