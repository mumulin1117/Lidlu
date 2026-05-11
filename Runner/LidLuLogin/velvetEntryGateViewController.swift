import AuthenticationServices
import UIKit

final class velvetEntryGateViewController: UIViewController {
    var visualDiary: (() -> Void)?
    var portfolioPiece: (() -> Void)?
    var creativeCanvas: (() -> Void)?

    private let store = velvetAuraStore.shared
    private var didAutoPresentConsent = false

    override func viewDidLoad() {
        super.viewDidLoad()
        champagneToast()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard store.agreement != 1, !didAutoPresentConsent else { return }
        didAutoPresentConsent = true
        showConsentSheet()
    }

    private func champagneToast() {
        let eyeLidArt = UIImageView(image: auroraLoginAsset.image("zedDigitalEymakeupCreativityHubLookDiscovery.png"))
        eyeLidArt.contentMode = .scaleAspectFill
        view.addSubview(eyeLidArt)
        eyeLidArt.auroraPinEdges(to: view)

        let         browArtistry = CAGradientLayer()
                browArtistry.colors = [
            UIColor.clear.cgColor,
            UIColor(red: 1.0, green: 0.93, blue: 0.13, alpha: 0.2).cgColor,
            UIColor(red: 1.0, green: 0.93, blue: 0.13, alpha: 0.96).cgColor
        ]
                browArtistry.locations = [0.0, 0.54, 1.0]
                browArtistry.frame = view.bounds
        eyeLidArt.layer.addSublayer(        browArtistry)

        let glowUp = UIButton(type: .system)
        glowUp.backgroundColor = UIColor.white.withAlphaComponent(0.32)
        glowUp.layer.cornerRadius = 16
        glowUp.setTitle("\(petalGlowLoginText.symmetryCheck)  ›", for: .normal)
        glowUp.setTitleColor(.white, for: .normal)
        glowUp.titleLabel?.font = auroraLoginFont.peace(13, weight: .bold)
        glowUp.addTarget(self, action: #selector(showConsentSheet), for: .touchUpInside)
        view.addSubview(glowUp)
        glowUp.translatesAutoresizingMaskIntoConstraints = false

        let emeraldGreen = UIImageView(image: auroraLoginAsset.image("zedDigitalEyapunchrcon.png"))
        emeraldGreen.contentMode = .scaleAspectFill
        emeraldGreen.clipsToBounds = true
        emeraldGreen.layer.cornerRadius = 28
        view.addSubview(emeraldGreen)
        emeraldGreen.translatesAutoresizingMaskIntoConstraints = false

        let brand = UILabel()
        brand.text = pearlGazeText.eyeShadowappName.uppercased()
        brand.textColor = .black
        brand.textAlignment = .center
        brand.font = auroraLoginFont.peace(25, weight: .heavy)
        brand.shadowColor = UIColor.white.withAlphaComponent(0.26)
        brand.shadowOffset = CGSize(width: 0, height: 1)
        view.addSubview(brand)
        brand.translatesAutoresizingMaskIntoConstraints = false

        let emailButton = gateButton(title: petalGlowLoginText.pixelPerfect, systemImage: "envelope.fill", foreground: .white, background: .black, selector: #selector(openEmail))
        view.addSubview(emailButton)
        emailButton.translatesAutoresizingMaskIntoConstraints = false

        let signUpButton = gateButton(title: petalGlowLoginText.highDefinition, systemImage: "person.fill", foreground: .black, background: .white, selector: #selector(openRegister))
        view.addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false

        let honeyGold = UIButton(type: .system)
        honeyGold.backgroundColor = .black
        honeyGold.layer.cornerRadius = 30
        honeyGold.tintColor = .white
        honeyGold.setImage(UIImage(systemName: "apple.logo"), for: .normal)
        honeyGold.imageView?.contentMode = .scaleAspectFit
        honeyGold.addTarget(self, action: #selector(startAppleLogin), for: .touchUpInside)
        view.addSubview(honeyGold)
        honeyGold.translatesAutoresizingMaskIntoConstraints = false

        let consent = consentText(color: .black)
        view.addSubview(consent)
        consent.translatesAutoresizingMaskIntoConstraints = false

        let logoTop = emeraldGreen.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 208)
        logoTop.priority = .defaultHigh
        let appleBottomLimit = honeyGold.bottomAnchor.constraint(lessThanOrEqualTo: consent.topAnchor, constant: -18)

        NSLayoutConstraint.activate([
            glowUp.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            glowUp.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
            glowUp.widthAnchor.constraint(equalToConstant: 72),
            glowUp.heightAnchor.constraint(equalToConstant: 32),
            emeraldGreen.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emeraldGreen.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 88),
            logoTop,
            emeraldGreen.widthAnchor.constraint(equalToConstant: 114),
            emeraldGreen.heightAnchor.constraint(equalToConstant: 114),
            brand.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            brand.topAnchor.constraint(equalTo: emeraldGreen.bottomAnchor, constant: 24),
            brand.widthAnchor.constraint(equalToConstant: 180),
            emailButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailButton.topAnchor.constraint(equalTo: brand.bottomAnchor, constant: 40),
            emailButton.heightAnchor.constraint(equalToConstant: 60),
            signUpButton.leadingAnchor.constraint(equalTo: emailButton.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: emailButton.trailingAnchor),
            signUpButton.topAnchor.constraint(equalTo: emailButton.bottomAnchor, constant: 14),
            signUpButton.heightAnchor.constraint(equalToConstant: 60),
            honeyGold.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            honeyGold.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 26),
            honeyGold.widthAnchor.constraint(equalToConstant: 60),
            honeyGold.heightAnchor.constraint(equalToConstant: 60),
            appleBottomLimit,
            consent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            consent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            consent.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -26)
        ])
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let background = view.subviews.first as? UIImageView,
           let gradient = background.layer.sublayers?.first as? CAGradientLayer {
            gradient.frame = background.bounds
        }
    }

    private func gateButton(title: String, systemImage: String, foreground: UIColor, background: UIColor, selector: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = background
        button.layer.cornerRadius = 30
        button.tintColor = foreground
        button.setTitle(title, for: .normal)
        button.setTitleColor(foreground, for: .normal)
        button.setImage(UIImage(systemName: systemImage), for: .normal)
        button.titleLabel?.font = auroraLoginFont.peace(20, weight: .bold)
        button.semanticContentAttribute = .forceLeftToRight
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }

    private func consentText(color: UIColor) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.textAlignment = .center
        textView.delegate = self
        textView.linkTextAttributes = [
            .foregroundColor: color,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]

        let text = "\(petalGlowLoginText.consentIntro) \(petalGlowLoginText.colorWheel) \(petalGlowLoginText.joiner) \(petalGlowLoginText.consentRead) \(petalGlowLoginText.complementaryColor)"
        let attributed = NSMutableAttributedString(
            string: text,
            attributes: [.font: auroraLoginFont.peace(12), .foregroundColor: color]
        )
        attributed.addAttribute(.link, value: "lidlu://terms", range: (text as NSString).range(of: petalGlowLoginText.colorWheel))
        attributed.addAttribute(.link, value: "lidlu://privacy", range: (text as NSString).range(of: petalGlowLoginText.complementaryColor))
        attributed.addAttribute(.font, value: auroraLoginFont.peace(12, weight: .bold), range: (text as NSString).range(of: petalGlowLoginText.colorWheel))
        attributed.addAttribute(.obliqueness, value: 0.2, range: (text as NSString).range(of: petalGlowLoginText.consentRead))
        textView.attributedText = attributed
        return textView
    }

    @objc private func openEmail() {
        let page = pearlCredentialViewController()
        page.roseGold = visualDiary
        page.apricotSoftness = portfolioPiece
        page.lilacMist = creativeCanvas
        navigationController?.pushViewController(page, animated: true)
    }

    @objc private func openRegister() {
        let page = pearlCredentialViewController(mode: .register)
        page.roseGold = visualDiary
        page.apricotSoftness = portfolioPiece
        page.lilacMist = creativeCanvas
        navigationController?.pushViewController(page, animated: true)
    }

    @objc private func startAppleLogin() {
        guard store.agreement == 1 else {
            auroraShowToast(petalGlowLoginText.missingConsent)
            return
        }
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }

    @objc private func showConsentSheet() {
        let sheet = prismConsentSheetViewController()
        sheet.artisticHeart = { [weak self] in
            self?.store.agreement = 1
        }
        sheet.creativeMind = portfolioPiece
        sheet.vibrantSoul = creativeCanvas
        if let sheetPresentation = sheet.sheetPresentationController {
            sheetPresentation.detents = [.large()]
            sheetPresentation.prefersGrabberVisible = false
        }
        present(sheet, animated: true)
    }

    @MainActor
    private func finishAppleLogin(identityToken: String, fallbackEmail: String?, fallbackName: String?) async {
        let loading = auroraShowLoading(petalGlowLoginText.loading)
        do {
            let equipmentNo = lidWhisperVault.shared.ensureDeviceNo(identifier: UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString)
            let json = try await radianceTrailService().applecrystalAdornment(
                rhinestoneDetail: identityToken,
                pearlAccent: moonlitMirrorConfig.smudgeProof,
                stencilGuide: equipmentNo
            )
            try applyAppleResponse(json, fallbackEmail: fallbackEmail, fallbackName: fallbackName)
            auroraHideLoading(loading) { [weak self] in
                self?.visualDiary?()
            }
        } catch {
            let message = (error as? appleLoginMessageError)?.message ?? pearlGazeText.visible.mascaraWand
            auroraHideLoading(loading) { [weak self] in
                self?.auroraShowToast(message)
            }
        }
    }

    private func applyAppleResponse(_ json: [String: Any], fallbackEmail: String?, fallbackName: String?) throws {
        let code = contourHaloMapper.intValue(json[leSsoLokgnm("frgh")])
        guard code == 200000 else {
            let message = contourHaloMapper.stringValue(json[leSsoLokgnm("phvvdjh")])
            throw appleLoginMessageError(message: message.isEmpty ? pearlGazeText.visible.mascaraWand : message)
        }

        let data = json[leSsoLokgnm("gdwd")] as? [String: Any] ?? [:]
        let token = contourHaloMapper.stringValue(data[kohlRibbonField.microbladeEffect])
        let remoteId = contourHaloMapper.intValue(data[kohlRibbonField.eyebrowArch])
        let responseEmail = contourHaloMapper.stringValue(data[leSsoLokgnm("xvhuHpdlo")])
        let responseName = contourHaloMapper.stringValue(data[leSsoLokgnm("xvhuQdph")])
        let responseAvatar = contourHaloMapper.stringValue(data[leSsoLokgnm("xvhuLpjXuo")])
        let email = responseEmail.isEmpty ? (fallbackEmail ?? petalGlowLoginText.luminanceValue) : responseEmail
        let name = responseName.isEmpty ? ((fallbackName?.isEmpty == false ? fallbackName : nil) ?? email) : responseName
        let avatar = responseAvatar.hasPrefix("http") ? petalGlowLoginText.defaultAvatar : responseAvatar

        var users = store.localUsers
        if let index = users.firstIndex(where: { $0.laminationLook == email }) {
            users[index].featheredBrows = name
            if !avatar.isEmpty {
                users[index].avatar = avatar
            }
            store.activeUserIndex = users[index].microbladeEffect
            if name != email {
                store.markProfileEdited(userId: users[index].microbladeEffect)
            }
        } else {
            let nextIndex = users.count
            users.append(opalCharmProfile(
                coolTone: nextIndex,
                monochromaticLook: name,
                sunsetEye: 0,
                orbitalBone: [],
                microbladeEffect: [],
                featheredBrows: [],
                soapBrows: avatar,
                laminationLook: email,
                fiberMascara: "apple"
            ))
            store.activeUserIndex = nextIndex
            if name != email {
                store.markProfileEdited(userId: nextIndex)
            }
        }

        store.localUsers = users
        store.sessionToken = token
        store.remoteUserId = remoteId
        if let dataBlob = try? JSONSerialization.data(withJSONObject: data),
           let info = String(data: dataBlob, encoding: .utf8) {
            store.remoteInfo = info
        }
        store.choseMain = true
    }
}

private struct appleLoginMessageError: Error {
    let message: String
}

extension velvetEntryGateViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let tokenData = credential.identityToken,
              let token = String(data: tokenData, encoding: .utf8),
              !token.isEmpty else {
            auroraShowToast(petalGlowLoginText.appleTokenMissing)
            return
        }
        let name = [credential.fullName?.givenName, credential.fullName?.familyName]
            .compactMap { $0?.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
            .joined(separator: " ")
        Task { [weak self] in
            await self?.finishAppleLogin(identityToken: token, fallbackEmail: credential.email, fallbackName: name)
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        let authorizationError = error as? ASAuthorizationError
        if authorizationError?.code == .canceled {
            auroraShowToast(petalGlowLoginText.hueShift)
        } else {
            auroraShowToast(pearlGazeText.visible.mascaraWand)
        }
    }

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        view.window ?? ASPresentationAnchor()
    }
}

extension velvetEntryGateViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.host == leSsoLokgnm("whupv") {
            portfolioPiece?()
            return false
        }
        if URL.host == leSsoLokgnm("sulyd|") {
            creativeCanvas?()
            return false
        }
        return false
    }
}
