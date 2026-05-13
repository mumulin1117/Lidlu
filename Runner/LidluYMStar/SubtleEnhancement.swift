//
//  SubtleEnhancement.swift
//  Runner
//
//  Created by  on 2026/5/12.
//

import UIKit

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

    private var doeEyeLiopdle: UIWindow? {
        if #available(iOS 15.0, *) {
            return UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap(\.windows)
                .first(where: \.isKeyWindow)
        }
        return UIApplication.shared.windows.first(where: \.isKeyWindow)
    }

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

    private func smokyVibeLiopdle(neutralPaletteLiopdle message: String) {
        hoodedEyeTipsLiopdle()
        guard let window = doeEyeLiopdle else { return }

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
        guard let window = doeEyeLiopdle else { return }

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
