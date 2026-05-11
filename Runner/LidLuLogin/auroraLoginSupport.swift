import UIKit

enum auroraLoginPalette {
    static let yellow = UIColor(red: 1.0, green: 0.937, blue: 0.286, alpha: 1.0)
    static let softWhite = UIColor(white: 1.0, alpha: 0.42)
    static let consentGray = UIColor(red: 0.847, green: 0.847, blue: 0.847, alpha: 1.0)
    static let lime = UIColor(red: 0.584, green: 0.937, blue: 0.012, alpha: 1.0)
}

enum auroraLoginAsset {
    static func image(_ name: String) -> UIImage? {
        if name.contains("/"), let image = UIImage(contentsOfFile: name) {
            return image
        }
        for path in candidatePaths(for: name) {
            if let image = UIImage(contentsOfFile: path) {
                return image
            }
        }
        return UIImage(named: name)
    }

    private static func candidatePaths(for name: String) -> [String] {
        var paths = [shimmerHavenBundle.localPath(for: name)]
        if let resourcePath = Bundle.main.resourcePath {
            paths.append("\(resourcePath)/LidLuImages/\(name)")
            paths.append("\(resourcePath)/LidLuFonts/\(name)")
        }
        if let path = Bundle.main.path(forResource: name, ofType: nil) {
            paths.append(path)
        }
        return paths
    }
}

enum auroraLoginBackground {
    static func apply(_ name: String, to view: UIView) {
        let imageView = UIImageView(image: auroraLoginAsset.image(name))
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        imageView.auroraPinEdges(to: view)
    }
}

enum auroraLoginFont {
    static func peace(_ size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        UIFont(name: "Peaceblad", size: size)
            ?? UIFont(name: "Peace", size: size)
            ?? .systemFont(ofSize: size, weight: weight)
    }
}

extension UIView {
    func auroraPinEdges(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

final class auroraToastView: UIView {
    private let label = UILabel()

    init(message: String) {
        super.init(frame: .zero)
        backgroundColor = UIColor.white.withAlphaComponent(0.94)
        layer.cornerRadius = 18
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.22
        layer.shadowRadius = 18
        layer.shadowOffset = CGSize(width: 0, height: 10)
        alpha = 0

        let symbol = UIImageView(image: UIImage(systemName: "sparkles"))
        symbol.tintColor = .black
        symbol.contentMode = .scaleAspectFit
        addSubview(symbol)
        symbol.translatesAutoresizingMaskIntoConstraints = false

        label.text = message
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = auroraLoginFont.peace(14, weight: .bold)
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            symbol.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            symbol.centerYAnchor.constraint(equalTo: centerYAnchor),
            symbol.widthAnchor.constraint(equalToConstant: 18),
            symbol.heightAnchor.constraint(equalToConstant: 18),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            label.leadingAnchor.constraint(equalTo: symbol.trailingAnchor, constant: 9),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private final class auroraChoiceButton: UIButton {
    var tapAction: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self, action: #selector(runTapAction), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func runTapAction() {
        tapAction?()
    }
}

extension UIViewController {
    func auroraShowToast(_ message: String) {
        let toast = auroraToastView(message: message)
        view.addSubview(toast)
        toast.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toast.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 22),
            toast.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -22),
            toast.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toast.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -28),
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

    @discardableResult
    func auroraShowLoading(_ message: String = pearlGazeText.visible.loading) -> UIView {
        let cover = UIView()
        cover.backgroundColor = UIColor.black.withAlphaComponent(0.42)
        cover.alpha = 0
        view.addSubview(cover)
        cover.auroraPinEdges(to: view)

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
        return cover
    }

    func auroraHideLoading(_ cover: UIView?, completion: (() -> Void)? = nil) {
        guard let cover else {
            completion?()
            return
        }
        UIView.animate(withDuration: 0.18, animations: {
            cover.alpha = 0
        }) { _ in
            cover.removeFromSuperview()
            completion?()
        }
    }

    func auroraShowLoadingThenFinish(_ completion: @escaping () -> Void) {
        let cover = auroraShowLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.auroraHideLoading(cover, completion: completion)
        }
    }

    func auroraShowChoice(
        title: String,
        message: String,
        cancelTitle: String,
        confirmTitle: String,
        destructive: Bool = false,
        cancelAction: (() -> Void)? = nil,
        confirmAction: @escaping () -> Void
    ) {
        let overlay = UIView()
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.54)
        overlay.alpha = 0
        view.addSubview(overlay)
        overlay.auroraPinEdges(to: view)

        let card = UIView()
        card.backgroundColor = UIColor.white
        card.layer.cornerRadius = 28
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOpacity = 0.3
        card.layer.shadowRadius = 24
        card.layer.shadowOffset = CGSize(width: 0, height: 14)
        overlay.addSubview(card)
        card.translatesAutoresizingMaskIntoConstraints = false

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        titleLabel.font = auroraLoginFont.peace(22, weight: .bold)
        card.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.textAlignment = .center
        messageLabel.textColor = UIColor.black.withAlphaComponent(0.82)
        messageLabel.numberOfLines = 0
        messageLabel.font = auroraLoginFont.peace(14, weight: .bold)
        card.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false

        let cancel = auroraChoiceButton(type: .system)
        cancel.setTitle(cancelTitle, for: .normal)
        cancel.setTitleColor(UIColor(red: 1.0, green: 0.23, blue: 0.54, alpha: 1.0), for: .normal)
        cancel.titleLabel?.font = auroraLoginFont.peace(14, weight: .bold)
        cancel.backgroundColor = .white
        cancel.layer.cornerRadius = 20
        cancel.layer.borderWidth = 1
        cancel.layer.borderColor = UIColor(red: 1.0, green: 0.23, blue: 0.54, alpha: 0.76).cgColor
        card.addSubview(cancel)
        cancel.translatesAutoresizingMaskIntoConstraints = false

        let confirm = auroraChoiceButton(type: .system)
        confirm.setTitle(confirmTitle, for: .normal)
        confirm.setTitleColor(destructive ? .white : .black, for: .normal)
        confirm.titleLabel?.font = auroraLoginFont.peace(14, weight: .bold)
        confirm.backgroundColor = destructive ? UIColor(red: 1.0, green: 0.12, blue: 0.16, alpha: 1.0) : auroraLoginPalette.yellow
        confirm.layer.cornerRadius = 20
        card.addSubview(confirm)
        confirm.translatesAutoresizingMaskIntoConstraints = false

        let dismiss: () -> Void = { [weak overlay, weak card] in
            guard let overlay, let card else {
                return
            }
            UIView.animate(withDuration: 0.18, animations: {
                overlay.alpha = 0
                card.transform = CGAffineTransform(scaleX: 0.96, y: 0.96)
            }) { _ in
                overlay.removeFromSuperview()
            }
        }
        cancel.tapAction = {
            dismiss()
            cancelAction?()
        }
        confirm.tapAction = {
            confirmAction()
            dismiss()
        }

        NSLayoutConstraint.activate([
            card.centerXAnchor.constraint(equalTo: overlay.centerXAnchor),
            card.centerYAnchor.constraint(equalTo: overlay.centerYAnchor),
            card.leadingAnchor.constraint(greaterThanOrEqualTo: overlay.leadingAnchor, constant: 34),
            card.trailingAnchor.constraint(lessThanOrEqualTo: overlay.trailingAnchor, constant: -34),
            card.widthAnchor.constraint(lessThanOrEqualToConstant: 320),
            titleLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -24),
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            messageLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 26),
            messageLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -26),
            cancel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 26),
            cancel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 20),
            cancel.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -22),
            cancel.heightAnchor.constraint(equalToConstant: 40),
            confirm.leadingAnchor.constraint(equalTo: cancel.trailingAnchor, constant: 12),
            confirm.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -20),
            confirm.centerYAnchor.constraint(equalTo: cancel.centerYAnchor),
            confirm.widthAnchor.constraint(equalTo: cancel.widthAnchor),
            confirm.heightAnchor.constraint(equalTo: cancel.heightAnchor)
        ])

        card.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        UIView.animate(withDuration: 0.24, delay: 0, options: [.curveEaseOut]) {
            overlay.alpha = 1
            card.transform = .identity
        }
    }
}
