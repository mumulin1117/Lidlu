import AVFoundation
import Photos
import UIKit

enum pearlCredentialMode {
    case signIn
    case register
}

final class pearlCredentialViewController: UIViewController {
    var onFinished: (() -> Void)?
    var onTerms: (() -> Void)?
    var onPrivacy: (() -> Void)?

    private let store = velvetAuraStore.shared
    private let mode: pearlCredentialMode
    private let nameField = UITextField()
    private let emailField = UITextField()
    private let passwordField = UITextField()
    private let loginButton = UIButton(type: .system)
    private let avatarButton = UIButton(type: .custom)
    private var selectedAvatarPath: String?
    private let emailPattern = try? NSRegularExpression(pattern: "^[a-zA-Z0-9._%+-]+@gmail\\.com$")

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
            buildRegisterScene()
            return
        }

        let background = UIImageView(image: auroraLoginAsset.image("zedDigitalEymakeupCreativityHubLookDiscovery.png"))
        background.contentMode = .scaleAspectFill
        view.addSubview(background)
        background.auroraPinEdges(to: view)

        let back = UIButton(type: .system)
        back.backgroundColor = UIColor.white.withAlphaComponent(0.28)
        back.layer.cornerRadius = 16
        back.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        back.tintColor = .white
        back.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        view.addSubview(back)
        back.translatesAutoresizingMaskIntoConstraints = false

        let eula = UIButton(type: .system)
        eula.backgroundColor = auroraLoginPalette.softWhite
        eula.layer.cornerRadius = 16
        eula.setTitle(petalGlowLoginText.eula, for: .normal)
        eula.setTitleColor(.white, for: .normal)
        eula.titleLabel?.font = auroraLoginFont.peace(12)
        eula.addTarget(self, action: #selector(showConsentSheet), for: .touchUpInside)
        view.addSubview(eula)
        eula.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            back.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 14),
            back.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            back.widthAnchor.constraint(equalToConstant: 32),
            back.heightAnchor.constraint(equalToConstant: 32),
            eula.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 14),
            eula.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            eula.widthAnchor.constraint(equalToConstant: 72),
            eula.heightAnchor.constraint(equalToConstant: 32)
        ])

        let scroll = UIScrollView()
        scroll.keyboardDismissMode = .onDrag
        view.addSubview(scroll)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: eula.bottomAnchor, constant: 20),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        scroll.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: scroll.contentLayoutGuide.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: scroll.contentLayoutGuide.trailingAnchor),
            stack.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor),
            stack.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor, constant: -30),
            stack.widthAnchor.constraint(equalTo: scroll.frameLayoutGuide.widthAnchor)
        ])

        let spacer = UIView()
        stack.addArrangedSubview(spacer)
        spacer.heightAnchor.constraint(greaterThanOrEqualToConstant: 190).isActive = true

        let panel = UIView()
        panel.backgroundColor = .white
        panel.layer.cornerRadius = 32
        stack.addArrangedSubview(panel)
        panel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            panel.widthAnchor.constraint(equalToConstant: 351),
            panel.heightAnchor.constraint(equalToConstant: 463)
        ])

        buildPanel(panel)
        stack.setCustomSpacing(33, after: panel)

        let consent = consentText(color: auroraLoginPalette.consentGray)
        stack.addArrangedSubview(consent)
        NSLayoutConstraint.activate([
            consent.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 20),
            consent.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: -20)
        ])
    }

    private func buildPanel(_ panel: UIView) {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        panel.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: panel.topAnchor, constant: 24),
            stack.leadingAnchor.constraint(equalTo: panel.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: panel.trailingAnchor, constant: -16)
        ])

        let title = UILabel()
        title.text = mode == .register ? petalGlowLoginText.register : petalGlowLoginText.signIn
        title.font = auroraLoginFont.peace(24)
        title.textAlignment = .center
        stack.addArrangedSubview(title)
        stack.setCustomSpacing(36, after: title)

        stack.addArrangedSubview(label(petalGlowLoginText.email))
        stack.setCustomSpacing(15, after: stack.arrangedSubviews.last!)
        stack.addArrangedSubview(fieldBox(emailField, placeholder: petalGlowLoginText.emailHint))
        stack.setCustomSpacing(36, after: stack.arrangedSubviews.last!)

        stack.addArrangedSubview(label(petalGlowLoginText.password))
        stack.setCustomSpacing(15, after: stack.arrangedSubviews.last!)
        stack.addArrangedSubview(fieldBox(passwordField, placeholder: petalGlowLoginText.password))
        stack.setCustomSpacing(52, after: stack.arrangedSubviews.last!)

        loginButton.backgroundColor = auroraLoginPalette.yellow
        loginButton.layer.cornerRadius = 28
        loginButton.setTitle(mode == .register ? petalGlowLoginText.registerAction : petalGlowLoginText.login, for: .normal)
        loginButton.titleLabel?.font = auroraLoginFont.peace(16, weight: .bold)
        loginButton.addTarget(self, action: #selector(submitCredential), for: .touchUpInside)
        updateLoginButton()
        stack.addArrangedSubview(loginButton)
        loginButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
    }

    private func buildRegisterScene() {
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
        buildRegisterPanel(panel)

        let consent = consentText(color: auroraLoginPalette.consentGray)
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
        back.addTarget(self, action: #selector(goBack), for: .touchUpInside)
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

    private func buildRegisterPanel(_ panel: UIView) {
        avatarButton.backgroundColor = .black
        avatarButton.layer.cornerRadius = 42
        avatarButton.layer.borderColor = UIColor.black.withAlphaComponent(0.32).cgColor
        avatarButton.layer.borderWidth = 1.4
        avatarButton.clipsToBounds = true
        avatarButton.tintColor = UIColor.white.withAlphaComponent(0.42)
        avatarButton.setImage(UIImage(systemName: "plus"), for: .normal)
        avatarButton.imageView?.contentMode = .scaleAspectFit
        avatarButton.addTarget(self, action: #selector(selectAvatar), for: .touchUpInside)
        panel.addSubview(avatarButton)
        avatarButton.translatesAutoresizingMaskIntoConstraints = false

        let form = UIStackView()
        form.axis = .vertical
        form.alignment = .fill
        form.spacing = 15
        panel.addSubview(form)
        form.translatesAutoresizingMaskIntoConstraints = false

        form.addArrangedSubview(label(petalGlowLoginText.name))
        form.addArrangedSubview(fieldBox(nameField, placeholder: petalGlowLoginText.nameHint))
        form.setCustomSpacing(30, after: form.arrangedSubviews.last!)
        form.addArrangedSubview(label(petalGlowLoginText.email))
        form.addArrangedSubview(fieldBox(emailField, placeholder: petalGlowLoginText.emailHint))
        form.setCustomSpacing(30, after: form.arrangedSubviews.last!)
        form.addArrangedSubview(label(petalGlowLoginText.password))
        form.addArrangedSubview(fieldBox(passwordField, placeholder: petalGlowLoginText.password))
        form.setCustomSpacing(52, after: form.arrangedSubviews.last!)

        loginButton.backgroundColor = auroraLoginPalette.yellow
        loginButton.layer.cornerRadius = 28
        loginButton.setTitle(petalGlowLoginText.signUp, for: .normal)
        loginButton.setTitleColor(UIColor.black.withAlphaComponent(0.6), for: .normal)
        loginButton.titleLabel?.font = auroraLoginFont.peace(18, weight: .bold)
        loginButton.addTarget(self, action: #selector(submitCredential), for: .touchUpInside)
        form.addArrangedSubview(loginButton)
        loginButton.heightAnchor.constraint(equalToConstant: 56).isActive = true

        NSLayoutConstraint.activate([
            avatarButton.centerXAnchor.constraint(equalTo: panel.centerXAnchor),
            avatarButton.topAnchor.constraint(equalTo: panel.topAnchor, constant: 28),
            avatarButton.widthAnchor.constraint(equalToConstant: 84),
            avatarButton.heightAnchor.constraint(equalToConstant: 84),
            form.leadingAnchor.constraint(equalTo: panel.leadingAnchor, constant: 24),
            form.trailingAnchor.constraint(equalTo: panel.trailingAnchor, constant: -24),
            form.topAnchor.constraint(equalTo: avatarButton.bottomAnchor, constant: 30),
            form.bottomAnchor.constraint(lessThanOrEqualTo: panel.bottomAnchor, constant: -30)
        ])
    }

    private func label(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = auroraLoginFont.peace(16)
        label.textColor = .black
        return label
    }

    private func fieldBox(_ field: UITextField, placeholder: String) -> UIView {
        let box = UIView()
        box.backgroundColor = .black
        box.layer.cornerRadius = 28
        field.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)]
        )
        field.textColor = .white
        field.tintColor = .black
        field.font = auroraLoginFont.peace(15)
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.isSecureTextEntry = field === passwordField
        field.keyboardType = field === emailField ? .emailAddress : .default
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

    private func updateLoginButton() {
        loginButton.setTitleColor(store.agreement == 1 ? .black : UIColor.black.withAlphaComponent(0.4), for: .normal)
    }

    @objc private func showConsentSheet() {
        let sheet = prismConsentSheetViewController()
        sheet.onAgree = { [weak self] in
            self?.store.agreement = 1
            self?.updateLoginButton()
        }
        sheet.onTerms = onTerms
        sheet.onPrivacy = onPrivacy
        if let sheetPresentation = sheet.sheetPresentationController {
            sheetPresentation.detents = [.large()]
            sheetPresentation.prefersGrabberVisible = false
        }
        present(sheet, animated: true)
    }

    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func submitCredential() {
        guard store.agreement == 1 else {
            auroraShowToast(petalGlowLoginText.missingConsent)
            return
        }
        let email = emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let password = passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let name = nameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if mode == .register, name.isEmpty {
            auroraShowToast(petalGlowLoginText.emptyName)
            return
        }
        guard !email.isEmpty, !password.isEmpty else {
            auroraShowToast(petalGlowLoginText.emptyCredential)
            return
        }
        guard isValidEmail(email) else {
            auroraShowToast(petalGlowLoginText.wrongEmail)
            return
        }

        var users = store.localUsers
        if mode == .register, users.contains(where: { $0.email == email }) {
            auroraShowToast(petalGlowLoginText.wrongCredential)
            return
        }
        if let match = users.first(where: { $0.email == email && $0.password == password }) {
            store.activeUserIndex = match.id
            store.choseMain = true
            auroraShowLoadingThenFinish { [weak self] in self?.onFinished?() }
            return
        }
        if users.contains(where: { $0.email == email }) {
            auroraShowToast(petalGlowLoginText.wrongCredential)
            return
        }

        let nextIndex = users.count
        store.activeUserIndex = nextIndex
        users.append(opalCharmProfile(
            id: nextIndex,
            name: mode == .register ? name : email,
            balance: 0,
            created: [],
            liked: [],
            saved: [],
            avatar: selectedAvatarPath ?? petalGlowLoginText.defaultAvatar,
            email: email,
            password: password
        ))
        store.localUsers = users
        if mode == .register {
            store.markProfileEdited(userId: nextIndex)
        }
        store.choseMain = true
        auroraShowLoadingThenFinish { [weak self] in self?.onFinished?() }
    }

    private func isValidEmail(_ value: String) -> Bool {
        guard let regex = emailPattern else { return false }
        let range = NSRange(value.startIndex..<value.endIndex, in: value)
        return regex.firstMatch(in: value, range: range) != nil
    }

    @objc private func selectAvatar() {
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Photo Library", style: .default) { [weak self] _ in
            self?.requestPhotoLibraryAccess {
                self?.presentAvatarPicker(sourceType: .photoLibrary)
            }
        })
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            sheet.addAction(UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
                self?.requestCameraAccess {
                    self?.presentAvatarPicker(sourceType: .camera)
                }
            })
        }
        sheet.addAction(UIAlertAction(title: petalGlowLoginText.cancel, style: .cancel))
        if let popover = sheet.popoverPresentationController {
            popover.sourceView = avatarButton
            popover.sourceRect = avatarButton.bounds
        }
        present(sheet, animated: true)
    }

    private func requestPhotoLibraryAccess(onGranted: @escaping () -> Void) {
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

    private func requestCameraAccess(onGranted: @escaping () -> Void) {
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

    private func presentAvatarPicker(sourceType: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }

    private func storeAvatarImage(_ image: UIImage) -> String? {
        guard let data = image.jpegData(compressionQuality: 0.88) else { return nil }
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("LidLuProfileAvatars", isDirectory: true)
        try? FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        let url = directory.appendingPathComponent(UUID().uuidString + ".jpg")
        do {
            try data.write(to: url, options: .atomic)
            return url.path
        } catch {
            return nil
        }
    }
}

extension pearlCredentialViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.host == "terms" {
            onTerms?()
        } else if URL.host == "privacy" {
            onPrivacy?()
        }
        return false
    }
}

extension pearlCredentialViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = (info[.editedImage] as? UIImage) ?? (info[.originalImage] as? UIImage)
        picker.dismiss(animated: true) { [weak self] in
            guard let self, let image else { return }
            self.selectedAvatarPath = self.storeAvatarImage(image)
            self.avatarButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
            self.avatarButton.imageView?.contentMode = .scaleAspectFill
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
