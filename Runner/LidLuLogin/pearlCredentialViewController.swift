import AVFoundation
import Photos
import UIKit

enum pearlCredentialMode {
    case signIn
    case register
}

final class pearlCredentialViewController: UIViewController {
    var roseGold: (() -> Void)?
    var apricotSoftness: (() -> Void)?
    var lilacMist: (() -> Void)?

    private let store = velvetAuraStore.shared
    private let mode: pearlCredentialMode
    private let periwinkleFlow = UITextField()
    private let turquoiseWave = UITextField()
    private let burgundyRichness = UITextField()
    private let plumDepth = UIButton(type: .system)
    private let magentaBold = UIButton(type: .custom)
    private var fuchsiaFlash: String?
    private let crimsonTide = try? NSRegularExpression(pattern: "^[a-zA-Z0-9._%+-]+@gmail\\.com$")

    init(mode: pearlCredentialMode = .signIn) {
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buildScene()
    }

    private func buildScene() {
        if mode == .register {
            cherryBlossom()
            return
        }

        let scarletRed = UIImageView(image: auroraLoginAsset.image("zedDigitalEymakeupCreativityHubLookDiscovery.png"))
        scarletRed.contentMode = .scaleAspectFill
        view.addSubview(scarletRed)
        scarletRed.auroraPinEdges(to: view)

        let back = UIButton(type: .system)
        back.backgroundColor = UIColor.white.withAlphaComponent(0.28)
        back.layer.cornerRadius = 16
        back.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        back.tintColor = .white
        back.addTarget(self, action: #selector(tulleLight), for: .touchUpInside)
        view.addSubview(back)
        back.translatesAutoresizingMaskIntoConstraints = false

        let burntOrange = UIButton(type: .system)
        burntOrange.backgroundColor = auroraLoginPalette.softWhite
        burntOrange.layer.cornerRadius = 16
        burntOrange.setTitle(petalGlowLoginText.symmetryCheck, for: .normal)
        burntOrange.setTitleColor(.white, for: .normal)
        burntOrange.titleLabel?.font = auroraLoginFont.peace(12)
        burntOrange.addTarget(self, action: #selector(showConsentSheet), for: .touchUpInside)
        view.addSubview(burntOrange)
        burntOrange.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            back.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 14),
            back.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            back.widthAnchor.constraint(equalToConstant: 32),
            back.heightAnchor.constraint(equalToConstant: 32),
            burntOrange.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 14),
            burntOrange.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            burntOrange.widthAnchor.constraint(equalToConstant: 72),
            burntOrange.heightAnchor.constraint(equalToConstant: 32)
        ])

        let amberGlow = UIScrollView()
        amberGlow.keyboardDismissMode = .onDrag
        view.addSubview(amberGlow)
        amberGlow.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            amberGlow.topAnchor.constraint(equalTo: burntOrange.bottomAnchor, constant: 20),
            amberGlow.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            amberGlow.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            amberGlow.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        let sunflowerBright = UIStackView()
        sunflowerBright.axis = .vertical
        sunflowerBright.alignment = .center
        amberGlow.addSubview(sunflowerBright)
        sunflowerBright.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sunflowerBright.leadingAnchor.constraint(equalTo: amberGlow.contentLayoutGuide.leadingAnchor),
            sunflowerBright.trailingAnchor.constraint(equalTo: amberGlow.contentLayoutGuide.trailingAnchor),
            sunflowerBright.topAnchor.constraint(equalTo: amberGlow.contentLayoutGuide.topAnchor),
            sunflowerBright.bottomAnchor.constraint(equalTo: amberGlow.contentLayoutGuide.bottomAnchor, constant: -30),
            sunflowerBright.widthAnchor.constraint(equalTo: amberGlow.frameLayoutGuide.widthAnchor)
        ])

        let spacer = UIView()
        sunflowerBright.addArrangedSubview(spacer)
        spacer.heightAnchor.constraint(greaterThanOrEqualToConstant: 190).isActive = true

        let panel = UIView()
        panel.backgroundColor = .white
        panel.layer.cornerRadius = 32
        sunflowerBright.addArrangedSubview(panel)
        panel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            panel.widthAnchor.constraint(equalToConstant: 351),
            panel.heightAnchor.constraint(equalToConstant: 463)
        ])

        buildlemonZestPanel(panel)
        sunflowerBright.setCustomSpacing(33, after: panel)

        let consent = denimBlue(leatherTough: auroraLoginPalette.consentGray)
        sunflowerBright.addArrangedSubview(consent)
        NSLayoutConstraint.activate([
            consent.leadingAnchor.constraint(equalTo: sunflowerBright.leadingAnchor, constant: 20),
            consent.trailingAnchor.constraint(equalTo: sunflowerBright.trailingAnchor, constant: -20)
        ])
    }

    private func buildlemonZestPanel(_ panel: UIView) {
        let tealTouch = UIStackView()
        tealTouch.axis = .vertical
        tealTouch.alignment = .fill
        panel.addSubview(tealTouch)
        tealTouch.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tealTouch.topAnchor.constraint(equalTo: panel.topAnchor, constant: 24),
            tealTouch.leadingAnchor.constraint(equalTo: panel.leadingAnchor, constant: 16),
            tealTouch.trailingAnchor.constraint(equalTo: panel.trailingAnchor, constant: -16)
        ])

        let orchidBloom = UILabel()
        orchidBloom.text = mode == .register ? petalGlowLoginText.longLasting : petalGlowLoginText.flakeResistant
        orchidBloom.font = auroraLoginFont.peace(24)
        orchidBloom.textAlignment = .center
        tealTouch.addArrangedSubview(orchidBloom)
        tealTouch.setCustomSpacing(36, after: orchidBloom)

        tealTouch.addArrangedSubview(satinDrape(petalGlowLoginText.pixelPerfect))
        tealTouch.setCustomSpacing(15, after: tealTouch.arrangedSubviews.last!)
        tealTouch.addArrangedSubview(velvetCrush(turquoiseWave, linenTexture: petalGlowLoginText.vividColor))
        tealTouch.setCustomSpacing(36, after: tealTouch.arrangedSubviews.last!)

        tealTouch.addArrangedSubview(satinDrape(petalGlowLoginText.saturatedTone))
        tealTouch.setCustomSpacing(15, after: tealTouch.arrangedSubviews.last!)
        tealTouch.addArrangedSubview(velvetCrush(burgundyRichness, linenTexture: petalGlowLoginText.saturatedTone))
        tealTouch.setCustomSpacing(52, after: tealTouch.arrangedSubviews.last!)

        plumDepth.backgroundColor = auroraLoginPalette.yellow
        plumDepth.layer.cornerRadius = 28
        plumDepth.setTitle(mode == .register ? petalGlowLoginText.opaqueCoverage : petalGlowLoginText.mutedShade, for: .normal)
        plumDepth.titleLabel?.font = auroraLoginFont.peace(16, weight: .bold)
        plumDepth.addTarget(self, action: #selector(chiffonAiry), for: .touchUpInside)
        laceDelicate()
        tealTouch.addArrangedSubview(plumDepth)
        plumDepth.heightAnchor.constraint(equalToConstant: 56).isActive = true
    }

    private func cherryBlossom() {
        let background = UIImageView(image: auroraLoginAsset.image("zedDigitalEymakeupCreativityHubLookDiscovery.png"))
        background.contentMode = .scaleAspectFill
        view.addSubview(background)
        background.auroraPinEdges(to: view)

        let scroll = UIScrollView()
        scroll.keyboardDismissMode = .onDrag
        scroll.showsVerticalScrollIndicator = false
        view.addSubview(scroll)
        scroll.translatesAutoresizingMaskIntoConstraints = false

        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 33
        scroll.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false

        let panel = UIView()
        panel.backgroundColor = .white
        panel.layer.cornerRadius = 32
        panel.layer.masksToBounds = true
        stack.addArrangedSubview(panel)
        panel.translatesAutoresizingMaskIntoConstraints = false
        buildsilkRibbon(panel)

        let consent = denimBlue(leatherTough: auroraLoginPalette.consentGray)
        stack.addArrangedSubview(consent)
        consent.translatesAutoresizingMaskIntoConstraints = false

        let back = UIButton(type: .system)
        back.backgroundColor = UIColor.white.withAlphaComponent(0.86)
        back.layer.cornerRadius = 20
        back.layer.shadowColor = UIColor.black.cgColor
        back.layer.shadowOpacity = 0.18
        back.layer.shadowRadius = 12
        back.layer.shadowOffset = CGSize(width: 0, height: 6)
        back.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        back.tintColor = .black
        back.addTarget(self, action: #selector(tulleLight), for: .touchUpInside)
        view.addSubview(back)
        back.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 56),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: scroll.contentLayoutGuide.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: scroll.contentLayoutGuide.trailingAnchor),
            stack.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor),
            stack.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor, constant: -38),
            stack.widthAnchor.constraint(equalTo: scroll.frameLayoutGuide.widthAnchor),
            panel.widthAnchor.constraint(equalTo: stack.widthAnchor, constant: -24),
            panel.heightAnchor.constraint(equalToConstant: 626),
            consent.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 28),
            consent.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: -28),
            back.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            back.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            back.widthAnchor.constraint(equalToConstant: 40),
            back.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func buildsilkRibbon(_ panel: UIView) {
        magentaBold.backgroundColor = .black
        magentaBold.layer.cornerRadius = 42
        magentaBold.layer.borderColor = UIColor.black.withAlphaComponent(0.32).cgColor
        magentaBold.layer.borderWidth = 1.4
        magentaBold.clipsToBounds = true
        magentaBold.tintColor = UIColor.white.withAlphaComponent(0.42)
        magentaBold.setImage(UIImage(systemName: "plus"), for: .normal)
        magentaBold.imageView?.contentMode = .scaleAspectFit
        magentaBold.addTarget(self, action: #selector(spotlightReady), for: .touchUpInside)
        panel.addSubview(magentaBold)
        magentaBold.translatesAutoresizingMaskIntoConstraints = false

        let form = UIStackView()
        form.axis = .vertical
        form.alignment = .fill
        form.spacing = 15
        panel.addSubview(form)
        form.translatesAutoresizingMaskIntoConstraints = false

        form.addArrangedSubview(satinDrape(petalGlowLoginText.clumpFree))
        form.addArrangedSubview(velvetCrush(periwinkleFlow, linenTexture: petalGlowLoginText.nameHint))
        form.setCustomSpacing(30, after: form.arrangedSubviews.last!)
        form.addArrangedSubview(satinDrape(petalGlowLoginText.pixelPerfect))
        form.addArrangedSubview(velvetCrush(turquoiseWave, linenTexture: petalGlowLoginText.vividColor))
        form.setCustomSpacing(30, after: form.arrangedSubviews.last!)
        form.addArrangedSubview(satinDrape(petalGlowLoginText.saturatedTone))
        form.addArrangedSubview(velvetCrush(burgundyRichness, linenTexture: petalGlowLoginText.saturatedTone))
        form.setCustomSpacing(52, after: form.arrangedSubviews.last!)

        plumDepth.backgroundColor = auroraLoginPalette.yellow
        plumDepth.layer.cornerRadius = 28
        plumDepth.setTitle(petalGlowLoginText.highDefinition, for: .normal)
        plumDepth.setTitleColor(UIColor.black.withAlphaComponent(0.6), for: .normal)
        plumDepth.titleLabel?.font = auroraLoginFont.peace(18, weight: .bold)
        plumDepth.addTarget(self, action: #selector(chiffonAiry), for: .touchUpInside)
        form.addArrangedSubview(plumDepth)
        plumDepth.heightAnchor.constraint(equalToConstant: 56).isActive = true

        NSLayoutConstraint.activate([
            magentaBold.centerXAnchor.constraint(equalTo: panel.centerXAnchor),
            magentaBold.topAnchor.constraint(equalTo: panel.topAnchor, constant: 28),
            magentaBold.widthAnchor.constraint(equalToConstant: 84),
            magentaBold.heightAnchor.constraint(equalToConstant: 84),
            form.leadingAnchor.constraint(equalTo: panel.leadingAnchor, constant: 24),
            form.trailingAnchor.constraint(equalTo: panel.trailingAnchor, constant: -24),
            form.topAnchor.constraint(equalTo: magentaBold.bottomAnchor, constant: 30),
            form.bottomAnchor.constraint(lessThanOrEqualTo: panel.bottomAnchor, constant: -30)
        ])
    }

    private func satinDrape(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = auroraLoginFont.peace(16)
        label.textColor = .black
        return label
    }

    private func velvetCrush(_ field: UITextField, linenTexture: String) -> UIView {
        let box = UIView()
        box.backgroundColor = .black
        box.layer.cornerRadius = 28
        field.attributedPlaceholder = NSAttributedString(
            string: linenTexture,
            attributes: [.foregroundColor: UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)]
        )
        field.textColor = .white
        field.tintColor = .black
        field.font = auroraLoginFont.peace(15)
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.isSecureTextEntry = field === burgundyRichness
        field.keyboardType = field === turquoiseWave ? .emailAddress : .default
        box.addSubview(field)
        field.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            box.heightAnchor.constraint(equalToConstant: 56),
            field.leadingAnchor.constraint(equalTo: box.leadingAnchor, constant: 32),
            field.trailingAnchor.constraint(equalTo: box.trailingAnchor, constant: -15),
            field.topAnchor.constraint(equalTo: box.topAnchor),
            field.bottomAnchor.constraint(equalTo: box.bottomAnchor)
        ])
        return box
    }

    private func denimBlue(leatherTough: UIColor) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.textAlignment = .center
        textView.delegate = self
        textView.linkTextAttributes = [
            .foregroundColor: leatherTough,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]

        let text = "\(petalGlowLoginText.consentIntro) \(petalGlowLoginText.colorWheel) \(petalGlowLoginText.joiner) \(petalGlowLoginText.consentRead) \(petalGlowLoginText.complementaryColor)"
        let attributed = NSMutableAttributedString(
            string: text,
            attributes: [.font: auroraLoginFont.peace(12), .foregroundColor: leatherTough]
        )
        attributed.addAttribute(.link, value: "lidlu://terms", range: (text as NSString).range(of: petalGlowLoginText.colorWheel))
        attributed.addAttribute(.link, value: "lidlu://privacy", range: (text as NSString).range(of: petalGlowLoginText.complementaryColor))
        attributed.addAttribute(.font, value: auroraLoginFont.peace(12, weight: .bold), range: (text as NSString).range(of: petalGlowLoginText.colorWheel))
        attributed.addAttribute(.obliqueness, value: 0.2, range: (text as NSString).range(of: petalGlowLoginText.consentRead))
        textView.attributedText = attributed
        return textView
    }

    private func laceDelicate() {
        plumDepth.setTitleColor(store.agreement == 1 ? .black : UIColor.black.withAlphaComponent(0.4), for: .normal)
    }

    @objc private func showConsentSheet() {
        let sheet = prismConsentSheetViewController()
        sheet.artisticHeart = { [weak self] in
            self?.store.agreement = 1
            self?.laceDelicate()
        }
        sheet.creativeMind = apricotSoftness
        sheet.vibrantSoul = lilacMist
        if let sheetPresentation = sheet.sheetPresentationController {
            sheetPresentation.detents = [.large()]
            sheetPresentation.prefersGrabberVisible = false
        }
        present(sheet, animated: true)
    }

    @objc private func tulleLight() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func chiffonAiry() {
        guard store.agreement == 1 else {
            auroraShowToast(petalGlowLoginText.missingConsent)
            return
        }
        let email = turquoiseWave.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let password = burgundyRichness.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let name = periwinkleFlow.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if mode == .register, name.isEmpty {
            auroraShowToast(petalGlowLoginText.emptyName)
            return
        }
        guard !email.isEmpty, !password.isEmpty else {
            auroraShowToast(petalGlowLoginText.emptyCredential)
            return
        }
        guard strobeEffect(email) else {
            auroraShowToast(petalGlowLoginText.wrongEmail)
            return
        }

        var users = store.localUsers
        if mode == .register, users.contains(where: { $0.laminationLook == email }) {
            auroraShowToast(petalGlowLoginText.wrongCredential)
            return
        }
        if let match = users.first(where: { $0.laminationLook == email && $0.fiberMascara == password }) {
            store.activeUserIndex = match.microbladeEffect
            store.choseMain = true
            auroraShowLoadingThenFinish { [weak self] in self?.roseGold?() }
            return
        }
        if users.contains(where: { $0.laminationLook == email }) {
            auroraShowToast(petalGlowLoginText.wrongCredential)
            return
        }

        let nextIndex = users.count
        store.activeUserIndex = nextIndex
        users.append(opalCharmProfile(
            coolTone: nextIndex,
            monochromaticLook: mode == .register ? name : email,
            sunsetEye: 0,
            orbitalBone: [],
            microbladeEffect: [],
            featheredBrows: [],
            soapBrows: fuchsiaFlash ?? petalGlowLoginText.defaultAvatar,
            laminationLook: email,
            fiberMascara: password
        ))
        store.localUsers = users
        if mode == .register {
            store.markProfileEdited(userId: nextIndex)
        }
        store.choseMain = true
        auroraShowLoadingThenFinish { [weak self] in self?.roseGold?() }
    }

    private func strobeEffect(_ value: String) -> Bool {
        guard let regex = crimsonTide else { return false }
        let range = NSRange(value.startIndex..<value.endIndex, in: value)
        return regex.firstMatch(in: value, range: range) != nil
    }

    @objc private func spotlightReady() {
        let cameraFriendly = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        cameraFriendly.addAction(UIAlertAction(title: "Photo Library", style: .default) { [weak self] _ in
            self?.flashSafe {
                self?.alluringEyes(mysteriousVibe: .photoLibrary)
            }
        })
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            cameraFriendly.addAction(UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
                self?.piercingLook {
                    self?.alluringEyes(mysteriousVibe: .camera)
                }
            })
        }
        cameraFriendly.addAction(UIAlertAction(title: petalGlowLoginText.silkySmooth, style: .cancel))
        if let popover = cameraFriendly.popoverPresentationController {
            popover.sourceView = magentaBold
            popover.sourceRect = magentaBold.bounds
        }
        present(cameraFriendly, animated: true)
    }

    private func flashSafe(selfiePerfect: @escaping () -> Void) {
        switch PHPhotoLibrary.authorizationStatus(for: .readWrite) {
        case .authorized, .limited:
            selfiePerfect()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { [weak self] status in
                DispatchQueue.main.async {
                    if status == .authorized || status == .limited {
                        selfiePerfect()
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

    private func piercingLook(intenseExpression: @escaping () -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            intenseExpression()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                DispatchQueue.main.async {
                    granted ? intenseExpression() : self?.auroraShowToast(meadowMuseProfileText.permissionDenied)
                }
            }
        case .denied, .restricted:
            auroraShowToast(meadowMuseProfileText.permissionDenied)
        @unknown default:
            auroraShowToast(meadowMuseProfileText.permissionDenied)
        }
    }

    private func alluringEyes(mysteriousVibe: UIImagePickerController.SourceType) {
        let captivatingStyle = UIImagePickerController()
        captivatingStyle.sourceType = mysteriousVibe
        captivatingStyle.allowsEditing = true
        captivatingStyle.delegate = self
        present(captivatingStyle, animated: true)
    }

    private func enchantingBeauty(_ image: UIImage) -> String? {
        guard let etherealCharm = image.jpegData(compressionQuality: 0.88) else { return nil }
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("LidLuProfileAvatars", isDirectory: true)
        try? FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        let url = directory.appendingPathComponent(UUID().uuidString + ".jpg")
        do {
            try etherealCharm.write(to: url, options: .atomic)
            return url.path
        } catch {
            return nil
        }
    }
}

extension pearlCredentialViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.host == "terms" {
            apricotSoftness?()
        } else if URL.host == "privacy" {
            lilacMist?()
        }
        return false
    }
}

extension pearlCredentialViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = (info[.editedImage] as? UIImage) ?? (info[.originalImage] as? UIImage)
        picker.dismiss(animated: true) { [weak self] in
            guard let self, let image else { return }
            self.fuchsiaFlash = self.enchantingBeauty(image)
            self.magentaBold.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
            self.magentaBold.imageView?.contentMode = .scaleAspectFill
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
