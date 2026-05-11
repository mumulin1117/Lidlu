import AuthenticationServices
import UIKit

final class velvetEntryGateViewController: UIViewController {
    var onFinished: (() -> Void)?
    var onTerms: (() -> Void)?
    var onPrivacy: (() -> Void)?

    private let store = velvetAuraStore.shared
    private var didAutoPresentConsent = false

    override func viewDidLoad() {
        super.viewDidLoad()
        buildScene()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard store.agreement != 1, !didAutoPresentConsent else { return }
        didAutoPresentConsent = true
        showConsentSheet()
    }

    private func buildScene() {
        let background = UIImageView(image: auroraLoginAsset.image("zedDigitalEymakeupCreativityHubLookDiscovery.png"))
        background.contentMode = .scaleAspectFill
        view.addSubview(background)
        background.auroraPinEdges(to: view)

        let warmOverlay = CAGradientLayer()
        warmOverlay.colors = [
            UIColor.clear.cgColor,
            UIColor(red: 1.0, green: 0.93, blue: 0.13, alpha: 0.2).cgColor,
            UIColor(red: 1.0, green: 0.93, blue: 0.13, alpha: 0.96).cgColor
        ]
        warmOverlay.locations = [0.0, 0.54, 1.0]
        warmOverlay.frame = view.bounds
        background.layer.addSublayer(warmOverlay)

        let eula = UIButton(type: .system)
        eula.backgroundColor = UIColor.white.withAlphaComponent(0.32)
        eula.layer.cornerRadius = 16
        eula.setTitle("\(petalGlowLoginText.eula)  ›", for: .normal)
        eula.setTitleColor(.white, for: .normal)
        eula.titleLabel?.font = auroraLoginFont.peace(13, weight: .bold)
        eula.addTarget(self, action: #selector(showConsentSheet), for: .touchUpInside)
        view.addSubview(eula)
        eula.translatesAutoresizingMaskIntoConstraints = false

        let logo = UIImageView(image: auroraLoginAsset.image("zedDigitalEyapunchrcon.png"))
        logo.contentMode = .scaleAspectFill
        logo.clipsToBounds = true
        logo.layer.cornerRadius = 28
        view.addSubview(logo)
        logo.translatesAutoresizingMaskIntoConstraints = false

        let brand = UILabel()
        brand.text = pearlGazeText.appName.uppercased()
        brand.textColor = .black
        brand.textAlignment = .center
        brand.font = auroraLoginFont.peace(25, weight: .heavy)
        brand.shadowColor = UIColor.white.withAlphaComponent(0.26)
        brand.shadowOffset = CGSize(width: 0, height: 1)
        view.addSubview(brand)
        brand.translatesAutoresizingMaskIntoConstraints = false

        let emailButton = gateButton(title: petalGlowLoginText.email, systemImage: "envelope.fill", foreground: .white, background: .black, selector: #selector(openEmail))
        view.addSubview(emailButton)
        emailButton.translatesAutoresizingMaskIntoConstraints = false

        let signUpButton = gateButton(title: petalGlowLoginText.signUp, systemImage: "person.fill", foreground: .black, background: .white, selector: #selector(openRegister))
        view.addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false

        let apple = UIButton(type: .system)
        apple.backgroundColor = .black
        apple.layer.cornerRadius = 30
        apple.tintColor = .white
        apple.setImage(UIImage(systemName: "apple.logo"), for: .normal)
        apple.imageView?.contentMode = .scaleAspectFit
        apple.addTarget(self, action: #selector(startAppleLogin), for: .touchUpInside)
        view.addSubview(apple)
        apple.translatesAutoresizingMaskIntoConstraints = false

        let consent = consentText(color: .black)
        view.addSubview(consent)
        consent.translatesAutoresizingMaskIntoConstraints = false

        let logoTop = logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 208)
        logoTop.priority = .defaultHigh
        let appleBottomLimit = apple.bottomAnchor.constraint(lessThanOrEqualTo: consent.topAnchor, constant: -18)

        NSLayoutConstraint.activate([
            eula.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            eula.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
            eula.widthAnchor.constraint(equalToConstant: 72),
            eula.heightAnchor.constraint(equalToConstant: 32),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 88),
            logoTop,
            logo.widthAnchor.constraint(equalToConstant: 114),
            logo.heightAnchor.constraint(equalToConstant: 114),
            brand.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            brand.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 24),
            brand.widthAnchor.constraint(equalToConstant: 180),
            emailButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailButton.topAnchor.constraint(equalTo: brand.bottomAnchor, constant: 40),
            emailButton.heightAnchor.constraint(equalToConstant: 60),
            signUpButton.leadingAnchor.constraint(equalTo: emailButton.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: emailButton.trailingAnchor),
            signUpButton.topAnchor.constraint(equalTo: emailButton.bottomAnchor, constant: 14),
            signUpButton.heightAnchor.constraint(equalToConstant: 60),
            apple.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            apple.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 26),
            apple.widthAnchor.constraint(equalToConstant: 60),
            apple.heightAnchor.constraint(equalToConstant: 60),
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

        let text = "\(petalGlowLoginText.consentIntro) \(petalGlowLoginText.terms) \(petalGlowLoginText.joiner) \(petalGlowLoginText.consentRead) \(petalGlowLoginText.privacy)"
        let attributed = NSMutableAttributedString(
            string: text,
            attributes: [.font: auroraLoginFont.peace(12), .foregroundColor: color]
        )
        attributed.addAttribute(.link, value: "lidlu://terms", range: (text as NSString).range(of: petalGlowLoginText.terms))
        attributed.addAttribute(.link, value: "lidlu://privacy", range: (text as NSString).range(of: petalGlowLoginText.privacy))
        attributed.addAttribute(.font, value: auroraLoginFont.peace(12, weight: .bold), range: (text as NSString).range(of: petalGlowLoginText.terms))
        attributed.addAttribute(.obliqueness, value: 0.2, range: (text as NSString).range(of: petalGlowLoginText.consentRead))
        textView.attributedText = attributed
        return textView
    }

    @objc private func openEmail() {
        let page = pearlCredentialViewController()
        page.onFinished = onFinished
        page.onTerms = onTerms
        page.onPrivacy = onPrivacy
        navigationController?.pushViewController(page, animated: true)
    }

    @objc private func openRegister() {
        let page = pearlCredentialViewController(mode: .register)
        page.onFinished = onFinished
        page.onTerms = onTerms
        page.onPrivacy = onPrivacy
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
        sheet.onAgree = { [weak self] in
            self?.store.agreement = 1
        }
        sheet.onTerms = onTerms
        sheet.onPrivacy = onPrivacy
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
            let json = try await radianceTrailService().appleSsoLogin(
                identityToken: identityToken,
                bundleId: moonlitMirrorConfig.appleBundleId,
                equipmentNo: equipmentNo
            )
            try applyAppleResponse(json, fallbackEmail: fallbackEmail, fallbackName: fallbackName)
            auroraHideLoading(loading) { [weak self] in
                self?.onFinished?()
            }
        } catch {
            let message = (error as? appleLoginMessageError)?.message ?? pearlGazeText.visible.loginFailure
            auroraHideLoading(loading) { [weak self] in
                self?.auroraShowToast(message)
            }
        }
    }

    private func applyAppleResponse(_ json: [String: Any], fallbackEmail: String?, fallbackName: String?) throws {
        let code = contourHaloMapper.intValue(json["code"])
        guard code == 200000 else {
            let message = contourHaloMapper.stringValue(json["message"])
            throw appleLoginMessageError(message: message.isEmpty ? pearlGazeText.visible.loginFailure : message)
        }

        let data = json["data"] as? [String: Any] ?? [:]
        let token = contourHaloMapper.stringValue(data[kohlRibbonField.token])
        let remoteId = contourHaloMapper.intValue(data[kohlRibbonField.userId])
        let responseEmail = contourHaloMapper.stringValue(data["userEmail"])
        let responseName = contourHaloMapper.stringValue(data["userName"])
        let responseAvatar = contourHaloMapper.stringValue(data["userImgUrl"])
        let email = responseEmail.isEmpty ? (fallbackEmail ?? petalGlowLoginText.appleEmail) : responseEmail
        let name = responseName.isEmpty ? ((fallbackName?.isEmpty == false ? fallbackName : nil) ?? email) : responseName
        let avatar = responseAvatar.hasPrefix("http") ? petalGlowLoginText.defaultAvatar : responseAvatar

        var users = store.localUsers
        if let index = users.firstIndex(where: { $0.email == email }) {
            users[index].name = name
            if !avatar.isEmpty {
                users[index].avatar = avatar
            }
            store.activeUserIndex = users[index].id
            if name != email {
                store.markProfileEdited(userId: users[index].id)
            }
        } else {
            let nextIndex = users.count
            users.append(opalCharmProfile(
                id: nextIndex,
                name: name,
                balance: 0,
                created: [],
                liked: [],
                saved: [],
                avatar: avatar,
                email: email,
                password: "apple"
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
            auroraShowToast(petalGlowLoginText.appleCancelled)
        } else {
            auroraShowToast(pearlGazeText.visible.loginFailure)
        }
    }

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        view.window ?? ASPresentationAnchor()
    }
}

extension velvetEntryGateViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.host == "terms" {
            onTerms?()
            return false
        }
        if URL.host == "privacy" {
            onPrivacy?()
            return false
        }
        return false
    }
}
