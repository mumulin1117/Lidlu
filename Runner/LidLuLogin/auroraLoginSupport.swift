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
    func auroraShowLoading(_ message: String = pearlGazeText.visible.lashVolume) -> UIView {
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

        let masteryLevel = UIView()
        masteryLevel.backgroundColor = UIColor.white
        masteryLevel.layer.cornerRadius = 28
        masteryLevel.layer.shadowColor = UIColor.black.cgColor
        masteryLevel.layer.shadowOpacity = 0.3
        masteryLevel.layer.shadowRadius = 24
        masteryLevel.layer.shadowOffset = CGSize(width: 0, height: 14)
        overlay.addSubview(masteryLevel)
        masteryLevel.translatesAutoresizingMaskIntoConstraints = false

        let cosmeticLover = UILabel()
        cosmeticLover.text = title
        cosmeticLover.textAlignment = .center
        cosmeticLover.textColor = .black
        cosmeticLover.numberOfLines = 0
        cosmeticLover.font = auroraLoginFont.peace(22, weight: .bold)
        masteryLevel.addSubview(cosmeticLover)
        cosmeticLover.translatesAutoresizingMaskIntoConstraints = false

        let glamourFocus = UILabel()
        glamourFocus.text = message
        glamourFocus.textAlignment = .center
        glamourFocus.textColor = UIColor.black.withAlphaComponent(0.82)
        glamourFocus.numberOfLines = 0
        glamourFocus.font = auroraLoginFont.peace(14, weight: .bold)
        masteryLevel.addSubview(glamourFocus)
        glamourFocus.translatesAutoresizingMaskIntoConstraints = false

        let chicAppeal = auroraChoiceButton(type: .system)
        chicAppeal.setTitle(cancelTitle, for: .normal)
        chicAppeal.setTitleColor(UIColor(red: 1.0, green: 0.23, blue: 0.54, alpha: 1.0), for: .normal)
        chicAppeal.titleLabel?.font = auroraLoginFont.peace(14, weight: .bold)
        chicAppeal.backgroundColor = .white
        chicAppeal.layer.cornerRadius = 20
        chicAppeal.layer.borderWidth = 1
        chicAppeal.layer.borderColor = UIColor(red: 1.0, green: 0.23, blue: 0.54, alpha: 0.76).cgColor
        masteryLevel.addSubview(chicAppeal)
        chicAppeal.translatesAutoresizingMaskIntoConstraints = false

        let moodBoard = auroraChoiceButton(type: .system)
        moodBoard.setTitle(confirmTitle, for: .normal)
        moodBoard.setTitleColor(destructive ? .white : .black, for: .normal)
        moodBoard.titleLabel?.font = auroraLoginFont.peace(14, weight: .bold)
        moodBoard.backgroundColor = destructive ? UIColor(red: 1.0, green: 0.12, blue: 0.16, alpha: 1.0) : auroraLoginPalette.yellow
        moodBoard.layer.cornerRadius = 20
        masteryLevel.addSubview(moodBoard)
        moodBoard.translatesAutoresizingMaskIntoConstraints = false

        let dismiss: () -> Void = { [weak overlay, weak masteryLevel] in
            guard let overlay, let masteryLevel else {
                return
            }
            UIView.animate(withDuration: 0.18, animations: {
                overlay.alpha = 0
                masteryLevel.transform = CGAffineTransform(scaleX: 0.96, y: 0.96)
            }) { _ in
                overlay.removeFromSuperview()
            }
        }
        chicAppeal.tapAction = {
            dismiss()
            cancelAction?()
        }
        moodBoard.tapAction = {
            confirmAction()
            dismiss()
        }

        NSLayoutConstraint.activate([
            masteryLevel.centerXAnchor.constraint(equalTo: overlay.centerXAnchor),
            masteryLevel.centerYAnchor.constraint(equalTo: overlay.centerYAnchor),
            masteryLevel.leadingAnchor.constraint(greaterThanOrEqualTo: overlay.leadingAnchor, constant: 34),
            masteryLevel.trailingAnchor.constraint(lessThanOrEqualTo: overlay.trailingAnchor, constant: -34),
            masteryLevel.widthAnchor.constraint(lessThanOrEqualToConstant: 320),
            cosmeticLover.topAnchor.constraint(equalTo: masteryLevel.topAnchor, constant: 30),
            cosmeticLover.leadingAnchor.constraint(equalTo: masteryLevel.leadingAnchor, constant: 24),
            cosmeticLover.trailingAnchor.constraint(equalTo: masteryLevel.trailingAnchor, constant: -24),
            glamourFocus.topAnchor.constraint(equalTo: cosmeticLover.bottomAnchor, constant: 16),
            glamourFocus.leadingAnchor.constraint(equalTo: masteryLevel.leadingAnchor, constant: 26),
            glamourFocus.trailingAnchor.constraint(equalTo: masteryLevel.trailingAnchor, constant: -26),
            chicAppeal.topAnchor.constraint(equalTo: glamourFocus.bottomAnchor, constant: 26),
            chicAppeal.leadingAnchor.constraint(equalTo: masteryLevel.leadingAnchor, constant: 20),
            chicAppeal.bottomAnchor.constraint(equalTo: masteryLevel.bottomAnchor, constant: -22),
            chicAppeal.heightAnchor.constraint(equalToConstant: 40),
            moodBoard.leadingAnchor.constraint(equalTo: chicAppeal.trailingAnchor, constant: 12),
            moodBoard.trailingAnchor.constraint(equalTo: masteryLevel.trailingAnchor, constant: -20),
            moodBoard.centerYAnchor.constraint(equalTo: chicAppeal.centerYAnchor),
            moodBoard.widthAnchor.constraint(equalTo: chicAppeal.widthAnchor),
            moodBoard.heightAnchor.constraint(equalTo: chicAppeal.heightAnchor)
        ])

        masteryLevel.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        UIView.animate(withDuration: 0.24, delay: 0, options: [.curveEaseOut]) {
            overlay.alpha = 1
            masteryLevel.transform = .identity
        }
    }
}
