import AVFoundation
import Photos
import UIKit

enum crystalPathHomeCopy {
    static let surpriseTitle = "Open the surprise box"
    static let customTitle = "Eyelook AI"
    static let profileTitle = "Profile"
    static let messagesTitle = "Messages"
    static let galleryTitle = "Beauty Community"
    static let mineTitle = "Mine"
    static let favoritesTitle = "InspiraBox"
    static let follow = "Follow"
    static let followed = "Following"
    static let commentPlaceholder = "Say something..."
    static let empty = "No inspiration yet"
    static let generating = "Generating..."
    static let generated = "Generated locally"
    static let saved = "Saved to InspiraBox"
    static let removed = "Removed from InspiraBox"
    static let noMessages = "No messages yet"
    static let mutualGateNeedsFollow = "You can send messages only after you and this user follow each other. Please follow this user first and wait for them to follow you back before starting a chat."
    static let mutualGateWaiting = "Hang tight until they follow you back,\nthen the chat will unlock!"

    private static let inspirationCaptions = [
        "Blind box shimmer for a clean lid reveal",
        "Soft crease sparkle saved for daily inspo",
        "Glossy lash lift with a tiny color pop",
        "Deep cut crease energy for bold eyelooks",
        "Festival liner made for surprise-box moods",
        "Dream palette tones for your next try-on",
        "Natural eye glow with a bright inner corner",
        "Brow polish and winged liner in one look",
        "Smokey lid glow for a late-night mirror check",
        "Sparkly brow highlight with playful eyelid shine",
        "Color-pop liner idea from the InspiraBox wall",
        "Gradient shadow blend for custom Eyelook AI prompts",
        "Glossy outer corner detail with dramatic lashes",
        "Pastel shimmer made for quick makeup experiments",
        "Rich lid shade picked for a surprise style draw"
    ]

    static func caption(for item: prismPetalItem) -> String {
        inspirationCaptions[item.id % inspirationCaptions.count]
    }
}

private enum moonlitCompanionGateState {
    case unlocked
    case needsFollow
    case waitingForReturn
}

private final class moonlitCompanionGateCard: UIView {
    private let gradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 31
        layer.masksToBounds = true
        gradientLayer.colors = [
            UIColor(red: 1.0, green: 0.86, blue: 0.98, alpha: 1.0).cgColor,
            UIColor.white.cgColor,
            UIColor(red: 0.68, green: 1.0, blue: 0.76, alpha: 1.0).cgColor
        ]
        gradientLayer.locations = [0.0, 0.55, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.insertSublayer(gradientLayer, at: 0)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = layer.cornerRadius
    }
}

final class sunlitLatticeBackdropView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = auroraLoginPalette.yellow
        isUserInteractionEnabled = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setStrokeColor(UIColor.black.withAlphaComponent(0.08).cgColor)
        context.setLineWidth(1)
        let spacing: CGFloat = 16
        var x: CGFloat = 0
        while x <= rect.width {
            context.move(to: CGPoint(x: x, y: 0))
            context.addLine(to: CGPoint(x: x, y: rect.height))
            x += spacing
        }
        var y: CGFloat = 0
        while y <= rect.height {
            context.move(to: CGPoint(x: 0, y: y))
            context.addLine(to: CGPoint(x: rect.width, y: y))
            y += spacing
        }
        context.strokePath()
    }
}

final class petalInsetLabel: UILabel {
    var insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + insets.left + insets.right, height: size.height + insets.top + insets.bottom)
    }
}

final class crystalPathHomeRouter {
    static func showImageDetail(from source: UIViewController, item: prismPetalItem) {
        source.navigationController?.pushViewController(sableLidInspirationViewController(item: item), animated: true)
    }

    static func showUser(from source: UIViewController, userId: Int) {
        guard userId == velvetAuraStore.shared.activeUserIndex || !velvetAuraStore.shared.isBlocked(userId: userId) else { return }
        if userId == velvetAuraStore.shared.activeUserIndex {
            if let tabs = source.parent as? prismRootTabsViewController {
                tabs.showProfileTab()
            } else {
                source.navigationController?.pushViewController(velvetProfileLandingViewController(), animated: true)
            }
        } else {
            source.navigationController?.pushViewController(celesteMuseProfileViewController(userId: userId), animated: true)
        }
    }

    static func showSurprise(from source: UIViewController) {
        source.navigationController?.pushViewController(marigoldMysteryBoxViewController(), animated: true)
    }

    static func showCustom(from source: UIViewController) {
        source.navigationController?.pushViewController(lilacCanvasCreatorViewController(), animated: true)
    }

    static func showMessages(from source: UIViewController) {
        source.navigationController?.pushViewController(orchidWhisperListViewController(), animated: true)
    }

    static func showGallery(from source: UIViewController) {
        source.navigationController?.pushViewController(coralBloomGalleryViewController(), animated: true)
    }

    static func showMine(from source: UIViewController) {
        source.navigationController?.pushViewController(meadowMuseCenterViewController(), animated: true)
    }

    static func showShare(from source: UIViewController) {
        source.navigationController?.pushViewController(coralSparkShareViewController(), animated: true)
    }
}

class onyxFlowBaseViewController: UIViewController {
    let store = velvetAuraStore.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }

    func makeScrollStack(title: String) -> UIStackView {
        let scroll = UIScrollView()
        scroll.backgroundColor = .black
        view.addSubview(scroll)
        scroll.auroraPinEdges(to: view)

        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 18
        stack.layoutMargins = UIEdgeInsets(top: 82, left: 20, bottom: 32, right: 20)
        stack.isLayoutMarginsRelativeArrangement = true
        scroll.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor),
            stack.leadingAnchor.constraint(equalTo: scroll.contentLayoutGuide.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: scroll.contentLayoutGuide.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor),
            stack.widthAnchor.constraint(equalTo: scroll.frameLayoutGuide.widthAnchor)
        ])
        buildHeader(title: title)
        return stack
    }

    func buildHeader(title: String) {
        let back = UIButton(type: .custom)
        back.setImage(auroraLoginAsset.image("zedDigitalEyeyelookRecommendationBlack.png"), for: .normal)
        back.backgroundColor = .white
        back.layer.cornerRadius = 20
        back.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        view.addSubview(back)
        back.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel()
        label.text = title
        label.textColor = .white
        label.font = auroraLoginFont.peace(22, weight: .bold)
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            back.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            back.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            back.widthAnchor.constraint(equalToConstant: 40),
            back.heightAnchor.constraint(equalToConstant: 40),
            label.centerYAnchor.constraint(equalTo: back.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: back.trailingAnchor, constant: 12)
        ])
    }

    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }

    func presentSafetyActionSheet(userId: Int? = nil, anchor: UIView? = nil, afterBlock: (() -> Void)? = nil) {
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: petalTrailCompleteText.reglobalTrendport, style: .default) { [weak self] _ in
            self?.navigationController?.pushViewController(coralReportViewController(), animated: true)
        })
        sheet.addAction(UIAlertAction(title: petalTrailCompleteText.bsubtleEnhancementlock, style: .destructive) { [weak self] _ in
            guard let self else { return }
            if let userId {
                self.store.blockUser(userId)
            }
            self.auroraShowToast(petalTrailCompleteText.blockDone)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                afterBlock?()
            }
        })
        sheet.addAction(UIAlertAction(title: petalTrailCompleteText.etherealCharmkop, style: .cancel))
        if let popover = sheet.popoverPresentationController {
            if let source = anchor ?? view {
                popover.sourceView = source
                popover.sourceRect = source.bounds
            }
        }
        present(sheet, animated: true)
    }

    func ensureCompanionGateUnlocked(for userId: Int) -> Bool {
        switch companionGateState(for: userId) {
        case .unlocked:
            return true
        case .needsFollow:
            presentCompanionGate(message: crystalPathHomeCopy.mutualGateNeedsFollow)
            return false
        case .waitingForReturn:
            presentCompanionGate(message: crystalPathHomeCopy.mutualGateWaiting)
            return false
        }
    }

    private func companionGateState(for userId: Int) -> moonlitCompanionGateState {
        let activeId = store.activeUserIndex
        guard userId != activeId else { return .unlocked }
        guard let active = store.localUsers.first(where: { $0.microbladeEffect == activeId }),
              let peer = store.localUsers.first(where: { $0.microbladeEffect == userId }) else {
            return .unlocked
        }
        let followsPeer = active.liked.contains(userId)
        let peerFollowsActive = peer.liked.contains(activeId)
        if followsPeer && peerFollowsActive {
            return .unlocked
        }
        return followsPeer ? .waitingForReturn : .needsFollow
    }

    private func presentCompanionGate(message: String) {
        let overlay = UIView()
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.58)
        overlay.alpha = 0
        view.addSubview(overlay)
        overlay.auroraPinEdges(to: view)

        let card = moonlitCompanionGateCard()
        overlay.addSubview(card)
        card.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel()
        label.text = message
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: message.count > 90 ? 20 : 19, weight: .regular)
        card.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        let ok = UIButton(type: .system)
        ok.backgroundColor = UIColor(red: 1.0, green: 0.32, blue: 0.22, alpha: 1.0)
        ok.layer.cornerRadius = 24
        ok.setTitle(petalTrailCompleteText.beadedDetail, for: .normal)
        ok.setTitleColor(.white, for: .normal)
        ok.titleLabel?.font = auroraLoginFont.peace(22, weight: .bold)
        card.addSubview(ok)
        ok.translatesAutoresizingMaskIntoConstraints = false

        let dismiss = { [weak overlay, weak card] in
            guard let overlay, let card else { return }
            UIView.animate(withDuration: 0.18, animations: {
                overlay.alpha = 0
                card.transform = CGAffineTransform(scaleX: 0.96, y: 0.96)
            }) { _ in
                overlay.removeFromSuperview()
            }
        }
        ok.addAction(UIAction { _ in dismiss() }, for: .touchUpInside)

        let preferredCardWidth = card.widthAnchor.constraint(equalTo: overlay.widthAnchor, constant: -80)
        preferredCardWidth.priority = .defaultHigh

        NSLayoutConstraint.activate([
            card.centerXAnchor.constraint(equalTo: overlay.centerXAnchor),
            card.centerYAnchor.constraint(equalTo: overlay.centerYAnchor),
            card.leadingAnchor.constraint(greaterThanOrEqualTo: overlay.leadingAnchor, constant: 40),
            card.trailingAnchor.constraint(lessThanOrEqualTo: overlay.trailingAnchor, constant: -40),
            card.widthAnchor.constraint(lessThanOrEqualToConstant: 442),
            preferredCardWidth,
            label.topAnchor.constraint(equalTo: card.topAnchor, constant: message.count > 90 ? 34 : 33),
            label.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 28),
            label.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -28),
            ok.topAnchor.constraint(equalTo: label.bottomAnchor, constant: message.count > 90 ? 30 : 28),
            ok.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 22),
            ok.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -22),
            ok.heightAnchor.constraint(equalToConstant: 48),
            ok.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -28)
        ])

        card.transform = CGAffineTransform(translationX: 0, y: 14).scaledBy(x: 0.96, y: 0.96)
        UIView.animate(withDuration: 0.22, delay: 0, options: [.curveEaseOut]) {
            overlay.alpha = 1
            card.transform = .identity
        }
    }

    func requestPhotoLibraryAccess(onGranted: @escaping () -> Void) {
        switch PHPhotoLibrary.authorizationStatus(for: .readWrite) {
        case .authorized, .limited:
            onGranted()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { [weak self] status in
                DispatchQueue.main.async {
                    if status == .authorized || status == .limited {
                        onGranted()
                    } else {
                        self?.auroraShowToast(meadowMuseProfileText.permissionDenied)
                    }
                }
            }
        case .denied, .restricted:
            auroraShowToast(meadowMuseProfileText.permissionDenied)
        @unknown default:
            auroraShowToast(meadowMuseProfileText.permissionDenied)
        }
    }

    func requestCameraAccess(onGranted: @escaping () -> Void) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            auroraShowToast(petalTrailCompleteText.noCamera)
            return
        }
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            onGranted()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                DispatchQueue.main.async {
                    granted ? onGranted() : self?.auroraShowToast(meadowMuseProfileText.permissionDenied)
                }
            }
        case .denied, .restricted:
            auroraShowToast(meadowMuseProfileText.permissionDenied)
        @unknown default:
            auroraShowToast(meadowMuseProfileText.permissionDenied)
        }
    }

    func presentImagePicker(source: UIImagePickerController.SourceType, delegate: any UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
        guard UIImagePickerController.isSourceTypeAvailable(source) else {
            auroraShowToast(source == .camera ? petalTrailCompleteText.noCamera : meadowMuseProfileText.permissionDenied)
            return
        }
        let picker = UIImagePickerController()
        picker.sourceType = source
        picker.allowsEditing = false
        picker.delegate = delegate
        present(picker, animated: true)
    }

    func presentMediaSourceSheet(anchor: UIView? = nil, delegate: any UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: petalTrailCompleteText.requestPhotosTitle, style: .default) { [weak self] _ in
            self?.requestPhotoLibraryAccess {
                guard let self else { return }
                self.presentImagePicker(source: .photoLibrary, delegate: delegate)
            }
        })
        sheet.addAction(UIAlertAction(title: petalTrailCompleteText.requestCameraTitle, style: .default) { [weak self] _ in
            self?.requestCameraAccess {
                guard let self else { return }
                self.presentImagePicker(source: .camera, delegate: delegate)
            }
        })
        sheet.addAction(UIAlertAction(title: petalTrailCompleteText.etherealCharmkop, style: .cancel))
        if let popover = sheet.popoverPresentationController {
            if let source = anchor ?? view {
                popover.sourceView = source
                popover.sourceRect = source.bounds
            }
        }
        present(sheet, animated: true)
    }

    func makeHeroImage(_ name: String, height: CGFloat, radius: CGFloat = 24) -> UIImageView {
        let image = UIImageView(image: auroraLoginAsset.image(name))
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = radius
        image.heightAnchor.constraint(equalToConstant: height).isActive = true
        return image
    }

    func makeYellowButton(_ title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = auroraLoginPalette.yellow
        button.layer.cornerRadius = 28
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = auroraLoginFont.peace(22, weight: .bold)
        button.heightAnchor.constraint(equalToConstant: 58).isActive = true
        return button
    }

    func owner(for item: prismPetalItem) -> opalCharmProfile? {
        store.localUsers.first { $0.microbladeEffect == item.owner }
    }
    
    func activeUser() -> opalCharmProfile? {
        store.localUsers.first { $0.microbladeEffect == store.activeUserIndex }
    }

    func isVisibleUser(_ userId: Int) -> Bool {
        userId == store.activeUserIndex || !store.isBlocked(userId: userId)
    }

    func visibleItems(_ items: [prismPetalItem]) -> [prismPetalItem] {
        items.filter { isVisibleUser($0.owner) }
    }

    func makeDesignCanvas(backgroundColor: UIColor = .black, minHeight: CGFloat = 812) -> UIView {
        let scroll = UIScrollView()
        scroll.backgroundColor = backgroundColor
        scroll.showsVerticalScrollIndicator = false
        view.addSubview(scroll)
        scroll.auroraPinEdges(to: view)

        let canvas = UIView()
        canvas.backgroundColor = backgroundColor
        scroll.addSubview(canvas)
        canvas.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            canvas.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor),
            canvas.leadingAnchor.constraint(equalTo: scroll.contentLayoutGuide.leadingAnchor),
            canvas.trailingAnchor.constraint(equalTo: scroll.contentLayoutGuide.trailingAnchor),
            canvas.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor),
            canvas.widthAnchor.constraint(equalTo: scroll.frameLayoutGuide.widthAnchor),
            canvas.heightAnchor.constraint(greaterThanOrEqualTo: scroll.frameLayoutGuide.heightAnchor),
            canvas.heightAnchor.constraint(greaterThanOrEqualToConstant: minHeight)
        ])
        return canvas
    }

    func addAtmosphereBackground(to canvas: UIView) {
        let background = UIImageView(image: auroraLoginAsset.image("zedDigitalEyvirtualBeautyCommunityLooks.png"))
        background.contentMode = .scaleToFill
        background.clipsToBounds = true
        background.isUserInteractionEnabled = false
        canvas.insertSubview(background, at: 0)
        background.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: canvas.topAnchor),
            background.leadingAnchor.constraint(equalTo: canvas.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: canvas.trailingAnchor),
            background.heightAnchor.constraint(equalToConstant: 812)
        ])
    }

    @discardableResult
    func addTopButton(to canvas: UIView, imageName: String? = nil, systemName: String? = nil, leading: CGFloat? = nil, trailing: CGFloat? = nil, top: CGFloat = 50, size: CGFloat = 32, background: UIColor = .white, tint: UIColor = .black, selector: Selector) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = background
        button.layer.cornerRadius = size / 2
        button.clipsToBounds = true
        if let imageName, let image = auroraLoginAsset.image(imageName) {
            button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        } else if let systemName {
            button.setImage(UIImage(systemName: systemName), for: .normal)
            button.tintColor = tint
        }
        button.addTarget(self, action: selector, for: .touchUpInside)
        canvas.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [
            button.topAnchor.constraint(equalTo: canvas.topAnchor, constant: top),
            button.widthAnchor.constraint(equalToConstant: size),
            button.heightAnchor.constraint(equalToConstant: size)
        ]
        if let leading {
            constraints.append(button.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: leading))
        }
        if let trailing {
            constraints.append(button.trailingAnchor.constraint(equalTo: canvas.trailingAnchor, constant: -trailing))
        }
        NSLayoutConstraint.activate(constraints)
        return button
    }

    @discardableResult
    func addDesignTitle(_ text: String, to canvas: UIView, top: CGFloat, color: UIColor = .white, size: CGFloat = 24) -> UILabel {
        let label = makePlainLabel(text, size: size, color: color, weight: .bold)
        label.textAlignment = .center
        canvas.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: canvas.centerXAnchor),
            label.topAnchor.constraint(equalTo: canvas.topAnchor, constant: top),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: canvas.leadingAnchor, constant: 70),
            label.trailingAnchor.constraint(lessThanOrEqualTo: canvas.trailingAnchor, constant: -70)
        ])
        return label
    }
}

final class sableLidInspirationViewController: onyxFlowBaseViewController {
    private var item: prismPetalItem
    private let collectButton = UIButton(type: .custom)
    private let followButton = UIButton(type: .system)

    init(item: prismPetalItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        let canvas = makeDesignCanvas()

        let lattice = sunlitLatticeBackdropView()
        canvas.addSubview(lattice)
        lattice.translatesAutoresizingMaskIntoConstraints = false

        let alluringEyes = UIImageView(image: auroraLoginAsset.image(item.image))
        alluringEyes.contentMode = .scaleAspectFill
        alluringEyes.clipsToBounds = true
        alluringEyes.layer.cornerRadius = 24
        canvas.addSubview(alluringEyes)
        alluringEyes.translatesAutoresizingMaskIntoConstraints = false

        addTopButton(to: canvas, systemName: "chevron.left", leading: 0, selector: #selector(goBack))
        addTopButton(to: canvas, systemName: "exclamationmark.triangle", trailing: 16, background: UIColor.white.withAlphaComponent(0.94), tint: UIColor(white: 0.25, alpha: 1), selector: #selector(lidLuSpecial))

        let date = makePlainLabel(formattedtimelessClassicDate(), size: 14, color: .white, weight: .bold)
        canvas.addSubview(date)
        date.translatesAutoresizingMaskIntoConstraints = false

        let count = makePlainLabel("\(max(item.marks.count, 1))", size: 14, color: .white, weight: .bold)
        canvas.addSubview(count)
        count.translatesAutoresizingMaskIntoConstraints = false

        collectButton.layer.cornerRadius = 31
        collectButton.clipsToBounds = true
        collectButton.addTarget(self, action: #selector(radiantSpirit), for: .touchUpInside)
        canvas.addSubview(collectButton)
        collectButton.translatesAutoresizingMaskIntoConstraints = false

        let profileCard = glamSquadCard()
        canvas.addSubview(profileCard)
        profileCard.translatesAutoresizingMaskIntoConstraints = false

        let homeIndicator = UIImageView(image: auroraLoginAsset.image("lanhuHomeIndicator.png"))
        homeIndicator.contentMode = .scaleToFill
        canvas.addSubview(homeIndicator)
        homeIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            lattice.topAnchor.constraint(equalTo: canvas.topAnchor),
            lattice.leadingAnchor.constraint(equalTo: canvas.leadingAnchor),
            lattice.trailingAnchor.constraint(equalTo: canvas.trailingAnchor),
            lattice.heightAnchor.constraint(equalToConstant: 236),
            date.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: 17),
            date.topAnchor.constraint(equalTo: canvas.topAnchor, constant: 132),
            count.trailingAnchor.constraint(equalTo: canvas.trailingAnchor, constant: -17),
            count.centerYAnchor.constraint(equalTo: date.centerYAnchor),
            alluringEyes.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: 12),
            alluringEyes.trailingAnchor.constraint(equalTo: canvas.trailingAnchor, constant: -12),
            alluringEyes.topAnchor.constraint(equalTo: canvas.topAnchor, constant: 191),
            alluringEyes.heightAnchor.constraint(equalToConstant: 544),
            collectButton.trailingAnchor.constraint(equalTo: canvas.trailingAnchor, constant: -18),
            collectButton.topAnchor.constraint(equalTo: alluringEyes.topAnchor, constant: 286),
            collectButton.widthAnchor.constraint(equalToConstant: 62),
            collectButton.heightAnchor.constraint(equalToConstant: 62),
            profileCard.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: 20),
            profileCard.trailingAnchor.constraint(equalTo: canvas.trailingAnchor, constant: -20),
            profileCard.topAnchor.constraint(equalTo: canvas.topAnchor, constant: 668),
            profileCard.heightAnchor.constraint(equalToConstant: 104),
            homeIndicator.leadingAnchor.constraint(equalTo: canvas.leadingAnchor),
            homeIndicator.trailingAnchor.constraint(equalTo: canvas.trailingAnchor),
            homeIndicator.topAnchor.constraint(equalTo: canvas.topAnchor, constant: 778),
            homeIndicator.heightAnchor.constraint(equalToConstant: 34)
        ])
        chicStyleCollectButton()
    }

    @objc private func radiantSpirit() {
        var users = store.localUsers
        guard let index = users.firstIndex(where: { $0.microbladeEffect == store.activeUserIndex }) else { return }
        if users[index].saved.contains(item.owner) {
            users[index].saved.removeAll { $0 == item.owner }
            auroraShowToast(crystalPathHomeCopy.removed)
        } else {
            users[index].saved.append(item.owner)
            auroraShowToast(crystalPathHomeCopy.saved)
        }
        store.localUsers = users
        chicStyleCollectButton()
    }

    @objc private func lidLuSpecial() {
        presentSafetyActionSheet(userId: item.owner) { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }

    @objc private func eyeArtistry() {
        guard let owner = owner(for: item), owner.microbladeEffect != store.activeUserIndex else { return }
        var users = store.localUsers
        guard let index = users.firstIndex(where: { $0.microbladeEffect == store.activeUserIndex }) else { return }
        if users[index].liked.contains(owner.microbladeEffect) {
            users[index].liked.removeAll { $0 == owner.microbladeEffect }
        } else {
            users[index].liked.append(owner.microbladeEffect)
        }
        store.localUsers = users
        refreshFmodernBeautyButton()
    }

    private func glamSquadCard() -> UIView {
        let card = UIView()
        card.backgroundColor = .white
        card.layer.cornerRadius = 33
        card.layer.masksToBounds = true

        let owner = owner(for: item)
        let avatar = UIImageView(image: auroraLoginAsset.image(store.avatarName(for: owner)))
        avatar.contentMode = .scaleAspectFill
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = 30
        avatar.layer.borderColor = auroraLoginPalette.yellow.cgColor
        avatar.layer.borderWidth = 2
        card.addSubview(avatar)
        avatar.translatesAutoresizingMaskIntoConstraints = false

        let name = makePlainLabel(store.displayName(for: owner), size: 20, color: .black, weight: .bold)
        card.addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false

        let subtitle = makePlainLabel(crystalPathHomeCopy.caption(for: item), size: 12, color: UIColor.black.withAlphaComponent(0.42), weight: .bold)
        card.addSubview(subtitle)
        subtitle.translatesAutoresizingMaskIntoConstraints = false

        followButton.layer.cornerRadius = 15
        followButton.titleLabel?.font = auroraLoginFont.peace(13, weight: .bold)
        followButton.titleLabel?.adjustsFontSizeToFitWidth = true
        followButton.titleLabel?.minimumScaleFactor = 0.72
        followButton.addTarget(self, action: #selector(eyeArtistry), for: .touchUpInside)
        card.addSubview(followButton)
        followButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            avatar.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 17),
            avatar.centerYAnchor.constraint(equalTo: card.centerYAnchor),
            avatar.widthAnchor.constraint(equalToConstant: 60),
            avatar.heightAnchor.constraint(equalToConstant: 60),
            name.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 13),
            name.topAnchor.constraint(equalTo: card.topAnchor, constant: 28),
            name.trailingAnchor.constraint(lessThanOrEqualTo: followButton.leadingAnchor, constant: -12),
            subtitle.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            subtitle.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 4),
            subtitle.trailingAnchor.constraint(lessThanOrEqualTo: followButton.leadingAnchor, constant: -12),
            followButton.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),
            followButton.centerYAnchor.constraint(equalTo: card.centerYAnchor),
            followButton.widthAnchor.constraint(equalToConstant: 88),
            followButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        refreshFmodernBeautyButton()
        return card
    }

    private func chicStyleCollectButton() {
        let selected = activeUser()?.saved.contains(item.owner) ?? false
        collectButton.backgroundColor = selected ? UIColor.white : auroraLoginPalette.yellow
        collectButton.setImage(UIImage(systemName: selected ? "star.fill" : "star"), for: .normal)
        collectButton.tintColor = selected ? UIColor(red: 0.557, green: 0.275, blue: 1.0, alpha: 1.0) : .black
    }

    private func refreshFmodernBeautyButton() {
        let following = activeUser()?.liked.contains(item.owner) ?? false
        followButton.backgroundColor = following ? UIColor.black.withAlphaComponent(0.12) : auroraLoginPalette.yellow
        followButton.setTitle(following ? crystalPathHomeCopy.followed : crystalPathHomeCopy.follow, for: .normal)
        followButton.setTitleColor(.black, for: .normal)
    }

    private func formattedtimelessClassicDate() -> String {
        guard let time = item.time else { return "2024/4/Sunday" }
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy/M/EEEE"
        return formatter.string(from: time)
    }
}

final class celesteMuseProfileViewController: onyxFlowBaseViewController {
    private let userId: Int
    private let followButton = UIButton(type: .system)
//    private let relationBadgeButton = UIButton(type: .system)
    private var profileItems: [prismPetalItem] = []

    init(userId: Int) {
        self.userId = userId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let user = store.localUsers.first { $0.microbladeEffect == userId }
        profileItems = visibleProfileItems()

        let canvas = makeDesignCanvas(backgroundColor: .black, minHeight: 812)
        addProfileBackdrop(to: canvas)
        addTopButton(to: canvas, systemName: "chevron.left", leading: 16, top: 50, size: 32, background: UIColor.white.withAlphaComponent(0.36), tint: .white, selector: #selector(goBack))
        addTopButton(to: canvas, systemName: "exclamationmark.triangle", trailing: 16, top: 50, size: 32, background: UIColor.white.withAlphaComponent(0.28), tint: .white, selector: #selector(openReport))

        let avatar = UIImageView(image: auroraLoginAsset.image(store.avatarName(for: user)))
        avatar.contentMode = .scaleAspectFill
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = 41
        avatar.layer.borderColor = UIColor.white.cgColor
        avatar.layer.borderWidth = 2
        canvas.addSubview(avatar)
        avatar.translatesAutoresizingMaskIntoConstraints = false

        configureProfileActionButton(followButton)
        followButton.addTarget(self, action: #selector(toggleFollow), for: .touchUpInside)
        canvas.addSubview(followButton)
        followButton.translatesAutoresizingMaskIntoConstraints = false

//        configureProfileActionButton(relationBadgeButton)
//        relationBadgeButton.addTarget(self, action: #selector(toggleFollow), for: .touchUpInside)
//        canvas.addSubview(relationBadgeButton)
//        relationBadgeButton.translatesAutoresizingMaskIntoConstraints = false

        let name = makePlainLabel(store.displayName(for: user), size: 28, color: .white, weight: .bold)
        name.textAlignment = .center
        name.shadowColor = UIColor.black.withAlphaComponent(0.42)
        name.shadowOffset = CGSize(width: 0, height: 2)
        canvas.addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false

        let stats = profileStatsCard()
        canvas.addSubview(stats)
        stats.translatesAutoresizingMaskIntoConstraints = false

        let all = makePlainLabel("All", size: 28, color: .white, weight: .bold)
        canvas.addSubview(all)
        all.translatesAutoresizingMaskIntoConstraints = false

        let row = profileItemScroller()
        canvas.addSubview(row)
        row.translatesAutoresizingMaskIntoConstraints = false

        let camera = bottomActionButton(color: auroraLoginPalette.yellow, image: "video.fill", tint: .black)
        camera.addTarget(self, action: #selector(openVideoCall), for: .touchUpInside)
        view.addSubview(camera)
        camera.translatesAutoresizingMaskIntoConstraints = false

        let chat = bottomActionButton(color: auroraLoginPalette.lime, image: "ellipsis.message.fill", tint: .white)
        chat.addTarget(self, action: #selector(openChat), for: .touchUpInside)
        view.addSubview(chat)
        chat.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            avatar.centerXAnchor.constraint(equalTo: canvas.centerXAnchor),
            avatar.topAnchor.constraint(equalTo: canvas.topAnchor, constant: 348),
            avatar.widthAnchor.constraint(equalToConstant: 82),
            avatar.heightAnchor.constraint(equalToConstant: 82),
            followButton.centerXAnchor.constraint(equalTo: avatar.centerXAnchor, constant: 6),
            followButton.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: -21),
            followButton.widthAnchor.constraint(equalToConstant: 44),
            followButton.heightAnchor.constraint(equalToConstant: 30),
//            relationBadgeButton.centerYAnchor.constraint(equalTo: followButton.centerYAnchor),
//            relationBadgeButton.trailingAnchor.constraint(equalTo: canvas.trailingAnchor, constant: -58),
//            relationBadgeButton.widthAnchor.constraint(equalToConstant: 90),
//            relationBadgeButton.heightAnchor.constraint(equalToConstant: 58),
            name.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 42),
            name.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: 24),
            name.trailingAnchor.constraint(equalTo: canvas.trailingAnchor, constant: -24),
            stats.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: 24),
            stats.trailingAnchor.constraint(equalTo: canvas.trailingAnchor, constant: -24),
            stats.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 32),
            stats.heightAnchor.constraint(equalToConstant: 148),
            all.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: 24),
            all.topAnchor.constraint(equalTo: stats.bottomAnchor, constant: 60),
            row.leadingAnchor.constraint(equalTo: canvas.leadingAnchor),
            row.trailingAnchor.constraint(equalTo: canvas.trailingAnchor),
            row.topAnchor.constraint(equalTo: all.bottomAnchor, constant: 26),
            row.heightAnchor.constraint(equalToConstant: 174),
            camera.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: 18),
            camera.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:-30),
            camera.widthAnchor.constraint(equalToConstant: 158),
            camera.heightAnchor.constraint(equalToConstant: 48),
            chat.trailingAnchor.constraint(equalTo: canvas.trailingAnchor, constant: -18),
            chat.centerYAnchor.constraint(equalTo: camera.centerYAnchor),
            chat.widthAnchor.constraint(equalToConstant: 158),
            chat.heightAnchor.constraint(equalToConstant: 48),
            canvas.bottomAnchor.constraint(greaterThanOrEqualTo: camera.bottomAnchor, constant: 36)
        ])
        refreshFollowButtons()
    }

    private func addProfileBackdrop(to canvas: UIView) {
        let lower = UIImageView(image: auroraLoginAsset.image("zedDigitalEyinteractiveMakeupExperienceInnovation.png"))
        lower.contentMode = .scaleToFill
        lower.clipsToBounds = true
        canvas.addSubview(lower)
        lower.translatesAutoresizingMaskIntoConstraints = false

        let hero = UIImageView(image: auroraLoginAsset.image("lanhuProfileHeroBackground.png"))
        hero.contentMode = .scaleToFill
        hero.clipsToBounds = true
        canvas.addSubview(hero)
        hero.translatesAutoresizingMaskIntoConstraints = false

        let leftDecor = UIImageView(image: auroraLoginAsset.image("lanhuProfileDecorBackground.png"))
        leftDecor.contentMode = .scaleAspectFill
        leftDecor.alpha = 0.92
        canvas.addSubview(leftDecor)
        leftDecor.translatesAutoresizingMaskIntoConstraints = false

        let rightDecor = UIImageView(image: auroraLoginAsset.image("lanhuProfileRightDecor.png"))
        rightDecor.contentMode = .scaleAspectFill
        rightDecor.alpha = 0.72
        canvas.addSubview(rightDecor)
        rightDecor.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            lower.topAnchor.constraint(equalTo: canvas.topAnchor),
            lower.leadingAnchor.constraint(equalTo: canvas.leadingAnchor),
            lower.trailingAnchor.constraint(equalTo: canvas.trailingAnchor),
            lower.heightAnchor.constraint(equalToConstant: 812),
            hero.topAnchor.constraint(equalTo: canvas.topAnchor),
            hero.leadingAnchor.constraint(equalTo: canvas.leadingAnchor),
            hero.trailingAnchor.constraint(equalTo: canvas.trailingAnchor),
            hero.heightAnchor.constraint(equalToConstant: 380),
            leftDecor.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: -72),
            leftDecor.topAnchor.constraint(equalTo: canvas.topAnchor, constant: 548),
            leftDecor.widthAnchor.constraint(equalToConstant: 162),
            leftDecor.heightAnchor.constraint(equalToConstant: 323),
            rightDecor.trailingAnchor.constraint(equalTo: canvas.trailingAnchor, constant: 68),
            rightDecor.topAnchor.constraint(equalTo: canvas.topAnchor, constant: 604),
            rightDecor.widthAnchor.constraint(equalToConstant: 220),
            rightDecor.heightAnchor.constraint(equalToConstant: 382)
        ])
    }

    private func configureProfileActionButton(_ button: UIButton) {
        button.backgroundColor = auroraLoginPalette.yellow
        button.layer.cornerRadius = 29
        button.clipsToBounds = true
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFit
    }

    private func refreshFollowButtons() {
        let following = isFollowing()
        let primaryName = following ? "person.fill.checkmark" : "person.badge.plus"
        followButton.setImage(UIImage(systemName: primaryName), for: .normal)
//        relationBadgeButton.setImage(UIImage(systemName: badgeName), for: .normal)
        followButton.tintColor = following ? UIColor.black.withAlphaComponent(0.65) : .black
//        relationBadgeButton.tintColor = following ? UIColor.black.withAlphaComponent(0.36) : .black
    }

    private func profileStatsCard() -> UIView {
        let card = UIView()
        card.backgroundColor = .white
        card.layer.cornerRadius = 28
        card.layer.masksToBounds = true

        let following = statColumn(value: "0", title: petalTrailCompleteText.copperGlowinfo)
        let fans = statColumn(value: "0", title: petalTrailCompleteText.artisticExpressionfans)
        card.addSubview(following)
        card.addSubview(fans)
        following.translatesAutoresizingMaskIntoConstraints = false
        fans.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            following.leadingAnchor.constraint(equalTo: card.leadingAnchor),
            following.topAnchor.constraint(equalTo: card.topAnchor),
            following.bottomAnchor.constraint(equalTo: card.bottomAnchor),
            following.widthAnchor.constraint(equalTo: card.widthAnchor, multiplier: 0.5),
            fans.trailingAnchor.constraint(equalTo: card.trailingAnchor),
            fans.topAnchor.constraint(equalTo: card.topAnchor),
            fans.bottomAnchor.constraint(equalTo: card.bottomAnchor),
            fans.widthAnchor.constraint(equalTo: card.widthAnchor, multiplier: 0.5)
        ])
        return card
    }

    private func statColumn(value: String, title: String) -> UIView {
        let column = UIStackView()
        column.axis = .vertical
        column.alignment = .center
        column.spacing = 8
        column.isLayoutMarginsRelativeArrangement = true
        column.layoutMargins = UIEdgeInsets(top: 34, left: 4, bottom: 24, right: 4)

        let valueLabel = makePlainLabel(value, size: 26, color: .black, weight: .bold)
        valueLabel.textAlignment = .center
        let titleLabel = makePlainLabel(title, size: 17, color: UIColor.black.withAlphaComponent(0.24), weight: .bold)
        titleLabel.textAlignment = .center
        column.addArrangedSubview(valueLabel)
        column.addArrangedSubview(titleLabel)
        return column
    }

    private func profileItemScroller() -> UIScrollView {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.alwaysBounceHorizontal = true

        let row = UIStackView()
        row.axis = .horizontal
        row.spacing = 24
        row.isLayoutMarginsRelativeArrangement = true
        row.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        scroll.addSubview(row)
        row.translatesAutoresizingMaskIntoConstraints = false

        for item in profileItems {
            let button = UIButton(type: .custom)
            button.setImage(auroraLoginAsset.image(item.image), for: .normal)
            button.imageView?.contentMode = .scaleAspectFill
            button.clipsToBounds = true
            button.layer.cornerRadius = 14
            button.tag = item.id
            button.addTarget(self, action: #selector(openProfileItem(_:)), for: .touchUpInside)
            row.addArrangedSubview(button)
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 136),
                button.heightAnchor.constraint(equalToConstant: 168)
            ])
        }

        NSLayoutConstraint.activate([
            row.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor),
            row.leadingAnchor.constraint(equalTo: scroll.contentLayoutGuide.leadingAnchor),
            row.trailingAnchor.constraint(equalTo: scroll.contentLayoutGuide.trailingAnchor),
            row.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor),
            row.heightAnchor.constraint(equalTo: scroll.frameLayoutGuide.heightAnchor)
        ])
        return scroll
    }

    private func bottomActionButton(color: UIColor, image: String, tint: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = color
        button.layer.cornerRadius = 24
        button.tintColor = tint
        button.setImage(UIImage(systemName: image), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }

    private func visibleProfileItems() -> [prismPetalItem] {
        let owned = visibleItems(store.inspirationItems).filter { $0.owner == userId }
        return Array(owned.prefix(8))
    }

    @objc private func toggleFollow() {
        var users = store.localUsers
        guard let index = users.firstIndex(where: { $0.microbladeEffect == store.activeUserIndex }) else { return }
        if users[index].liked.contains(userId) {
            users[index].liked.removeAll { $0 == userId }
        } else {
            users[index].liked.append(userId)
        }
        store.localUsers = users
        refreshFollowButtons()
    }

    @objc private func openReport() {
        presentSafetyActionSheet(userId: userId) { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }

    @objc private func openVideoCall() {
        guard ensureCompanionGateUnlocked(for: userId) else { return }
        navigationController?.pushViewController(onyxCallShellViewController(peerUserId: userId), animated: true)
    }

    @objc private func openChat() {
        guard ensureCompanionGateUnlocked(for: userId) else { return }
        navigationController?.pushViewController(roseQuartzThreadViewController(room: userId), animated: true)
    }

    @objc private func openProfileItem(_ sender: UIButton) {
        guard let item = profileItems.first(where: { $0.id == sender.tag }) else { return }
        navigationController?.pushViewController(sableLidInspirationViewController(item: item), animated: true)
    }

    private func isFollowing() -> Bool {
        activeUser()?.liked.contains(userId) ?? false
    }
}

private final class marigoldGlowActionButton: UIButton {
    private let glowLayer = CAGradientLayer()

    init(title: String, colors: [UIColor]) {
        super.init(frame: .zero)
        glowLayer.colors = colors.map(\.cgColor)
        glowLayer.startPoint = CGPoint(x: 0, y: 0.5)
        glowLayer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.insertSublayer(glowLayer, at: 0)
        layer.masksToBounds = true
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = auroraLoginFont.peace(15, weight: .bold)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        glowLayer.frame = bounds
        glowLayer.cornerRadius = bounds.height / 2
    }
}

final class marigoldMysteryBoxViewController: onyxFlowBaseViewController {
    private let gemCost = 100
    private let chanceLabel = petalInsetLabel()
    private weak var flowOverlay: UIView?
    private var latestPrize: prismPetalItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        buildMysteryBoxPage()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateChanceText()
    }

    private func buildMysteryBoxPage() {
        let canvas = makeDesignCanvas(minHeight: 812)

        let background = UIImageView(image: auroraLoginAsset.image("zedDigitalEymakeupVisionAIBeautyLooks.png"))
        background.contentMode = .scaleToFill
        background.clipsToBounds = true
        canvas.addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false

        addTopButton(
            to: canvas,
            systemName: "chevron.left",
            leading: 16,
            top: 49,
            size: 30,
            background: UIColor.white.withAlphaComponent(0.20),
            tint: .white,
            selector: #selector(goBack)
        )

        let open = UIButton(type: .custom)
        open.setBackgroundImage(auroraLoginAsset.image("zedDigitalEybeautyCommunitymakeup.png"), for: .normal)
        open.accessibilityLabel = pearlGazeText.visible.shimmerFinish
        open.addTarget(self, action: #selector(openBox), for: .touchUpInside)
        canvas.addSubview(open)
        open.translatesAutoresizingMaskIntoConstraints = false

        chanceLabel.insets = UIEdgeInsets(top: 6, left: 15, bottom: 6, right: 15)
        chanceLabel.textAlignment = .center
        chanceLabel.numberOfLines = 1
        chanceLabel.backgroundColor = UIColor.black.withAlphaComponent(0.42)
        chanceLabel.layer.cornerRadius = 14
        chanceLabel.layer.masksToBounds = true
        canvas.addSubview(chanceLabel)
        chanceLabel.translatesAutoresizingMaskIntoConstraints = false
        updateChanceText()

        let title = makeGiftBoxTitle()
        canvas.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false

        let preview = makeSurprisePreviewRow()
        canvas.addSubview(preview)
        preview.translatesAutoresizingMaskIntoConstraints = false

        let homeIndicator = UIImageView(image: auroraLoginAsset.image("lanhuHomeIndicator.png"))
        homeIndicator.contentMode = .scaleAspectFit
        canvas.addSubview(homeIndicator)
        homeIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: canvas.topAnchor),
            background.leadingAnchor.constraint(equalTo: canvas.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: canvas.trailingAnchor),
            background.heightAnchor.constraint(equalToConstant: 812),
            open.centerXAnchor.constraint(equalTo: canvas.centerXAnchor),
            open.topAnchor.constraint(equalTo: canvas.topAnchor, constant: 392),
            open.widthAnchor.constraint(equalToConstant: 216),
            open.heightAnchor.constraint(equalToConstant: 93),
            chanceLabel.centerXAnchor.constraint(equalTo: canvas.centerXAnchor),
            chanceLabel.topAnchor.constraint(equalTo: open.bottomAnchor, constant: -4),
            chanceLabel.heightAnchor.constraint(equalToConstant: 28),
            title.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: 18),
            title.trailingAnchor.constraint(equalTo: canvas.trailingAnchor, constant: -18),
            title.topAnchor.constraint(equalTo: chanceLabel.bottomAnchor, constant: 38),
            preview.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: 18),
            preview.trailingAnchor.constraint(equalTo: canvas.trailingAnchor, constant: -18),
            preview.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 14),
            preview.heightAnchor.constraint(equalToConstant: 88),
            homeIndicator.centerXAnchor.constraint(equalTo: canvas.centerXAnchor),
            homeIndicator.bottomAnchor.constraint(equalTo: canvas.safeAreaLayoutGuide.bottomAnchor, constant: -7),
            homeIndicator.widthAnchor.constraint(equalToConstant: 135),
            homeIndicator.heightAnchor.constraint(equalToConstant: 5)
        ])
    }

    @objc private func openBox() {
        if store.browsNumber > 0 {
            showFreeDrawDialog()
        } else if hasEnoughGems() {
            showGemConfirmDialog()
        } else {
            showInsufficientDialog()
        }
    }

    private func startOpeningFlow(needsGemCost: Bool) {
        if needsGemCost {
            guard consumeGems() else {
                showInsufficientDialog()
                return
            }
        } else {
            store.browsNumber = max(0, store.browsNumber - 1)
        }
        updateChanceText()
        let prize = createPrizeItem()
        showOpeningAnimation { [weak self] in
            self?.showPrizeDialog(item: prize)
        }
    }

    private func updateChanceText() {
        let text = "\(meadowMuseProfileText.youHave) \(store.browsNumber) \(meadowMuseProfileText.moreChances)"
        let attributed = NSMutableAttributedString(
            string: text,
            attributes: [
                .font: auroraLoginFont.peace(8, weight: .bold),
                .foregroundColor: UIColor.white.withAlphaComponent(0.88)
            ]
        )
        let range = (text as NSString).range(of: "\(store.browsNumber)")
        if range.location != NSNotFound {
            attributed.addAttributes([
                .foregroundColor: auroraLoginPalette.yellow,
                .font: auroraLoginFont.peace(9, weight: .bold)
            ], range: range)
        }
        chanceLabel.attributedText = attributed
    }

    private func makeGiftBoxTitle() -> UILabel {
        let text = "\(meadowMuseProfileText.thereAre) \(meadowMuseProfileText.tealTouch) \(meadowMuseProfileText.giftBox)"
        let label = makePlainLabel(text, size: 13, color: .white, weight: .bold)
        let attributed = NSMutableAttributedString(
            string: text,
            attributes: [
                .font: auroraLoginFont.peace(13, weight: .bold),
                .foregroundColor: UIColor.white
            ]
        )
        let range = (text as NSString).range(of: meadowMuseProfileText.tealTouch)
        if range.location != NSNotFound {
            attributed.addAttribute(.foregroundColor, value: auroraLoginPalette.yellow, range: range)
        }
        label.attributedText = attributed
        label.textAlignment = .left
        return label
    }

    private func makeSurprisePreviewRow() -> UIView {
        let container = UIView()
        container.backgroundColor = UIColor(red: 0.50, green: 0.33, blue: 0.85, alpha: 0.86)
        container.layer.cornerRadius = 13
        container.layer.borderWidth = 1
        container.layer.borderColor = UIColor(red: 0.84, green: 0.67, blue: 1.0, alpha: 0.75).cgColor

        let row = UIStackView()
        row.axis = .horizontal
        row.distribution = .fillEqually
        row.spacing = 8
        container.addSubview(row)
        row.translatesAutoresizingMaskIntoConstraints = false

        previewImages().forEach { name in
            let card = UIImageView(image: auroraLoginAsset.image(name))
            card.contentMode = .scaleAspectFill
            card.clipsToBounds = true
            card.layer.cornerRadius = 8
            card.layer.borderWidth = 1
            card.layer.borderColor = UIColor.white.withAlphaComponent(0.72).cgColor
            row.addArrangedSubview(card)
        }

        NSLayoutConstraint.activate([
            row.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
            row.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8),
            row.topAnchor.constraint(equalTo: container.topAnchor, constant: 8),
            row.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8)
        ])
        return container
    }

    private func previewImages() -> [String] {
        let names = store.inspirationItems.prefix(4).map(\.image).filter { auroraLoginAsset.image($0) != nil }
        return names.isEmpty ? ["zedDigitalEymakeupArtistryBoxMakeupExchang.png"] : names
    }

    private func showFreeDrawDialog() {
        let overlay = makeFlowOverlay(alpha: 0.58)
        let card = makeDialogImage("zedDigitalEyglobalMakeupImakeupLookVision.png", width: 294, height: 302)
        overlay.addSubview(card)

        let message = dialogLabel("You can only draw eye makeup blind boxes three times a day. After exceeding 3 times, it costs 100 gold coins per draw.", size: 12)
        card.addSubview(message)
        message.translatesAutoresizingMaskIntoConstraints = false

        let cancel = assetButton("zedDigitalEybeautyLookCollectionTrendsetterAI.png", accessibility: petalTrailCompleteText.etherealCharmkop)
        cancel.addTarget(self, action: #selector(closeFlowOverlay), for: .touchUpInside)
        card.addSubview(cancel)
        cancel.translatesAutoresizingMaskIntoConstraints = false

        let open = marigoldGlowActionButton(
            title: pearlGazeText.visible.shimmerFinish,
            colors: [
                UIColor(red: 1.0, green: 0.75, blue: 0.45, alpha: 1.0),
                UIColor(red: 1.0, green: 0.22, blue: 0.55, alpha: 1.0)
            ]
        )
        open.addTarget(self, action: #selector(confirmFreeOpen), for: .touchUpInside)
        card.addSubview(open)
        open.translatesAutoresizingMaskIntoConstraints = false
        addGemCostBadge(to: open)

        let close = closeCircleButton()
        overlay.addSubview(close)
        close.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            card.centerXAnchor.constraint(equalTo: overlay.centerXAnchor),
            card.centerYAnchor.constraint(equalTo: overlay.centerYAnchor, constant: 16),
            message.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            message.topAnchor.constraint(equalTo: card.topAnchor, constant: 129),
            message.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 50),
            message.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -50),
            cancel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 32),
            cancel.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -28),
            cancel.widthAnchor.constraint(equalToConstant: 92),
            cancel.heightAnchor.constraint(equalToConstant: 43),
            open.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -32),
            open.centerYAnchor.constraint(equalTo: cancel.centerYAnchor),
            open.widthAnchor.constraint(equalToConstant: 108),
            open.heightAnchor.constraint(equalToConstant: 45),
            close.centerXAnchor.constraint(equalTo: overlay.centerXAnchor),
            close.topAnchor.constraint(equalTo: card.bottomAnchor, constant: 14),
            close.widthAnchor.constraint(equalToConstant: 30),
            close.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func showInsufficientDialog() {
        let overlay = makeFlowOverlay(alpha: 0.60)
        let card = makeDialogImage("zedDigitalEyeyeMakeupInspirationAIGenerator.png", width: 286, height: 314)
        overlay.addSubview(card)

        let message = dialogLabel(petalTrailCompleteText.forestGreen, size: 12)
        card.addSubview(message)
        message.translatesAutoresizingMaskIntoConstraints = false

        let cancel = assetButton("zedDigitalEybeautyLookCollectionTrendsetterAI.png", accessibility: petalTrailCompleteText.etherealCharmkop)
        cancel.addTarget(self, action: #selector(closeFlowOverlay), for: .touchUpInside)
        card.addSubview(cancel)
        cancel.translatesAutoresizingMaskIntoConstraints = false

        let recharge = marigoldGlowActionButton(
            title: petalTrailCompleteText.pearlWhite.replacingOccurrences(of: " amount", with: ""),
            colors: [
                UIColor(red: 1.0, green: 0.75, blue: 0.45, alpha: 1.0),
                UIColor(red: 1.0, green: 0.22, blue: 0.55, alpha: 1.0)
            ]
        )
        recharge.addTarget(self, action: #selector(openRechargePage), for: .touchUpInside)
        card.addSubview(recharge)
        recharge.translatesAutoresizingMaskIntoConstraints = false

        let close = closeCircleButton()
        overlay.addSubview(close)
        close.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            card.centerXAnchor.constraint(equalTo: overlay.centerXAnchor),
            card.centerYAnchor.constraint(equalTo: overlay.centerYAnchor, constant: 16),
            message.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            message.topAnchor.constraint(equalTo: card.topAnchor, constant: 141),
            message.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 46),
            message.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -46),
            cancel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 30),
            cancel.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -40),
            cancel.widthAnchor.constraint(equalToConstant: 92),
            cancel.heightAnchor.constraint(equalToConstant: 43),
            recharge.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -30),
            recharge.centerYAnchor.constraint(equalTo: cancel.centerYAnchor),
            recharge.widthAnchor.constraint(equalToConstant: 112),
            recharge.heightAnchor.constraint(equalToConstant: 45),
            close.centerXAnchor.constraint(equalTo: overlay.centerXAnchor),
            close.topAnchor.constraint(equalTo: card.bottomAnchor, constant: 14),
            close.widthAnchor.constraint(equalToConstant: 30),
            close.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func showGemConfirmDialog() {
        let overlay = makeFlowOverlay(alpha: 0.60)
        let card = makeDialogImage("zedDigitalEymakeupStyleCustomizerEyeMakeup.png", width: 286, height: 314)
        overlay.addSubview(card)

        let messageText = "\(petalTrailCompleteText.sapphireBlue.trimmingCharacters(in: .whitespaces))\n\(gemCost) \(petalTrailCompleteText.rubyRed)"
        let message = dialogLabel(messageText, size: 12)
        let attributed = NSMutableAttributedString(
            string: messageText,
            attributes: [
                .font: auroraLoginFont.peace(12, weight: .bold),
                .foregroundColor: UIColor.black
            ]
        )
        let range = (messageText as NSString).range(of: "\(gemCost)")
        if range.location != NSNotFound {
            attributed.addAttribute(.foregroundColor, value: UIColor(red: 1.0, green: 0.22, blue: 0.55, alpha: 1.0), range: range)
        }
        message.attributedText = attributed
        card.addSubview(message)
        message.translatesAutoresizingMaskIntoConstraints = false

        let cancel = assetButton("zedDigitalEybeautyLookCollectionTrendsetterAI.png", accessibility: petalTrailCompleteText.etherealCharmkop)
        cancel.addTarget(self, action: #selector(closeFlowOverlay), for: .touchUpInside)
        card.addSubview(cancel)
        cancel.translatesAutoresizingMaskIntoConstraints = false

        let confirm = marigoldGlowActionButton(
            title: "Confirm",
            colors: [
                UIColor(red: 1.0, green: 0.72, blue: 0.42, alpha: 1.0),
                UIColor(red: 1.0, green: 0.22, blue: 0.55, alpha: 1.0)
            ]
        )
        confirm.addTarget(self, action: #selector(confirmGemOpen), for: .touchUpInside)
        card.addSubview(confirm)
        confirm.translatesAutoresizingMaskIntoConstraints = false

        let close = closeCircleButton()
        overlay.addSubview(close)
        close.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            card.centerXAnchor.constraint(equalTo: overlay.centerXAnchor),
            card.centerYAnchor.constraint(equalTo: overlay.centerYAnchor, constant: 16),
            message.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            message.topAnchor.constraint(equalTo: card.topAnchor, constant: 136),
            message.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 42),
            message.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -42),
            cancel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 30),
            cancel.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -40),
            cancel.widthAnchor.constraint(equalToConstant: 92),
            cancel.heightAnchor.constraint(equalToConstant: 43),
            confirm.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -30),
            confirm.centerYAnchor.constraint(equalTo: cancel.centerYAnchor),
            confirm.widthAnchor.constraint(equalToConstant: 112),
            confirm.heightAnchor.constraint(equalToConstant: 45),
            close.centerXAnchor.constraint(equalTo: overlay.centerXAnchor),
            close.topAnchor.constraint(equalTo: card.bottomAnchor, constant: 14),
            close.widthAnchor.constraint(equalToConstant: 30),
            close.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func showOpeningAnimation(completion: @escaping () -> Void) {
        let overlay = makeFlowOverlay(alpha: 0.50)

        let ring = UIView()
        ring.layer.cornerRadius = 118
        ring.layer.borderWidth = 6
        ring.layer.borderColor = UIColor.white.withAlphaComponent(0.72).cgColor
        ring.alpha = 0.0
        overlay.addSubview(ring)
        ring.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            ring.centerXAnchor.constraint(equalTo: overlay.centerXAnchor),
            ring.topAnchor.constraint(equalTo: overlay.safeAreaLayoutGuide.topAnchor, constant: 190),
            ring.widthAnchor.constraint(equalToConstant: 236),
            ring.heightAnchor.constraint(equalToConstant: 236)
        ])

        addConfetti(to: overlay)
        overlay.layoutIfNeeded()
        ring.transform = CGAffineTransform(scaleX: 0.55, y: 0.55)
        UIView.animate(withDuration: 0.78, delay: 0, options: [.curveEaseOut]) {
            ring.alpha = 1.0
            ring.transform = .identity
        }
        UIView.animate(withDuration: 0.50, delay: 0.70, options: [.curveEaseIn]) {
            ring.alpha = 0.0
            ring.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.18) { [weak self, weak overlay] in
            overlay?.removeFromSuperview()
            if self?.flowOverlay === overlay {
                self?.flowOverlay = nil
            }
            completion()
        }
    }

    private func showPrizeDialog(item: prismPetalItem) {
        latestPrize = item
        let overlay = makeFlowOverlay(alpha: 0.44)

        let title = makePlainLabel("Congratulations on\ngetting it", size: 22, color: auroraLoginPalette.yellow, weight: .bold)
        title.numberOfLines = 2
        title.textAlignment = .center
        title.shadowColor = UIColor(red: 0.31, green: 0.25, blue: 1.0, alpha: 1.0)
        title.shadowOffset = CGSize(width: 2, height: 2)
        overlay.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false

        let frameBack = UIView()
        frameBack.backgroundColor = UIColor(red: 0.57, green: 0.24, blue: 0.97, alpha: 1.0)
        frameBack.layer.cornerRadius = 26
        overlay.addSubview(frameBack)
        frameBack.translatesAutoresizingMaskIntoConstraints = false

        let frameFront = UIView()
        frameFront.backgroundColor = UIColor(red: 0.63, green: 0.39, blue: 1.0, alpha: 1.0)
        frameFront.layer.cornerRadius = 26
        frameFront.layer.borderWidth = 5
        frameFront.layer.borderColor = auroraLoginPalette.yellow.cgColor
        frameBack.addSubview(frameFront)
        frameFront.translatesAutoresizingMaskIntoConstraints = false

        let image = UIImageView(image: auroraLoginAsset.image(item.image))
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 18
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.white.withAlphaComponent(0.88).cgColor
        frameFront.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false

        let detailButton = UIButton(type: .custom)
        detailButton.addTarget(self, action: #selector(openPrizeDetail), for: .touchUpInside)
        frameFront.addSubview(detailButton)
        detailButton.translatesAutoresizingMaskIntoConstraints = false

        let close = closeCircleButton()
        overlay.addSubview(close)
        close.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: overlay.centerXAnchor),
            title.topAnchor.constraint(equalTo: overlay.safeAreaLayoutGuide.topAnchor, constant: 104),
            frameBack.centerXAnchor.constraint(equalTo: overlay.centerXAnchor),
            frameBack.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16),
            frameBack.widthAnchor.constraint(equalToConstant: 218),
            frameBack.heightAnchor.constraint(equalToConstant: 256),
            frameFront.topAnchor.constraint(equalTo: frameBack.topAnchor, constant: 12),
            frameFront.leadingAnchor.constraint(equalTo: frameBack.leadingAnchor, constant: 12),
            frameFront.trailingAnchor.constraint(equalTo: frameBack.trailingAnchor, constant: -12),
            frameFront.bottomAnchor.constraint(equalTo: frameBack.bottomAnchor, constant: -12),
            image.topAnchor.constraint(equalTo: frameFront.topAnchor, constant: 12),
            image.leadingAnchor.constraint(equalTo: frameFront.leadingAnchor, constant: 12),
            image.trailingAnchor.constraint(equalTo: frameFront.trailingAnchor, constant: -12),
            image.bottomAnchor.constraint(equalTo: frameFront.bottomAnchor, constant: -12),
            detailButton.topAnchor.constraint(equalTo: frameFront.topAnchor),
            detailButton.leadingAnchor.constraint(equalTo: frameFront.leadingAnchor),
            detailButton.trailingAnchor.constraint(equalTo: frameFront.trailingAnchor),
            detailButton.bottomAnchor.constraint(equalTo: frameFront.bottomAnchor),
            close.centerXAnchor.constraint(equalTo: overlay.centerXAnchor),
            close.topAnchor.constraint(equalTo: frameBack.bottomAnchor, constant: 22),
            close.widthAnchor.constraint(equalToConstant: 30),
            close.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func makeFlowOverlay(alpha: CGFloat) -> UIView {
        closeFlowOverlay()
        let overlay = UIView()
        overlay.backgroundColor = UIColor.black.withAlphaComponent(alpha)
        view.addSubview(overlay)
        overlay.auroraPinEdges(to: view)
        flowOverlay = overlay
        return overlay
    }

    private func makeDialogImage(_ name: String, width: CGFloat, height: CGFloat) -> UIImageView {
        let image = UIImageView(image: auroraLoginAsset.image(name))
        image.contentMode = .scaleToFill
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: width),
            image.heightAnchor.constraint(equalToConstant: height)
        ])
        return image
    }

    private func dialogLabel(_ text: String, size: CGFloat) -> UILabel {
        let label = makePlainLabel(text, size: size, color: .black, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.75
        return label
    }

    private func assetButton(_ imageName: String, accessibility: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(auroraLoginAsset.image(imageName), for: .normal)
        button.accessibilityLabel = accessibility
        return button
    }

    private func closeCircleButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.white.withAlphaComponent(0.18)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(closeFlowOverlay), for: .touchUpInside)
        return button
    }

    private func addGemCostBadge(to button: UIButton) {
        let badge = UIView()
        badge.backgroundColor = auroraLoginPalette.yellow
        badge.layer.cornerRadius = 11
        badge.layer.borderColor = UIColor.white.withAlphaComponent(0.72).cgColor
        badge.layer.borderWidth = 1
        button.addSubview(badge)
        badge.translatesAutoresizingMaskIntoConstraints = false

        let label = makePlainLabel("\(gemCost)", size: 10, color: UIColor(red: 1.0, green: 0.23, blue: 0.54, alpha: 1.0), weight: .bold)
        label.textAlignment = .center
        badge.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        let coin = UIImageView(image: auroraLoginAsset.image("zedDigitalEyookInsasxifvpoxs.png"))
        coin.contentMode = .scaleAspectFit
        badge.addSubview(coin)
        coin.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            badge.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: 4),
            badge.topAnchor.constraint(equalTo: button.topAnchor, constant: -10),
            badge.widthAnchor.constraint(equalToConstant: 46),
            badge.heightAnchor.constraint(equalToConstant: 22),
            label.leadingAnchor.constraint(equalTo: badge.leadingAnchor, constant: 8),
            label.centerYAnchor.constraint(equalTo: badge.centerYAnchor),
            coin.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 2),
            coin.trailingAnchor.constraint(equalTo: badge.trailingAnchor, constant: -3),
            coin.centerYAnchor.constraint(equalTo: badge.centerYAnchor),
            coin.widthAnchor.constraint(equalToConstant: 16),
            coin.heightAnchor.constraint(equalToConstant: 16)
        ])
    }

    private func addConfetti(to overlay: UIView) {
        let colors = [
            UIColor(red: 1.0, green: 0.70, blue: 0.28, alpha: 1.0),
            UIColor(red: 0.44, green: 0.92, blue: 1.0, alpha: 1.0),
            UIColor(red: 1.0, green: 0.36, blue: 0.74, alpha: 1.0),
            UIColor(red: 0.56, green: 0.41, blue: 1.0, alpha: 1.0),
            auroraLoginPalette.yellow
        ]
        for index in 0..<26 {
            let piece = UIView()
            piece.backgroundColor = colors[index % colors.count]
            piece.layer.cornerRadius = 2
            overlay.addSubview(piece)
            piece.translatesAutoresizingMaskIntoConstraints = false
            let x = CGFloat.random(in: -120...120)
            let y = CGFloat.random(in: 125...235)
            NSLayoutConstraint.activate([
                piece.centerXAnchor.constraint(equalTo: overlay.centerXAnchor, constant: x),
                piece.topAnchor.constraint(equalTo: overlay.safeAreaLayoutGuide.topAnchor, constant: y),
                piece.widthAnchor.constraint(equalToConstant: CGFloat.random(in: 5...10)),
                piece.heightAnchor.constraint(equalToConstant: CGFloat.random(in: 5...12))
            ])
            piece.transform = CGAffineTransform(rotationAngle: CGFloat.random(in: -0.8...0.8))
            piece.alpha = 0
            UIView.animate(withDuration: 0.22, delay: Double(index) * 0.018, options: [.curveEaseOut]) {
                piece.alpha = 1
                piece.transform = piece.transform.translatedBy(x: 0, y: CGFloat.random(in: -18...28))
            }
        }
    }

    private func createPrizeItem() -> prismPetalItem {
        let source = store.inspirationItems.randomElement() ?? prismPetalItem(image: "zedDigitalEymakeupArtistryBoxMakeupExchang.png")
        let nextId = (store.inspirationItems.map(\.id).max() ?? 0) + 1
        let prize = prismPetalItem(
            id: nextId,
            image: source.image.isEmpty ? "zedDigitalEymakeupArtistryBoxMakeupExchang.png" : source.image,
            owner: store.activeUserIndex,
            time: Date(),
            marks: [store.activeUserIndex],
            state: 1
        )
        var items = store.inspirationItems
        items.insert(prize, at: 0)
        store.inspirationItems = items

        var users = store.localUsers
        if let index = users.firstIndex(where: { $0.microbladeEffect == store.activeUserIndex }),
           !users[index].created.contains(nextId) {
            users[index].created.append(nextId)
            store.localUsers = users
        }
        return prize
    }

    private func hasEnoughGems() -> Bool {
        (activeUser()?.soapBrows ?? 0) >= gemCost
    }

    private func consumeGems() -> Bool {
        var users = store.localUsers
        guard let index = users.firstIndex(where: { $0.microbladeEffect == store.activeUserIndex }),
              users[index].soapBrows >= gemCost else {
            return false
        }
        users[index].soapBrows -= gemCost
        store.localUsers = users
        return true
    }

    @objc private func confirmFreeOpen() {
        closeFlowOverlay()
        startOpeningFlow(needsGemCost: false)
    }

    @objc private func confirmGemOpen() {
        closeFlowOverlay()
        startOpeningFlow(needsGemCost: true)
    }

    @objc private func openRechargePage() {
        closeFlowOverlay()
        navigationController?.pushViewController(cinderCoinWalletViewController(), animated: true)
    }

    @objc private func openPrizeDetail() {
        guard let latestPrize else { return }
        closeFlowOverlay()
        crystalPathHomeRouter.showImageDetail(from: self, item: latestPrize)
    }

    @objc private func closeFlowOverlay() {
        flowOverlay?.removeFromSuperview()
        flowOverlay = nil
    }
}

final class lilacCanvasCreatorViewController: onyxFlowBaseViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private let promptField = UITextView()
    private let heroImageView = UIImageView(image: auroraLoginAsset.image("zedDigitalEyeyeMakeupInCustomizationHub.png"))
    private var selectedOccasion = 0
    private var occasionButtons: [UIButton] = []
    private var occasionIndicators: [UILabel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let canvas = makeDesignCanvas(minHeight: 812)
        addAtmosphereBackground(to: canvas)
        addTopButton(to: canvas, systemName: "chevron.left", leading: 17, background: UIColor.white.withAlphaComponent(0.28), tint: .white, selector: #selector(goBack))
        addDesignTitle(crystalPathHomeCopy.customTitle, to: canvas, top: 53, color: .white, size: 14)

        heroImageView.contentMode = .scaleAspectFill
        heroImageView.clipsToBounds = true
        canvas.addSubview(heroImageView)
        heroImageView.translatesAutoresizingMaskIntoConstraints = false

        let panel = UIView()
        panel.backgroundColor = UIColor.black.withAlphaComponent(0.88)
        panel.layer.cornerRadius = 34
        panel.layer.borderColor = auroraLoginPalette.yellow.cgColor
        panel.layer.borderWidth = 1
        canvas.addSubview(panel)
        panel.translatesAutoresizingMaskIntoConstraints = false

        let intro = makePlainLabel("I'm Eyelook AI, crafting unique eye makeup ideas to match every mood and occasion.", size: 17, color: auroraLoginPalette.yellow, weight: .bold)
        intro.textAlignment = .left
        intro.numberOfLines = 0
        panel.addSubview(intro)
        intro.translatesAutoresizingMaskIntoConstraints = false

        let row = makeOccasionRow()
        panel.addSubview(row)
        row.translatesAutoresizingMaskIntoConstraints = false

        let indicators = makeOccasionIndicators()
        panel.addSubview(indicators)
        indicators.translatesAutoresizingMaskIntoConstraints = false

        configurePromptPlaceholder()
        promptField.delegate = self
        promptField.font = auroraLoginFont.peace(13, weight: .bold)
        promptField.backgroundColor = UIColor(white: 0.11, alpha: 1.0)
        promptField.layer.cornerRadius = 22
        promptField.layer.borderWidth = 1
        promptField.layer.borderColor = UIColor.white.withAlphaComponent(0.18).cgColor
        promptField.textContainerInset = UIEdgeInsets(top: 18, left: 15, bottom: 14, right: 15)
        panel.addSubview(promptField)
        promptField.translatesAutoresizingMaskIntoConstraints = false

        let open = makeYellowButton(pearlGazeText.visible.shimmerFinish)
        open.layer.cornerRadius = 24
        open.titleLabel?.font = auroraLoginFont.peace(17, weight: .bold)
        open.addTarget(self, action: #selector(generateLocalLook), for: .touchUpInside)
        canvas.addSubview(open)
        open.translatesAutoresizingMaskIntoConstraints = false

        let coin = makeCostBadge()
        canvas.addSubview(coin)
        coin.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            heroImageView.centerXAnchor.constraint(equalTo: canvas.centerXAnchor),
            heroImageView.topAnchor.constraint(equalTo: canvas.topAnchor, constant: 88),
            heroImageView.widthAnchor.constraint(equalToConstant: 258),
            heroImageView.heightAnchor.constraint(equalToConstant: 230),
            panel.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: 13),
            panel.trailingAnchor.constraint(equalTo: canvas.trailingAnchor, constant: -13),
            panel.topAnchor.constraint(equalTo: canvas.topAnchor, constant: 294),
            panel.heightAnchor.constraint(equalToConstant: 474),
            intro.leadingAnchor.constraint(equalTo: panel.leadingAnchor, constant: 20),
            intro.trailingAnchor.constraint(equalTo: panel.trailingAnchor, constant: -20),
            intro.topAnchor.constraint(equalTo: panel.topAnchor, constant: 22),
            row.leadingAnchor.constraint(equalTo: panel.leadingAnchor, constant: 13),
            row.trailingAnchor.constraint(equalTo: panel.trailingAnchor, constant: -13),
            row.topAnchor.constraint(equalTo: intro.bottomAnchor, constant: 18),
            row.heightAnchor.constraint(equalToConstant: 112),
            indicators.centerXAnchor.constraint(equalTo: panel.centerXAnchor),
            indicators.topAnchor.constraint(equalTo: row.bottomAnchor, constant: 12),
            indicators.heightAnchor.constraint(equalToConstant: 22),
            promptField.leadingAnchor.constraint(equalTo: panel.leadingAnchor, constant: 16),
            promptField.trailingAnchor.constraint(equalTo: panel.trailingAnchor, constant: -16),
            promptField.topAnchor.constraint(equalTo: indicators.bottomAnchor, constant: 14),
            promptField.heightAnchor.constraint(equalToConstant: 112),
            open.centerXAnchor.constraint(equalTo: canvas.centerXAnchor),
            open.topAnchor.constraint(equalTo: panel.bottomAnchor, constant: -34),
            open.widthAnchor.constraint(equalToConstant: 136),
            open.heightAnchor.constraint(equalToConstant: 50),
            coin.trailingAnchor.constraint(equalTo: open.trailingAnchor, constant: 20),
            coin.topAnchor.constraint(equalTo: open.topAnchor, constant: -12),
            coin.widthAnchor.constraint(equalToConstant: 58),
            coin.heightAnchor.constraint(equalToConstant: 24)
        ])
        refreshOccasionButtons()
    }

    @objc private func generateLocalLook() {
        
        
        
        let raw = promptText()
        guard !raw.isEmpty else {
            auroraShowToast(meadowMuseProfileText.pleaseEnter)
            return
        }
//        
//        let actuser =  velvetAuraStore.shared.localUsers.first { $0.id == store.activeUserIndex }
        if activeUser()?.soapBrows ?? 0 < 200 {
            
            
            navigationController?.pushViewController(cinderCoinWalletViewController(), animated: true)
            
            auroraShowToast("Insufficient Balance!")
            return
        }
        
        var users = store.localUsers
                
        guard let index = users.firstIndex(where: { $0.microbladeEffect == store.activeUserIndex }) else {
            auroraShowToast(petalTrailCompleteText.charcoalGray)
            return
        }
        users[index].soapBrows -= 200
        store.localUsers = users
       

        
        
        
        
        auroraShowToast(crystalPathHomeCopy.generating)
        auroraShowLoadingThenFinish { [weak self] in
            guard let self else { return }
            var items = self.store.inspirationItems
            let image = self.store.imageNames.randomElement() ?? "zedDigitalEyvirtualMakeupEyelooksselect.jpeg"
            let id = (items.map(\.id).max() ?? 0) + 1
            let item = prismPetalItem(id: id, image: image, owner: self.store.activeUserIndex, time: Date(), marks: [self.store.activeUserIndex], state: 0)
            items.insert(item, at: 0)
            self.store.inspirationItems = items
            self.attachCreatedItem(id)
            self.auroraShowToast(crystalPathHomeCopy.generated)
            self.navigationController?.pushViewController(lilacCanvasResultViewController(item: item), animated: true)
        }
    }

    @objc private func chooseOccasion(_ sender: UIButton) {
        selectedOccasion = sender.tag
        refreshOccasionButtons()
    }

    @objc private func openImagePermission() {
        presentMediaSourceSheet(delegate: self)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
            heroImageView.image = image
        }
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    private func makeOccasionRow() -> UIView {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false

        let row = UIStackView()
        row.axis = .horizontal
        row.spacing = 8
        scroll.addSubview(row)
        row.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            row.leadingAnchor.constraint(equalTo: scroll.contentLayoutGuide.leadingAnchor, constant: 0),
            row.trailingAnchor.constraint(equalTo: scroll.contentLayoutGuide.trailingAnchor, constant: 0),
            row.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor),
            row.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor),
            row.heightAnchor.constraint(equalTo: scroll.frameLayoutGuide.heightAnchor)
        ])

        let cards = [
            "zedDigitalEyaiDrivenMakeupvirtualMakeupArtist.png",
            "zedDigitalEyeyeMakeupMasterpiecemakeupAIInspo.png",
            "zedDigitalEymakeupBlindBoxAIeyelook.png",
            "zedDigitalEyreativeBeautyFeedeyelookTransformation.png"
        ]
        cards.enumerated().forEach { index, name in
            let button = UIButton(type: .custom)
            button.tag = index
            button.setImage(auroraLoginAsset.image(name), for: .normal)
            button.imageView?.contentMode = .scaleAspectFill
            button.contentHorizontalAlignment = .fill
            button.contentVerticalAlignment = .fill
            button.clipsToBounds = true
            button.layer.cornerRadius = 15
            button.layer.borderWidth = 2
            button.addTarget(self, action: #selector(chooseOccasion(_:)), for: .touchUpInside)
            row.addArrangedSubview(button)
            occasionButtons.append(button)
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 76),
                button.heightAnchor.constraint(equalToConstant: 112)
            ])
        }
        return scroll
    }

    private func makeOccasionIndicators() -> UIStackView {
        let row = UIStackView()
        row.axis = .horizontal
        row.alignment = .center
        row.spacing = 20
        (0..<4).forEach { index in
            let indicator = UILabel()
            indicator.tag = index
            indicator.textAlignment = .center
            indicator.font = .systemFont(ofSize: 10, weight: .heavy)
            indicator.layer.cornerRadius = 10
            indicator.layer.masksToBounds = true
            row.addArrangedSubview(indicator)
            occasionIndicators.append(indicator)
            NSLayoutConstraint.activate([
                indicator.widthAnchor.constraint(equalToConstant: 20),
                indicator.heightAnchor.constraint(equalToConstant: 20)
            ])
        }
        return row
    }

    private func makeCostBadge() -> UIView {
        let badge = UIView()
        badge.backgroundColor = UIColor(red: 1.0, green: 0.286, blue: 0.612, alpha: 1.0)
        badge.layer.cornerRadius = 12
        badge.layer.masksToBounds = true

        let value = makePlainLabel(meadowMuseProfileText.counter, size: 11, color: .white, weight: .bold)
        value.textAlignment = .right
        badge.addSubview(value)
        value.translatesAutoresizingMaskIntoConstraints = false

        let coin = UIImageView(image: auroraLoginAsset.image("zedDigitalEymakeupDiscoveryMakeupGenerator.png"))
        coin.contentMode = .scaleAspectFit
        badge.addSubview(coin)
        coin.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            value.leadingAnchor.constraint(equalTo: badge.leadingAnchor, constant: 8),
            value.centerYAnchor.constraint(equalTo: badge.centerYAnchor),
            coin.leadingAnchor.constraint(equalTo: value.trailingAnchor, constant: 4),
            coin.trailingAnchor.constraint(equalTo: badge.trailingAnchor, constant: -5),
            coin.centerYAnchor.constraint(equalTo: badge.centerYAnchor),
            coin.widthAnchor.constraint(equalToConstant: 16),
            coin.heightAnchor.constraint(equalToConstant: 16)
        ])
        return badge
    }

    private func refreshOccasionButtons() {
        occasionButtons.enumerated().forEach { index, button in
            let selected = index == selectedOccasion
            button.layer.borderColor = (selected ? auroraLoginPalette.yellow : UIColor.white).cgColor
            button.alpha = selected ? 1 : 0.78
        }
        occasionIndicators.enumerated().forEach { index, indicator in
            let selected = index == selectedOccasion
            indicator.text = selected ? "✓" : ""
            indicator.backgroundColor = selected ? auroraLoginPalette.yellow : UIColor(white: 0.08, alpha: 1.0)
            indicator.textColor = selected ? .black : .clear
        }
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == meadowMuseProfileText.metallicThread {
            textView.text = ""
            textView.textColor = .white
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            configurePromptPlaceholder()
        }
    }

    private func configurePromptPlaceholder() {
        promptField.text = meadowMuseProfileText.metallicThread
        promptField.textColor = UIColor.white.withAlphaComponent(0.42)
    }

    private func promptText() -> String {
        let value = promptField.text.trimmingCharacters(in: .whitespacesAndNewlines)
        return value == meadowMuseProfileText.metallicThread ? "" : value
    }

    private func attachCreatedItem(_ id: Int) {
        var users = store.localUsers
        guard let index = users.firstIndex(where: { $0.microbladeEffect == store.activeUserIndex }) else { return }
        if !users[index].created.contains(id) {
            users[index].created.append(id)
            store.localUsers = users
        }
    }
}

final class lilacCanvasResultViewController: onyxFlowBaseViewController {
    private let item: prismPetalItem

    init(item: prismPetalItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let canvas = makeDesignCanvas(minHeight: 812)
        addAtmosphereBackground(to: canvas)
        addTopButton(to: canvas, systemName: "chevron.left", leading: 17, background: UIColor.white.withAlphaComponent(0.28), tint: .white, selector: #selector(goBack))
        addTopButton(to: canvas, systemName: "exclamationmark.triangle", trailing: 16, background: UIColor.white.withAlphaComponent(0.08), tint: UIColor.white.withAlphaComponent(0.8), selector: #selector(openReport))

        let imageFrame = UIView()
        imageFrame.backgroundColor = .clear
        imageFrame.layer.cornerRadius = 17
        imageFrame.layer.borderWidth = 2
        imageFrame.layer.borderColor = auroraLoginPalette.yellow.cgColor
        imageFrame.clipsToBounds = true
        canvas.addSubview(imageFrame)
        imageFrame.translatesAutoresizingMaskIntoConstraints = false

        let image = UIImageView(image: auroraLoginAsset.image(item.image))
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        imageFrame.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false

        let save = makeYellowButton(pearlGazeText.visible.saveToInspiraBox)
        save.layer.cornerRadius = 24
        save.titleLabel?.font = auroraLoginFont.peace(17, weight: .bold)
        save.addTarget(self, action: #selector(saveLook), for: .touchUpInside)
        canvas.addSubview(save)
        save.translatesAutoresizingMaskIntoConstraints = false

        let ratePrompt = UIButton(type: .system)
        ratePrompt.setAttributedTitle(ratePromptTitle(), for: .normal)
        ratePrompt.titleLabel?.numberOfLines = 1
        ratePrompt.addTarget(self, action: #selector(openFeedback), for: .touchUpInside)
        canvas.addSubview(ratePrompt)
        ratePrompt.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageFrame.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: 14),
            imageFrame.trailingAnchor.constraint(equalTo: canvas.trailingAnchor, constant: -14),
            imageFrame.topAnchor.constraint(equalTo: canvas.topAnchor, constant: 124),
            imageFrame.heightAnchor.constraint(equalToConstant: 480),
            image.topAnchor.constraint(equalTo: imageFrame.topAnchor),
            image.leadingAnchor.constraint(equalTo: imageFrame.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: imageFrame.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: imageFrame.bottomAnchor),
            save.centerXAnchor.constraint(equalTo: canvas.centerXAnchor),
            save.topAnchor.constraint(equalTo: imageFrame.bottomAnchor, constant: 55),
            save.widthAnchor.constraint(equalToConstant: 252),
            save.heightAnchor.constraint(equalToConstant: 52),
            ratePrompt.centerXAnchor.constraint(equalTo: canvas.centerXAnchor),
            ratePrompt.topAnchor.constraint(equalTo: save.bottomAnchor, constant: 13),
            ratePrompt.leadingAnchor.constraint(greaterThanOrEqualTo: canvas.leadingAnchor, constant: 18),
            ratePrompt.trailingAnchor.constraint(lessThanOrEqualTo: canvas.trailingAnchor, constant: -18)
        ])
    }

    @objc private func saveLook() {
        var users = store.localUsers
        if let index = users.firstIndex(where: { $0.microbladeEffect == store.activeUserIndex }),
           !users[index].created.contains(item.id) {
            users[index].created.append(item.id)
            store.localUsers = users
        }
        auroraShowToast(meadowMuseProfileText.cherryBlossom)
    }

    @objc private func openFeedback() {
        navigationController?.pushViewController(sageReplyFeedbackViewController(), animated: true)
    }

    @objc private func openReport() {
        navigationController?.pushViewController(coralReportViewController(), animated: true)
    }

    private func ratePromptTitle() -> NSAttributedString {
        let full = "\(meadowMuseProfileText.orchidBloom) \(meadowMuseProfileText.rateHint)"
        let text = NSMutableAttributedString(
            string: full,
            attributes: [
                .font: auroraLoginFont.peace(11, weight: .bold),
                .foregroundColor: UIColor.white
            ]
        )
        let range = (full as NSString).range(of: meadowMuseProfileText.rateHint)
        text.addAttributes([
            .foregroundColor: auroraLoginPalette.lime,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ], range: range)
        return text
    }
}

final class orchidWhisperListViewController: onyxFlowBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let canvas = makeDesignCanvas()
        addDarkBloomBackground(to: canvas)
        addTopButton(to: canvas, imageName: "lanhuCommonBackCircle.png", leading: 12, background: .clear, selector: #selector(goBack))
        addDesignTitle(petalTrailCompleteText.dramaticFlare, to: canvas, top: 53, color: .white, size: 24)

        let threads = visibleThreads()
        if threads.isEmpty {
            addEmptyPlaceholder(to: canvas)
        } else {
            let grid = UIStackView()
            grid.axis = .vertical
            grid.spacing = 24
            canvas.addSubview(grid)
            grid.translatesAutoresizingMaskIntoConstraints = false

            for chunkStart in stride(from: 0, to: threads.count, by: 2) {
                let row = UIStackView()
                row.axis = .horizontal
                row.spacing = 24
                row.alignment = .top
                grid.addArrangedSubview(row)
                let chunk = threads[chunkStart..<min(chunkStart + 2, threads.count)]
                chunk.forEach { thread in
                    let card = messageCard(thread)
                    row.addArrangedSubview(card)
                    card.widthAnchor.constraint(equalToConstant: 165).isActive = true
                    card.heightAnchor.constraint(equalToConstant: 182).isActive = true
                }
                if chunk.count == 1 {
                    let spacer = UIView()
                    row.addArrangedSubview(spacer)
                    spacer.widthAnchor.constraint(equalToConstant: 165).isActive = true
                }
            }

            NSLayoutConstraint.activate([
                grid.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: 16),
                grid.trailingAnchor.constraint(lessThanOrEqualTo: canvas.trailingAnchor, constant: -16),
                grid.topAnchor.constraint(equalTo: canvas.topAnchor, constant: 104)
            ])
        }

        if let indicator = auroraLoginAsset.image("lanhuHomeIndicator.png") {
            let home = UIImageView(image: indicator)
            home.contentMode = .scaleToFill
            canvas.addSubview(home)
            home.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                home.leadingAnchor.constraint(equalTo: canvas.leadingAnchor),
                home.trailingAnchor.constraint(equalTo: canvas.trailingAnchor),
                home.bottomAnchor.constraint(equalTo: canvas.bottomAnchor),
                home.heightAnchor.constraint(equalToConstant: 34)
            ])
        }
    }

    @objc private func openThread(_ sender: UIButton) {
        navigationController?.pushViewController(roseQuartzThreadViewController(room: sender.tag), animated: true)
    }

    private func messageCard(_ thread: satinEchoThread) -> UIButton {
        let room = thread.seasonalPalette
        let name = threadTitle(thread)
        let preview = latestPreview(for: room)
        let avatar = threadAvatar(thread)
        let unread = thread.unread
            let card = UIButton(type: .custom)
            card.tag = room
            card.backgroundColor = .white
            card.layer.cornerRadius = 24
            card.clipsToBounds = true
            card.addTarget(self, action: #selector(openThread(_:)), for: .touchUpInside)

            let avatarView = UIImageView(image: auroraLoginAsset.image(avatar))
            avatarView.contentMode = .scaleAspectFill
            avatarView.clipsToBounds = true
            avatarView.layer.cornerRadius = 40
            avatarView.isUserInteractionEnabled = false
            card.addSubview(avatarView)
            avatarView.translatesAutoresizingMaskIntoConstraints = false

            let title = makePlainLabel(name, size: 16, color: .black, weight: .bold)
            title.isUserInteractionEnabled = false
            card.addSubview(title)
            title.translatesAutoresizingMaskIntoConstraints = false

            let subtitle = makePlainLabel(preview, size: 13, color: UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1), weight: .bold)
            subtitle.numberOfLines = 2
            subtitle.isUserInteractionEnabled = false
            card.addSubview(subtitle)
            subtitle.translatesAutoresizingMaskIntoConstraints = false

            let icon = UIImageView(image: auroraLoginAsset.image("lanhuChatBubbleIcon.png"))
            icon.contentMode = .scaleAspectFit
            icon.isUserInteractionEnabled = false
            card.addSubview(icon)
            icon.translatesAutoresizingMaskIntoConstraints = false

            let badge = petalInsetLabel()
            badge.text = unread > 0 ? "\(unread)" : ""
            badge.textAlignment = .center
            badge.textColor = .white
            badge.font = auroraLoginFont.peace(11, weight: .bold)
            badge.backgroundColor = unread > 0 ? UIColor(red: 1, green: 0.14, blue: 0.14, alpha: 1) : .clear
            badge.insets = UIEdgeInsets(top: 2, left: 7, bottom: 2, right: 7)
            badge.layer.cornerRadius = 10
            badge.layer.masksToBounds = true
            badge.isUserInteractionEnabled = false
            card.addSubview(badge)
            badge.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                avatarView.topAnchor.constraint(equalTo: card.topAnchor, constant: 12),
                avatarView.centerXAnchor.constraint(equalTo: card.centerXAnchor),
                avatarView.widthAnchor.constraint(equalToConstant: 80),
                avatarView.heightAnchor.constraint(equalToConstant: 80),
                title.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 12),
                title.topAnchor.constraint(equalTo: card.topAnchor, constant: 94),
                title.trailingAnchor.constraint(lessThanOrEqualTo: icon.leadingAnchor, constant: -12),
                subtitle.leadingAnchor.constraint(equalTo: title.leadingAnchor),
                subtitle.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -12),
                subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 12),
                icon.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -12),
                icon.topAnchor.constraint(equalTo: card.topAnchor, constant: 95),
                icon.widthAnchor.constraint(equalToConstant: 36),
                icon.heightAnchor.constraint(equalToConstant: 36),
                badge.centerXAnchor.constraint(equalTo: avatarView.centerXAnchor, constant: 22),
                badge.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor, constant: 26),
                badge.widthAnchor.constraint(greaterThanOrEqualToConstant: 27),
                badge.heightAnchor.constraint(greaterThanOrEqualToConstant: 22)
            ])
            return card
    }

    private func visibleThreads() -> [satinEchoThread] {
        store.threadItems.filter { thread in
            !(thread.seasonalPalette == 0 && thread.title == "图图图与题意体育")
                && !store.isBlocked(userId: thread.owner)
                && !thread.members.contains(where: { store.isBlocked(userId: $0) })
                && !store.isBlocked(userId: thread.seasonalPalette)
        }
    }

    private func addEmptyPlaceholder(to canvas: UIView) {
        let label = makePlainLabel(crystalPathHomeCopy.noMessages, size: 22, color: UIColor.white.withAlphaComponent(0.72), weight: .bold)
        label.textAlignment = .center
        canvas.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: canvas.centerXAnchor),
            label.topAnchor.constraint(equalTo: canvas.topAnchor, constant: 236),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: canvas.leadingAnchor, constant: 24),
            label.trailingAnchor.constraint(lessThanOrEqualTo: canvas.trailingAnchor, constant: -24)
        ])
    }

    private func latestPreview(for room: Int) -> String {
        store.roomItems.reversed().first { note in
            note.room == room && !(note.room == 0 && note.text == "Hello World")
        }?.text ?? crystalPathHomeCopy.noMessages
    }

    private func threadTitle(_ thread: satinEchoThread) -> String {
        if !thread.title.isEmpty { return thread.title }
        if let user = store.localUsers.first(where: { $0.microbladeEffect == thread.owner }) {
            return store.displayName(for: user)
        }
        switch thread.seasonalPalette {
        case 2: return "William"
        case 3: return "Daniel"
        default: return petalTrailCompleteText.baldwin
        }
    }

    private func threadAvatar(_ thread: satinEchoThread) -> String {
        if let user = store.localUsers.first(where: { $0.microbladeEffect == thread.owner }) {
            return store.avatarName(for: user)
        }
        switch thread.seasonalPalette {
        case 2: return "lanhuChatWilliamAvatar.png"
        case 3: return "lanhuChatDanielAvatar.png"
        default: return "lanhuChatBaldwinAvatar.png"
        }
    }

    private func addDarkBloomBackground(to canvas: UIView) {
        let background = UIImageView(image: auroraLoginAsset.image("zedDigitalEyvirtualBeautyCommunityLooks.png"))
        background.contentMode = .scaleToFill
        background.clipsToBounds = true
        background.isUserInteractionEnabled = false
        canvas.addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: canvas.topAnchor),
            background.leadingAnchor.constraint(equalTo: canvas.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: canvas.trailingAnchor),
            background.heightAnchor.constraint(equalToConstant: 812)
        ])
    }
}

final class roseQuartzThreadViewController: onyxFlowBaseViewController {
    private let room: Int
    private let input = UITextField()
    private let messagesStack = UIStackView()
    private weak var emptyPlaceholderContainer: UIView?

    init(room: Int) {
        self.room = room
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let canvas = makeDesignCanvas(minHeight: 812)
        canvas.backgroundColor = .black
        addTopButton(to: canvas, imageName: "lanhuCommonBackCircle.png", leading: 12, background: .clear, selector: #selector(goBack))
        addDesignTitle(threadName, to: canvas, top: 53, color: .white, size: 24)

        addTopButton(to: canvas, imageName: "lanhuMessageVideoCircle.png", trailing: 56, background: .clear, selector: #selector(openVideoCall))
        addTopButton(to: canvas, imageName: "lanhuCommonReportCircle.png", trailing: 12, background: .clear, selector: #selector(openReport))

        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.backgroundColor = .clear
        canvas.addSubview(scroll)
        scroll.translatesAutoresizingMaskIntoConstraints = false

        messagesStack.axis = .vertical
        messagesStack.spacing = 40
        scroll.addSubview(messagesStack)
        messagesStack.translatesAutoresizingMaskIntoConstraints = false
        buildMessages()

        input.placeholder = crystalPathHomeCopy.commentPlaceholder
        input.attributedPlaceholder = NSAttributedString(string: crystalPathHomeCopy.commentPlaceholder, attributes: [.foregroundColor: UIColor.black.withAlphaComponent(0.35)])
        input.textColor = .black
        input.font = auroraLoginFont.peace(14, weight: .bold)
        input.backgroundColor = .clear
        input.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 1))
        input.leftViewMode = .always
        view.addSubview(input)
        input.translatesAutoresizingMaskIntoConstraints = false

        let inputBar = UIImageView(image: auroraLoginAsset.image("lanhuThreadInputBar.png"))
        inputBar.contentMode = .scaleToFill
        inputBar.isUserInteractionEnabled = false
        view.insertSubview(inputBar, belowSubview: input)
        inputBar.translatesAutoresizingMaskIntoConstraints = false

        let send = UIButton(type: .custom)
        send.backgroundColor = .clear
        send.addTarget(self, action: #selector(sendNote), for: .touchUpInside)
        view.addSubview(send)
        send.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scroll.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: 20),
            scroll.trailingAnchor.constraint(equalTo: canvas.trailingAnchor, constant: -20),
            scroll.topAnchor.constraint(equalTo: canvas.topAnchor, constant: 145),
            scroll.bottomAnchor.constraint(equalTo: inputBar.topAnchor, constant: -18),
            messagesStack.leadingAnchor.constraint(equalTo: scroll.contentLayoutGuide.leadingAnchor),
            messagesStack.trailingAnchor.constraint(equalTo: scroll.contentLayoutGuide.trailingAnchor),
            messagesStack.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor),
            messagesStack.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor),
            messagesStack.widthAnchor.constraint(equalTo: scroll.frameLayoutGuide.widthAnchor),
            inputBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            inputBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            inputBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            inputBar.heightAnchor.constraint(equalToConstant: 100),
            input.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            input.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -35),
            input.trailingAnchor.constraint(equalTo: send.leadingAnchor, constant: -6),
            input.heightAnchor.constraint(equalToConstant: 58),
            send.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -23),
            send.centerYAnchor.constraint(equalTo: input.centerYAnchor),
            send.widthAnchor.constraint(equalToConstant: 56),
            send.heightAnchor.constraint(equalToConstant: 56)
        ])
    }

    @objc private func sendNote() {
        guard ensureCompanionGateUnlocked(for: room) else { return }
        let text = input.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard !text.isEmpty else { return }
        var notes = store.roomItems
        notes.append(twinkleCanvasNote(room: room, author: store.activeUserIndex, text: text))
        store.roomItems = notes
        removeEmptyPlaceholder()
        upsertThread(latest: text)
        messagesStack.addArrangedSubview(messageRow(text: text, inbound: false, avatar: store.avatarName(for: activeUser())))
        input.text = ""
    }

    @objc private func openVideoCall() {
        guard ensureCompanionGateUnlocked(for: room) else { return }
        navigationController?.pushViewController(onyxCallShellViewController(peerUserId: room), animated: true)
    }

    @objc private func openReport() {
        presentSafetyActionSheet(userId: room) { [weak self] in
            self?.removeThreadData()
            self?.navigationController?.popViewController(animated: true)
        }
    }

    private var threadName: String {
        if let thread = store.threadItems.first(where: { $0.seasonalPalette == room }), !thread.title.isEmpty {
            return thread.title
        }
        if let user = store.localUsers.first(where: { $0.microbladeEffect == room }) {
            return store.displayName(for: user)
        }
        switch room {
        case 2: return "William"
        case 3: return "Daniel"
        default: return petalTrailCompleteText.baldwin
        }
    }

    private func buildMessages() {
        let notes = store.roomItems.filter { $0.room == room && !($0.room == 0 && $0.text == "Hello World") }
        if notes.isEmpty {
            addEmptyThreadPlaceholder()
            return
        }
        notes.forEach { note in
            let inbound = note.author != store.activeUserIndex
            let avatar = inbound ? threadAvatar : store.avatarName(for: activeUser())
            messagesStack.addArrangedSubview(messageRow(text: note.text, inbound: inbound, avatar: avatar))
        }
    }

    private func messageRow(text: String, inbound: Bool, avatar: String) -> UIView {
        let row = UIView()
        let avatarView = UIImageView(image: auroraLoginAsset.image(avatar))
        avatarView.contentMode = .scaleAspectFill
        avatarView.clipsToBounds = true
        avatarView.layer.cornerRadius = 18
        avatarView.layer.borderWidth = 0
        row.addSubview(avatarView)
        avatarView.translatesAutoresizingMaskIntoConstraints = false

        let bubble = petalInsetLabel()
        bubble.text = text
        bubble.numberOfLines = 0
        bubble.textColor = .black
        bubble.backgroundColor = inbound ? .white : auroraLoginPalette.yellow
        bubble.font = auroraLoginFont.peace(14, weight: .bold)
        bubble.insets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        bubble.layer.cornerRadius = 25
        bubble.layer.masksToBounds = true
        row.addSubview(bubble)
        bubble.translatesAutoresizingMaskIntoConstraints = false

        if inbound {
            NSLayoutConstraint.activate([
                row.heightAnchor.constraint(greaterThanOrEqualToConstant: 44),
                avatarView.leadingAnchor.constraint(equalTo: row.leadingAnchor, constant: 0),
                avatarView.topAnchor.constraint(equalTo: row.topAnchor, constant: 1),
                avatarView.widthAnchor.constraint(equalToConstant: 36),
                avatarView.heightAnchor.constraint(equalToConstant: 36),
                avatarView.bottomAnchor.constraint(lessThanOrEqualTo: row.bottomAnchor),
                bubble.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 12),
                bubble.topAnchor.constraint(equalTo: row.topAnchor),
                bubble.bottomAnchor.constraint(equalTo: row.bottomAnchor),
                bubble.widthAnchor.constraint(lessThanOrEqualToConstant: 209)
            ])
        } else {
            NSLayoutConstraint.activate([
                row.heightAnchor.constraint(greaterThanOrEqualToConstant: 44),
                avatarView.trailingAnchor.constraint(equalTo: row.trailingAnchor),
                avatarView.topAnchor.constraint(equalTo: row.topAnchor, constant: 1),
                avatarView.widthAnchor.constraint(equalToConstant: 36),
                avatarView.heightAnchor.constraint(equalToConstant: 36),
                avatarView.bottomAnchor.constraint(lessThanOrEqualTo: row.bottomAnchor),
                bubble.trailingAnchor.constraint(equalTo: avatarView.leadingAnchor, constant: -12),
                bubble.leadingAnchor.constraint(greaterThanOrEqualTo: row.leadingAnchor, constant: 57),
                bubble.topAnchor.constraint(equalTo: row.topAnchor),
                bubble.bottomAnchor.constraint(equalTo: row.bottomAnchor),
                bubble.widthAnchor.constraint(lessThanOrEqualToConstant: 230)
            ])
        }
        return row
    }

    private var threadAvatar: String {
        switch room {
        case 2: return "lanhuChatWilliamAvatar.png"
        case 3: return "lanhuChatDanielAvatar.png"
        default:
            if let user = store.localUsers.first(where: { $0.microbladeEffect == room }) {
                return store.avatarName(for: user)
            }
            return "lanhuThreadBaldwinAvatar.png"
        }
    }

    private func addEmptyThreadPlaceholder() {
        let container = UIView()
        container.heightAnchor.constraint(equalToConstant: 280).isActive = true
        let label = makePlainLabel(crystalPathHomeCopy.noMessages, size: 20, color: UIColor.white.withAlphaComponent(0.72), weight: .bold)
        label.textAlignment = .center
        container.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: container.leadingAnchor, constant: 18),
            label.trailingAnchor.constraint(lessThanOrEqualTo: container.trailingAnchor, constant: -18)
        ])
        messagesStack.addArrangedSubview(container)
        emptyPlaceholderContainer = container
    }

    private func removeEmptyPlaceholder() {
        guard let container = emptyPlaceholderContainer else { return }
        messagesStack.removeArrangedSubview(container)
        container.removeFromSuperview()
        emptyPlaceholderContainer = nil
    }

    private func upsertThread(latest: String) {
        var threads = store.threadItems.filter { !($0.seasonalPalette == 0 && $0.title == "图图图与题意体育") }
        let owner = room == store.activeUserIndex ? store.activeUserIndex : room
        if let index = threads.firstIndex(where: { $0.seasonalPalette == room }) {
            threads[index].title = threadName
            threads[index].owner = owner
            threads[index].members = Array(Set([store.activeUserIndex, owner]))
            threads[index].unread = 0
        } else {
            threads.insert(satinEchoThread(id: room, owner: owner, title: threadName, members: [store.activeUserIndex, owner], unread: 0), at: 0)
        }
        store.threadItems = threads
    }

    private func removeThreadData() {
        store.threadItems = store.threadItems.filter { thread in
            thread.seasonalPalette != room && thread.owner != room && !thread.members.contains(room)
        }
        store.roomItems = store.roomItems.filter { note in
            note.room != room && note.author != room
        }
    }
}

final class coralBloomGalleryViewController: onyxFlowBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let stack = makeScrollStack(title: crystalPathHomeCopy.galleryTitle)
        stack.addArrangedSubview(makeGrid(items: visibleItems(store.inspirationItems)))
    }
}

final class sunlitMuseMineViewController: onyxFlowBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = activeUser()
        let stack = makeScrollStack(title: crystalPathHomeCopy.mineTitle)
        let row = UIStackView()
        row.axis = .horizontal
        row.spacing = 14
        row.alignment = .center
        row.addArrangedSubview(makeAvatar(store.avatarName(for: user), size: 72))
        row.addArrangedSubview(paddedLabel(store.displayName(for: user)))
        stack.addArrangedSubview(row)
        stack.addArrangedSubview(paddedLabel("\(crystalPathHomeCopy.favoritesTitle): \(user?.saved.count ?? 0)"))
        let mine = visibleItems(store.inspirationItems).filter { $0.owner == store.activeUserIndex || (user?.created.contains($0.id) ?? false) }
        stack.addArrangedSubview(makeGrid(items: mine.isEmpty ? Array(visibleItems(store.inspirationItems).prefix(4)) : mine))
    }
}

extension onyxFlowBaseViewController {
    func makeAvatar(_ name: String, size: CGFloat) -> UIImageView {
        let cleanName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let imageName = cleanName.isEmpty ? "lanhuProfileAvatar.png" : cleanName
        let avatar = UIImageView(image: auroraLoginAsset.image(imageName) ?? auroraLoginAsset.image("lanhuProfileAvatar.png"))
        avatar.contentMode = .scaleAspectFill
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = size / 2
        avatar.layer.borderColor = auroraLoginPalette.yellow.cgColor
        avatar.layer.borderWidth = 2
        avatar.widthAnchor.constraint(equalToConstant: size).isActive = true
        avatar.heightAnchor.constraint(equalToConstant: size).isActive = true
        return avatar
    }

    func paddedLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.font = auroraLoginFont.peace(16)
        label.numberOfLines = 0
        label.backgroundColor = UIColor.white.withAlphaComponent(0.08)
        label.layer.cornerRadius = 16
        label.layer.masksToBounds = true
        label.heightAnchor.constraint(greaterThanOrEqualToConstant: 54).isActive = true
        return label
    }

    func makeGrid(items: [prismPetalItem]) -> UIStackView {
        let grid = UIStackView()
        grid.axis = .horizontal
        grid.alignment = .top
        grid.spacing = 10
        let left = UIStackView()
        let right = UIStackView()
        [left, right].forEach {
            $0.axis = .vertical
            $0.spacing = 10
            grid.addArrangedSubview($0)
            $0.widthAnchor.constraint(equalTo: grid.widthAnchor, multiplier: 0.5, constant: -5).isActive = true
        }
        if items.isEmpty {
            left.addArrangedSubview(paddedLabel(crystalPathHomeCopy.empty))
            return grid
        }
        for (index, item) in visibleItems(items).enumerated() {
            let button = UIButton(type: .custom)
            button.clipsToBounds = true
            button.layer.cornerRadius = 8
            button.setImage(auroraLoginAsset.image(item.image), for: .normal)
            button.imageView?.contentMode = .scaleAspectFill
            button.heightAnchor.constraint(equalToConstant: index % 2 == 0 ? 130 : 250).isActive = true
            button.tag = item.id
            button.addTarget(self, action: #selector(openGridItem(_:)), for: .touchUpInside)
            (index % 2 == 0 ? left : right).addArrangedSubview(button)
        }
        return grid
    }

    @objc private func openGridItem(_ sender: UIButton) {
        guard let item = store.inspirationItems.first(where: { $0.id == sender.tag }) else { return }
        navigationController?.pushViewController(violetGemLookDetailViewController(item: item), animated: true)
    }
}
