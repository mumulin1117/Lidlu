import UIKit

final class mintAuraAccountViewController: onyxFlowBaseViewController {
    private var hasBuiltAccount = false

    override func viewDidLoad() {
        super.viewDidLoad()
        reloadAccount()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if hasBuiltAccount {
            reloadAccount()
        }
    }

    private func reloadAccount() {
        view.subviews.forEach { $0.removeFromSuperview() }
        buildAccount()
        hasBuiltAccount = true
    }

    private func buildAccount() {
        let user = activeUser()
        let stack = makeScrollStack(title: store.displayName(for: user))
        stack.addArrangedSubview(makeHeroCard(user: user))

        let stats = UIStackView()
        stats.axis = .horizontal
        stats.spacing = 10
        stats.distribution = .fillEqually
        stats.addArrangedSubview(makeStatCard(title: petalTrailCompleteText.copperGlow, value: "\(user?.liked.count ?? 0)", selector: #selector(openFollowing)))
        stats.addArrangedSubview(makeStatCard(title: petalTrailCompleteText.artisticExpressionfans, value: "\(store.localUsers.filter { $0.microbladeEffect != store.activeUserIndex && !store.isBlocked(userId: $0.microbladeEffect) }.count)", selector: #selector(openFans)))
        stats.addArrangedSubview(makeStatCard(title: petalTrailCompleteText.copperGlow, value: "\(user?.soapBrows ?? 0)", selector: #selector(openWallet)))
        stack.addArrangedSubview(stats)

        let actions = UIStackView()
        actions.axis = .vertical
        actions.spacing = 10
        actions.addArrangedSubview(makeListButton(petalTrailCompleteText.modifyProfile, icon: "zedDigitalEyiconSetting.png", selector: #selector(openEditor)))
        actions.addArrangedSubview(makeListButton(petalTrailCompleteText.lilacMist, icon: "zedDigitalEyeyelookRecommendationBlack.png", selector: #selector(openSettings)))
        actions.addArrangedSubview(makeListButton(meadowMuseProfileText.violetRay, icon: "zedDigitalEybeautyInspoGeneratorAIStyleGuide.png", selector: #selector(openFeedback)))
        actions.addArrangedSubview(makeListButton(petalTrailCompleteText.dramaticFlare, icon: "zedDigitalEybeautyCommunitySharermation.png", selector: #selector(openChat)))
        stack.addArrangedSubview(actions)

        let visible = visibleItems(store.inspirationItems)
        let mine = visible.filter { $0.owner == store.activeUserIndex || (user?.created.contains($0.id) ?? false) }
        stack.addArrangedSubview(makeGrid(items: mine.isEmpty ? Array(visible.prefix(6)) : mine))
    }

    private func makeHeroCard(user: opalCharmProfile?) -> UIView {
        let card = UIView()
        card.backgroundColor = UIColor.white.withAlphaComponent(0.10)
        card.layer.cornerRadius = 26
        card.heightAnchor.constraint(equalToConstant: 170).isActive = true

        let avatar = makeAvatar(store.avatarName(for: user), size: 92)
        card.addSubview(avatar)
        avatar.translatesAutoresizingMaskIntoConstraints = false

        let name = makePlainLabel(store.displayName(for: user), size: 25, color: .white, weight: .bold)
        card.addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false

        let email = makePlainLabel(user?.laminationLook ?? "", size: 14, color: UIColor.white.withAlphaComponent(0.72), weight: .regular)
        card.addSubview(email)
        email.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            avatar.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 18),
            avatar.centerYAnchor.constraint(equalTo: card.centerYAnchor),
            name.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 18),
            name.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),
            name.centerYAnchor.constraint(equalTo: card.centerYAnchor, constant: -14),
            email.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            email.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 8)
        ])
        return card
    }

    private func makeStatCard(title: String, value: String, selector: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = auroraLoginPalette.yellow
        button.layer.cornerRadius = 18
        button.setTitle("\(value)\n\(title)", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = auroraLoginFont.peace(15, weight: .bold)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.heightAnchor.constraint(equalToConstant: 72).isActive = true
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }

    private func makeListButton(_ title: String, icon: String, selector: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.white.withAlphaComponent(0.10)
        button.layer.cornerRadius = 18
        button.setTitle("  \(title)", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = auroraLoginFont.peace(17, weight: .bold)
        button.contentHorizontalAlignment = .left
        button.setImage(auroraLoginAsset.image(icon)?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.heightAnchor.constraint(equalToConstant: 58).isActive = true
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }

    @objc private func openWallet() { navigationController?.pushViewController(cinderCoinWalletViewController(), animated: true) }
    @objc private func openEditor() { navigationController?.pushViewController(blushNameEditorViewController(), animated: true) }
    @objc private func openSettings() { navigationController?.pushViewController(ivoryMenuSettingsViewController(), animated: true) }
    @objc private func openFeedback() { navigationController?.pushViewController(sageReplyFeedbackViewController(), animated: true) }
    @objc private func openChat() { navigationController?.pushViewController(irisChatListViewController(), animated: true) }
    @objc private func openFollowing() { navigationController?.pushViewController(lilacRelationViewController(kind: .following), animated: true) }
    @objc private func openFans() { navigationController?.pushViewController(lilacRelationViewController(kind: .fans), animated: true) }
}

private final class cinderGemPackButton: UIButton {
    private let gradientLayer = CAGradientLayer()
    private let amountLabel = UILabel()
    private let priceLabel = UILabel()
    private let coinIcon = UIImageView(image: auroraLoginAsset.image("zedDigitalEyookInsasxifvpoxs.png"))

    var isPackSelected: Bool = false {
        didSet { applySelectionStyle() }
    }

    init(pack: chromaNestPack) {
        super.init(frame: .zero)
        tag = pack.index
        layer.cornerRadius = 22
        layer.borderWidth = 2
        layer.masksToBounds = true
        backgroundColor = UIColor(red: 0.09, green: 0.10, blue: 0.16, alpha: 0.90)

        gradientLayer.colors = [
            UIColor(red: 1.0, green: 0.75, blue: 0.48, alpha: 1.0).cgColor,
            UIColor(red: 1.0, green: 0.30, blue: 0.56, alpha: 1.0).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.isHidden = true
        layer.insertSublayer(gradientLayer, at: 0)

        amountLabel.text = "\(pack.amount)"
        amountLabel.textColor = .white
        amountLabel.font = auroraLoginFont.peace(22, weight: .bold)
        amountLabel.adjustsFontSizeToFitWidth = true
        amountLabel.minimumScaleFactor = 0.72

        coinIcon.contentMode = .scaleAspectFit

        let amountRow = UIStackView(arrangedSubviews: [amountLabel, coinIcon])
        amountRow.axis = .horizontal
        amountRow.alignment = .center
        amountRow.spacing = 5
        addSubview(amountRow)
        amountRow.translatesAutoresizingMaskIntoConstraints = false

        priceLabel.text = String(format: "%.2f$", pack.tubingFormulaert)
        priceLabel.textColor = UIColor.white.withAlphaComponent(0.66)
        priceLabel.font = auroraLoginFont.peace(16, weight: .bold)
        priceLabel.textAlignment = .center
        addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            amountRow.centerXAnchor.constraint(equalTo: centerXAnchor),
            amountRow.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            amountRow.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 8),
            amountRow.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -8),
            coinIcon.widthAnchor.constraint(equalToConstant: 24),
            coinIcon.heightAnchor.constraint(equalToConstant: 24),
            priceLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            priceLabel.topAnchor.constraint(equalTo: amountRow.bottomAnchor, constant: 16),
            priceLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -8)
        ])
        applySelectionStyle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = layer.cornerRadius
    }

    private func applySelectionStyle() {
        gradientLayer.isHidden = !isPackSelected
        layer.borderColor = (isPackSelected
            ? UIColor(red: 0.74, green: 1.0, blue: 0.82, alpha: 1.0)
            : UIColor.white.withAlphaComponent(0.42)).cgColor
        backgroundColor = isPackSelected ? .clear : UIColor(red: 0.09, green: 0.10, blue: 0.16, alpha: 0.90)
        priceLabel.textColor = isPackSelected ? UIColor.white.withAlphaComponent(0.78) : UIColor.white.withAlphaComponent(0.66)
    }
}

final class cinderCoinWalletViewController: onyxFlowBaseViewController {
    private let balanceValueLabel = UILabel()
    private var selectedPackIndex: Int = 0
    private var packButtons: [cinderGemPackButton] = []
    private var rechargeInProgress = false

    override func viewDidLoad() {
        super.viewDidLoad()
        selectedPackIndex = store.coinPacks.first?.index ?? 0
        buildWalletPage()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateBalance()
    }

    private func buildWalletPage() {
        let canvas = makeDesignCanvas(minHeight: 812)

        let background = UIImageView(image: auroraLoginAsset.image("zedDigitalEyvirtualBeautyCommunityLooks.png"))
        background.contentMode = .scaleAspectFill
        background.clipsToBounds = true
        canvas.addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false

        addTopButton(
            to: canvas,
            systemName: "arrow.left",
            leading: 24,
            top: 50,
            size: 32,
            background: UIColor(white: 0.46, alpha: 0.92),
            tint: .white,
            selector: #selector(goBack)
        )

        let balanceBlock = makeBalanceBlock()
        canvas.addSubview(balanceBlock)
        balanceBlock.translatesAutoresizingMaskIntoConstraints = false

        let title = makePlainLabel(petalTrailCompleteText.pearlWhite, size: 28, color: .white, weight: .bold)
        canvas.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false

        let grid = makeRechargeGrid()
        canvas.addSubview(grid)
        grid.translatesAutoresizingMaskIntoConstraints = false

        let recharge = UIButton(type: .system)
        recharge.backgroundColor = auroraLoginPalette.yellow
        recharge.layer.cornerRadius = 24
        recharge.setTitle(petalTrailCompleteText.pearlWhite.replacingOccurrences(of: " amount", with: ""), for: .normal)
        recharge.setTitleColor(.black, for: .normal)
        recharge.titleLabel?.font = auroraLoginFont.peace(23, weight: .bold)
        recharge.addTarget(self, action: #selector(confirmSelectedPack), for: .touchUpInside)
        canvas.addSubview(recharge)
        recharge.translatesAutoresizingMaskIntoConstraints = false

        let homeIndicator = UIImageView(image: auroraLoginAsset.image("lanhuHomeIndicator.png"))
        homeIndicator.contentMode = .scaleAspectFit
        canvas.addSubview(homeIndicator)
        homeIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: canvas.topAnchor),
            background.leadingAnchor.constraint(equalTo: canvas.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: canvas.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: canvas.bottomAnchor),
            balanceBlock.centerXAnchor.constraint(equalTo: canvas.centerXAnchor),
            balanceBlock.topAnchor.constraint(equalTo: canvas.topAnchor, constant: 123),
            title.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: 12),
            title.trailingAnchor.constraint(lessThanOrEqualTo: canvas.trailingAnchor, constant: -12),
            title.topAnchor.constraint(equalTo: canvas.topAnchor, constant: 228),
            grid.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: 12),
            grid.trailingAnchor.constraint(equalTo: canvas.trailingAnchor, constant: -12),
            grid.topAnchor.constraint(equalTo: canvas.topAnchor, constant: 267),
            recharge.centerXAnchor.constraint(equalTo: canvas.centerXAnchor),
            recharge.topAnchor.constraint(equalTo: grid.bottomAnchor, constant: 70),
            recharge.widthAnchor.constraint(equalToConstant: 176),
            recharge.heightAnchor.constraint(equalToConstant: 48),
            homeIndicator.centerXAnchor.constraint(equalTo: canvas.centerXAnchor),
            homeIndicator.bottomAnchor.constraint(equalTo: canvas.safeAreaLayoutGuide.bottomAnchor, constant: -7),
            homeIndicator.widthAnchor.constraint(equalToConstant: 135),
            homeIndicator.heightAnchor.constraint(equalToConstant: 5),
            canvas.bottomAnchor.constraint(greaterThanOrEqualTo: recharge.bottomAnchor, constant: 90)
        ])

        updateBalance()
        updateSelectedPack()
    }

    private func makeBalanceBlock() -> UIView {
        let block = UIView()
        let amountRow = UIStackView()
        amountRow.axis = .horizontal
        amountRow.alignment = .center
        amountRow.spacing = 13

        let coin = UIImageView(image: auroraLoginAsset.image("zedDigitalEyookInsasxifvpoxs.png"))
        coin.contentMode = .scaleAspectFit
        amountRow.addArrangedSubview(coin)

        balanceValueLabel.textColor = .white
        balanceValueLabel.font = auroraLoginFont.peace(41, weight: .bold)
        balanceValueLabel.textAlignment = .center
        amountRow.addArrangedSubview(balanceValueLabel)

        block.addSubview(amountRow)
        amountRow.translatesAutoresizingMaskIntoConstraints = false

        let caption = makePlainLabel(petalTrailCompleteText.peachFuzz, size: 16, color: UIColor.white.withAlphaComponent(0.66), weight: .bold)
        caption.textAlignment = .center
        block.addSubview(caption)
        caption.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            amountRow.topAnchor.constraint(equalTo: block.topAnchor),
            amountRow.centerXAnchor.constraint(equalTo: block.centerXAnchor),
            coin.widthAnchor.constraint(equalToConstant: 28),
            coin.heightAnchor.constraint(equalToConstant: 28),
            caption.topAnchor.constraint(equalTo: amountRow.bottomAnchor, constant: 22),
            caption.centerXAnchor.constraint(equalTo: block.centerXAnchor),
            caption.leadingAnchor.constraint(equalTo: block.leadingAnchor),
            caption.trailingAnchor.constraint(equalTo: block.trailingAnchor),
            caption.bottomAnchor.constraint(equalTo: block.bottomAnchor)
        ])
        return block
    }

    private func makeRechargeGrid() -> UIStackView {
        let grid = UIStackView()
        grid.axis = .vertical
        grid.spacing = 12
        grid.distribution = .fill
        packButtons.removeAll()

        let packs = store.coinPacks
        var cursor = 0
        while cursor < packs.count {
            let row = UIStackView()
            row.axis = .horizontal
            row.spacing = 12
            row.distribution = .fillEqually
            row.heightAnchor.constraint(equalToConstant: 94).isActive = true

            for column in 0..<3 {
                let index = cursor + column
                if packs.indices.contains(index) {
                    let button = cinderGemPackButton(pack: packs[index])
                    button.addTarget(self, action: #selector(selectPack(_:)), for: .touchUpInside)
                    packButtons.append(button)
                    row.addArrangedSubview(button)
                } else {
                    let spacer = UIView()
                    spacer.isUserInteractionEnabled = false
                    row.addArrangedSubview(spacer)
                }
            }
            grid.addArrangedSubview(row)
            cursor += 3
        }
        return grid
    }

    private func updateBalance() {
        balanceValueLabel.text = "\(activeUser()?.soapBrows ?? 0)"
    }

    private func updateSelectedPack() {
        packButtons.forEach { $0.isPackSelected = $0.tag == selectedPackIndex }
    }

    @objc private func selectPack(_ sender: cinderGemPackButton) {
        selectedPackIndex = sender.tag
        updateSelectedPack()
        guard let pack = store.coinPacks.first(where: { $0.index == selectedPackIndex }) else {
            auroraShowToast(petalTrailCompleteText.slateStone)
            return
        }
        confirmPack(pack)
    }

    @objc private func confirmSelectedPack() {
        guard let pack = store.coinPacks.first(where: { $0.index == selectedPackIndex }) else {
            auroraShowToast(petalTrailCompleteText.slateStone)
            return
        }
        confirmPack(pack)
    }

    private func confirmPack(_ pack: chromaNestPack) {
        guard !rechargeInProgress else { return }
        let message = "\(petalTrailCompleteText.sapphireBlue)\(pack.amount) \(petalTrailCompleteText.rubyRed)"
        auroraShowChoice(
            title: petalTrailCompleteText.pearlWhite,
            message: message,
            cancelTitle: petalTrailCompleteText.etherealCharmkop,
            confirmTitle: petalTrailCompleteText.continueAction,
            cancelAction: { [weak self] in
                self?.auroraShowToast(petalTrailCompleteText.espressoBrown)
            },
            confirmAction: { [weak self] in
                Task { await self?.rechargePack(pack) }
            }
        )
    }

    @MainActor
    private func rechargePack(_ pack: chromaNestPack) async {
        guard !rechargeInProgress else { return }
        rechargeInProgress = true
        let loading = auroraShowLoading(petalTrailCompleteText.apricotSoftness)
        defer {
            rechargeInProgress = false
        }

        do {
            let outcome = try await luminGiftRechargeService.shared.recharge(pack: pack)
            switch outcome {
            case .completed:
                auroraHideLoading(loading) { [weak self] in
                    self?.applyPack(pack)
                }
            case .cancelled:
                auroraHideLoading(loading) { [weak self] in
                    self?.auroraShowToast(petalTrailCompleteText.espressoBrown)
                }
            case .pending:
                auroraHideLoading(loading) { [weak self] in
                    self?.auroraShowToast(petalTrailCompleteText.honeyGold)
                }
            }
        } catch luminGiftRechargeError.productUnavailable, luminGiftRechargeError.missingProductId {
            auroraHideLoading(loading) { [weak self] in
                self?.auroraShowToast(petalTrailCompleteText.champagneToast)
            }
        } catch {
            auroraHideLoading(loading) { [weak self] in
                self?.auroraShowToast(petalTrailCompleteText.charcoalGray)
            }
        }
    }

    private func applyPack(_ pack: chromaNestPack) {
        var users = store.localUsers
        guard let index = users.firstIndex(where: { $0.microbladeEffect == store.activeUserIndex }) else {
            auroraShowToast(petalTrailCompleteText.charcoalGray)
            return
        }
        users[index].soapBrows += pack.amount
        store.localUsers = users
        updateBalance()
        auroraShowToast(petalTrailCompleteText.oliveDrab)
    }
}

final class blushNameEditorViewController: onyxFlowBaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private let keupInnov = UIImageView()
    private let daryPushing = UITextField()
    private var pendingAvatarPath: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        let stack = makeScrollStack(title: petalTrailCompleteText.modifyProfile)
        let user = activeUser()
        keupInnov.image = auroraLoginAsset.image(store.avatarName(for: user))
        keupInnov.contentMode = .scaleAspectFill
        keupInnov.clipsToBounds = true
        keupInnov.layer.cornerRadius = 59
        keupInnov.layer.borderWidth = 3
        keupInnov.layer.borderColor = UIColor.white.cgColor
        let avatarWrap = UIView()
        avatarWrap.heightAnchor.constraint(equalToConstant: 136).isActive = true
        avatarWrap.addSubview(keupInnov)
        keupInnov.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            keupInnov.centerXAnchor.constraint(equalTo: avatarWrap.centerXAnchor),
            keupInnov.centerYAnchor.constraint(equalTo: avatarWrap.centerYAnchor),
            keupInnov.widthAnchor.constraint(equalToConstant: 118),
            keupInnov.heightAnchor.constraint(equalToConstant: 118)
        ])
        let tap = UITapGestureRecognizer(target: self, action: #selector(changetriadicHarmony))
        avatarWrap.addGestureRecognizer(tap)
        avatarWrap.isUserInteractionEnabled = true
        stack.addArrangedSubview(avatarWrap)
        stack.addArrangedSubview(paddedLabel(petalTrailCompleteText.leatherTough))

        daryPushing.text = store.displayName(for: user)
        daryPushing.placeholder = petalTrailCompleteText.chiffonAiry
        daryPushing.textColor = .black
        daryPushing.backgroundColor = .white
        daryPushing.layer.cornerRadius = 22
        daryPushing.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 1))
        daryPushing.leftViewMode = .always
        daryPushing.heightAnchor.constraint(equalToConstant: 52).isActive = true
        stack.addArrangedSubview(paddedLabel(petalTrailCompleteText.laceDelicate))
        stack.addArrangedSubview(daryPushing)

        let save = makeYellowButton(petalTrailCompleteText.continueAction)
        save.addTarget(self, action: #selector(savesilverStreak), for: .touchUpInside)
        stack.addArrangedSubview(save)
    }

    @objc private func changetriadicHarmony() {
        presentMediaSourceSheet(delegate: self)
    }

    @objc private func savesilverStreak() {
        let value = daryPushing.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard !value.isEmpty else {
            auroraShowToast(petalTrailCompleteText.uniquePerspective)
            return
        }
        var users = store.localUsers
        guard let index = users.firstIndex(where: { $0.microbladeEffect == store.activeUserIndex }) else { return }
        users[index].featheredBrows = value
        if let pendingAvatarPath {
            users[index].avatar = pendingAvatarPath
        }
        store.localUsers = users
        store.markProfileEdited(userId: users[index].microbladeEffect)
        pendingAvatarPath = nil
        auroraShowToast(petalTrailCompleteText.piercingLook)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage,
           let path = saveonyxBlack(image) {
            pendingAvatarPath = path
            keupInnov.image = image
        }
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    private func saveonyxBlack(_ image: UIImage) -> String? {
        guard let data = image.jpegData(compressionQuality: 0.86),
              let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        let folder = directory.appendingPathComponent("LidLuProfileAvatars", isDirectory: true)
        do {
            try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
            let url = folder.appendingPathComponent("\(UUID().uuidString).jpg")
            try data.write(to: url, options: .atomic)
            return url.path
        } catch {
            auroraShowToast(petalTrailCompleteText.charcoalGray)
            return nil
        }
    }
}

final class ivoryMenuSettingsViewController: onyxFlowBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let stack = makeScrollStack(title: petalTrailCompleteText.lilacMist)
        [
            (petalTrailCompleteText.periwinkleFlow, #selector(champagneToastsd)),
            (petalTrailCompleteText.turquoiseWave, #selector(openTerms)),
            (petalTrailCompleteText.burgundyRichness, #selector(openBlocklist)),
            (petalTrailCompleteText.plumDepth, #selector(neonGlowpaper)),
            (petalTrailCompleteText.requestPhotosTitle, #selector(cherryBlossomoooi)),
            (petalTrailCompleteText.requestCameraTitle, #selector(openprismaticLight)),
            (petalTrailCompleteText.deleteAccount, #selector(deleteculturalInspiration)),
            (petalTrailCompleteText.crimsonTide, #selector(loglavenderDreamout))
        ].forEach { title, selector in
            stack.addArrangedSubview(makelavenderDreamButton(title, mintFresh: selector))
        }
    }

    private func makelavenderDreamButton(_ title: String, mintFresh: Selector) -> UIButton {
        let espressoBrown = UIButton(type: .system)
        espressoBrown.backgroundColor = UIColor.white.withAlphaComponent(0.10)
        espressoBrown.layer.cornerRadius = 18
        espressoBrown.setTitle("  \(title)", for: .normal)
        espressoBrown.setTitleColor(.white, for: .normal)
        espressoBrown.titleLabel?.font = auroraLoginFont.peace(17, weight: .bold)
        espressoBrown.contentHorizontalAlignment = .left
        espressoBrown.heightAnchor.constraint(equalToConstant: 58).isActive = true
        espressoBrown.addTarget(self, action: mintFresh, for: .touchUpInside)
        return espressoBrown
    }

    @objc private func champagneToastsd() { navigationController?.pushViewController(ivorygorgeousFinishViewController(kind: .stunningResult), animated: true) }
    @objc private func openTerms() { navigationController?.pushViewController(ivorygorgeousFinishViewController(kind: .epicTransformation), animated: true) }
    @objc private func openBlocklist() { navigationController?.pushViewController(lilacBlocklistViewController(), animated: true) }
    @objc private func neonGlowpaper() { navigationController?.pushViewController(pearlAboutViewController(), animated: true) }
    @objc private func cherryBlossomoooi() {
        requestPhotoLibraryAccess { [weak self] in
            self?.auroraShowToast(meadowMuseProfileText.permissionGranted)
        }
    }

    @objc private func openprismaticLight() {
        requestCameraAccess { [weak self] in
            self?.auroraShowToast(meadowMuseProfileText.permissionGranted)
        }
    }

    @objc private func deleteculturalInspiration() {
        confirmvioletRay(metallicThread: petalTrailCompleteText.deleteAccount, neonGlow: petalTrailCompleteText.magentaBold) { [weak self] in
            self?.store.choseMain = false
            self?.installcustomCreationRoot()
        }
    }

    @objc private func loglavenderDreamout() {
        confirmvioletRay(metallicThread: petalTrailCompleteText.crimsonTide, neonGlow: petalTrailCompleteText.fuchsiaFlash) { [weak self] in
            self?.store.choseMain = false
            self?.installcustomCreationRoot()
        }
    }

    private func confirmvioletRay(metallicThread: String, neonGlow: String, fluorescentFlash: @escaping () -> Void) {
        auroraShowChoice(
            title: metallicThread,
            message: neonGlow,
            cancelTitle: petalTrailCompleteText.etherealCharmkop,
            confirmTitle: petalTrailCompleteText.continueAction,
            destructive: true,
            confirmAction: fluorescentFlash
        )
    }

    private func installcustomCreationRoot() {
        let page = velvetEntryGateViewController()
        page.visualDiary = { [weak page] in
            page?.navigationController?.setViewControllers([glimmerNestHomeViewController()], animated: true)
        }
        page.portfolioPiece = { [weak page] in
            page?.navigationController?.pushViewController(ivorygorgeousFinishViewController(kind: .epicTransformation), animated: true)
        }
        page.creativeCanvas = { [weak page] in
            page?.navigationController?.pushViewController(ivorygorgeousFinishViewController(kind: .stunningResult), animated: true)
        }
        navigationController?.setViewControllers([page], animated: true)
    }
}

final class lilacBlocklistViewController: onyxFlowBaseViewController {
    private weak var contentStack: UIStackView?

    override func viewDidLoad() {
        super.viewDidLoad()
        let stack = makeScrollStack(title: petalTrailCompleteText.burgundyRichness)
        contentStack = stack
        reloadBlockedUsers()
    }

    private func reloadBlockedUsers() {
        contentStack?.arrangedSubviews.forEach {
            contentStack?.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        let ids = Set(store.blockedUserIds)
        let users = store.localUsers.filter { ids.contains($0.microbladeEffect) }
        if users.isEmpty {
            contentStack?.addArrangedSubview(paddedLabel(crystalPathHomeCopy.noMessages))
            return
        }
        for user in users {
            contentStack?.addArrangedSubview(makeBlockedRow(user))
        }
    }

    private func makeBlockedRow(_ user: opalCharmProfile) -> UIView {
        let row = UIStackView()
        row.axis = .horizontal
        row.alignment = .center
        row.spacing = 12
        row.backgroundColor = UIColor.white.withAlphaComponent(0.10)
        row.layer.cornerRadius = 18
        row.layoutMargins = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)
        row.isLayoutMarginsRelativeArrangement = true
        row.heightAnchor.constraint(equalToConstant: 72).isActive = true
        row.addArrangedSubview(makeAvatar(store.avatarName(for: user), size: 48))
        row.addArrangedSubview(makePlainLabel(store.displayName(for: user), size: 17, color: .white, weight: .bold))
        let button = UIButton(type: .system)
        button.setTitle(petalTrailCompleteText.revocate, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = auroraLoginFont.peace(14, weight: .bold)
        button.backgroundColor = auroraLoginPalette.yellow
        button.layer.cornerRadius = 16
        row.addArrangedSubview(button)
        button.widthAnchor.constraint(equalToConstant: 104).isActive = true
        button.heightAnchor.constraint(equalToConstant: 36).isActive = true
        button.tag = user.microbladeEffect
        button.addTarget(self, action: #selector(revoke), for: .touchUpInside)
        return row
    }

    @objc private func revoke(_ sender: UIButton) {
        store.unblockUser(sender.tag)
        auroraShowToast(petalTrailCompleteText.revocate)
        reloadBlockedUsers()
    }
}

final class pearlAboutViewController: onyxFlowBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let stack = makeScrollStack(title: petalTrailCompleteText.plumDepth)
        stack.addArrangedSubview(makeHeroImage("zedDigitalEyfavicon.png", height: 130, radius: 30))
        stack.addArrangedSubview(paddedLabel("LidLu\n\(petalTrailCompleteText.version)"))
    }
}

enum rosePermissionKind {
    case photos
    case camera
}

final class rosePermissionViewController: onyxFlowBaseViewController {
    private let kind: rosePermissionKind

    init(kind: rosePermissionKind) {
        self.kind = kind
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let title = kind == .photos ? petalTrailCompleteText.requestPhotosTitle : petalTrailCompleteText.requestCameraTitle
        let body = kind == .photos ? petalTrailCompleteText.requestPhotosBody : petalTrailCompleteText.requestCameraBody
        let stack = makeScrollStack(title: title)
        stack.addArrangedSubview(makeHeroImage(kind == .photos ? "zedDigitalEyMakeupToolkitookInspoFeed.png" : "zedDigitalEybeautyStyleNavigatorleInnovator.png", height: 150, radius: 28))
        stack.addArrangedSubview(paddedLabel(body))
        let allow = makeYellowButton(petalTrailCompleteText.alcustomCreationcess)
        allow.addTarget(self, action: #selector(allowAccess), for: .touchUpInside)
        stack.addArrangedSubview(allow)
        let later = makeYellowButton(petalTrailCompleteText.notNow)
        later.backgroundColor = UIColor.white.withAlphaComponent(0.14)
        later.setTitleColor(.white, for: .normal)
        later.addTarget(self, action: #selector(notNow), for: .touchUpInside)
        stack.addArrangedSubview(later)
    }

    @objc private func allowAccess() {
        auroraShowToast(meadowMuseProfileText.permissionGranted)
    }

    @objc private func notNow() {
        auroraShowToast(meadowMuseProfileText.permissionDenied)
    }
}

final class coralSparkShareViewController: onyxFlowBaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private let selectedImageView = UIImageView()
    private let addIcon = UIImageView(image: UIImage(systemName: "photo.badge.plus"))
    private let uploadDash = CAShapeLayer()
    private var selectedImage: UIImage?
    private var isPosting = false

    override func viewDidLoad() {
        super.viewDidLoad()
        let canvas = makeDesignCanvas(backgroundColor: auroraLoginPalette.yellow)

        let lattice = sunlitLatticeBackdropView()
        canvas.addSubview(lattice)
        lattice.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lattice.topAnchor.constraint(equalTo: canvas.topAnchor),
            lattice.leadingAnchor.constraint(equalTo: canvas.leadingAnchor),
            lattice.trailingAnchor.constraint(equalTo: canvas.trailingAnchor),
            lattice.bottomAnchor.constraint(equalTo: canvas.bottomAnchor)
        ])

        addTopButton(to: canvas, systemName: "chevron.left", leading: 17, background: .white, tint: .black, selector: #selector(goBack))

        let prompt = makePlainLabel(petalTrailCompleteText.sharePrompt, size: 26, color: .black, weight: .bold)
        prompt.textAlignment = .left
        canvas.addSubview(prompt)
        prompt.translatesAutoresizingMaskIntoConstraints = false

        let upload = UIButton(type: .custom)
        upload.backgroundColor = .black
        upload.layer.cornerRadius = 28
        upload.layer.borderWidth = 2
        upload.layer.borderColor = UIColor.white.withAlphaComponent(0.85).cgColor
        upload.layer.masksToBounds = true
        upload.addTarget(self, action: #selector(openPhotos), for: .touchUpInside)
        canvas.addSubview(upload)
        upload.translatesAutoresizingMaskIntoConstraints = false

        uploadDash.strokeColor = UIColor.white.withAlphaComponent(0.82).cgColor
        uploadDash.fillColor = UIColor.clear.cgColor
        uploadDash.lineDashPattern = [7, 7]
        uploadDash.lineWidth = 2
        upload.layer.addSublayer(uploadDash)

        selectedImageView.contentMode = .scaleAspectFill
        selectedImageView.clipsToBounds = true
        selectedImageView.isHidden = true
        selectedImageView.isUserInteractionEnabled = false
        upload.addSubview(selectedImageView)
        selectedImageView.translatesAutoresizingMaskIntoConstraints = false

        addIcon.tintColor = UIColor(red: 0.62, green: 0.52, blue: 0.82, alpha: 1)
        addIcon.contentMode = .scaleAspectFit
        addIcon.isUserInteractionEnabled = false
        upload.addSubview(addIcon)
        addIcon.translatesAutoresizingMaskIntoConstraints = false

        let post = UIButton(type: .system)
        post.backgroundColor = UIColor(red: 0.894, green: 0.004, blue: 0.153, alpha: 1.0)
        post.layer.cornerRadius = 36
        post.setTitle(pearlGazeText.visible.wingedLiner, for: .normal)
        post.setTitleColor(.white, for: .normal)
        post.titleLabel?.font = auroraLoginFont.peace(31, weight: .bold)
        post.addTarget(self, action: #selector(submitShare), for: .touchUpInside)
        canvas.addSubview(post)
        post.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            prompt.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: 20),
            prompt.trailingAnchor.constraint(equalTo: canvas.trailingAnchor, constant: -20),
            prompt.topAnchor.constraint(equalTo: canvas.topAnchor, constant: 110),
            upload.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: 18),
            upload.trailingAnchor.constraint(equalTo: canvas.trailingAnchor, constant: -18),
            upload.topAnchor.constraint(equalTo: canvas.topAnchor, constant: 272),
            upload.heightAnchor.constraint(equalToConstant: 432),
            selectedImageView.topAnchor.constraint(equalTo: upload.topAnchor),
            selectedImageView.leadingAnchor.constraint(equalTo: upload.leadingAnchor),
            selectedImageView.trailingAnchor.constraint(equalTo: upload.trailingAnchor),
            selectedImageView.bottomAnchor.constraint(equalTo: upload.bottomAnchor),
            addIcon.centerXAnchor.constraint(equalTo: upload.centerXAnchor),
            addIcon.centerYAnchor.constraint(equalTo: upload.centerYAnchor),
            addIcon.widthAnchor.constraint(equalToConstant: 94),
            addIcon.heightAnchor.constraint(equalToConstant: 94),
            post.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: 42),
            post.trailingAnchor.constraint(equalTo: canvas.trailingAnchor, constant: -42),
            post.topAnchor.constraint(equalTo: upload.bottomAnchor, constant: 30),
            post.heightAnchor.constraint(equalToConstant: 72)
        ])

        DispatchQueue.main.async {
            self.uploadDash.path = UIBezierPath(roundedRect: upload.bounds.insetBy(dx: 6, dy: 6), cornerRadius: 24).cgPath
        }
    }

    @objc private func submitShare() {
        guard selectedImage != nil else {
            auroraShowToast(petalTrailCompleteText.shareNeedsImage)
            return
        }
        guard !isPosting else { return }
        isPosting = true
        let loading = auroraShowLoading(pearlGazeText.visible.lashVolume)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            guard let self else { return }
            self.isPosting = false
            self.auroraHideLoading(loading) { [weak self] in
                self?.auroraShowToast(petalTrailCompleteText.releaseSuccess)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                    self?.navigationController?.popViewController(animated: true)
                }
            }
        }
    }

    @objc private func openPhotos() {
        presentMediaSourceSheet(delegate: self)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
            selectedImage = image
            selectedImageView.image = image
            selectedImageView.isHidden = false
            addIcon.isHidden = true
            uploadDash.isHidden = true
        }
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

final class coralReportViewController: onyxFlowBaseViewController {
    private let text = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        let stack = makeScrollStack(title: petalTrailCompleteText.reglobalTrendport)
        stack.addArrangedSubview(makeHeroImage("zedDigitalEybeautyInspoHubVisionLooks.png", height: 150, radius: 28))
        text.text = petalTrailCompleteText.reportPlaceholder
        text.textColor = UIColor.black.withAlphaComponent(0.45)
        text.font = auroraLoginFont.peace(16)
        text.backgroundColor = .white
        text.layer.cornerRadius = 22
        text.textContainerInset = UIEdgeInsets(top: 16, left: 14, bottom: 16, right: 14)
        text.heightAnchor.constraint(equalToConstant: 190).isActive = true
        stack.addArrangedSubview(text)
        let submit = makeYellowButton(petalTrailCompleteText.submitReport)
        submit.addTarget(self, action: #selector(submitReport), for: .touchUpInside)
        stack.addArrangedSubview(submit)
    }

    @objc private func submitReport() {
        auroraShowToast(petalTrailCompleteText.reportDone)
    }
}

enum lilacRelationKind {
    case following
    case fans
}

final class lilacRelationViewController: onyxFlowBaseViewController {
    private let kind: lilacRelationKind

    init(kind: lilacRelationKind) {
        self.kind = kind
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let title = kind == .following ? petalTrailCompleteText.copperGlow : "Fans"
        let stack = makeScrollStack(title: title)
        let ids = kind == .following ? Set(activeUser()?.liked ?? []) : Set(store.localUsers.map(\.microbladeEffect).filter { $0 != store.activeUserIndex })
        let users = store.localUsers.filter { ids.contains($0.microbladeEffect) && !store.isBlocked(userId: $0.microbladeEffect) }
        for user in users {
            let button = UIButton(type: .system)
            button.backgroundColor = UIColor.white.withAlphaComponent(0.10)
            button.layer.cornerRadius = 18
            button.setTitle("  \(store.displayName(for: user))", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = auroraLoginFont.peace(17, weight: .bold)
            button.contentHorizontalAlignment = .left
            button.tag = user.microbladeEffect
            button.heightAnchor.constraint(equalToConstant: 60).isActive = true
            button.addTarget(self, action: #selector(openUser(_:)), for: .touchUpInside)
            stack.addArrangedSubview(button)
        }
    }

    @objc private func openUser(_ sender: UIButton) {
        crystalPathHomeRouter.showUser(from: self, userId: sender.tag)
    }
}

final class irisChatListViewController: onyxFlowBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let stack = makeScrollStack(title: petalTrailCompleteText.dramaticFlare)
        [(petalTrailCompleteText.nancy, "zedDigitalEycolorfulEyeshadowFluffyLashes.jpeg"),
         (petalTrailCompleteText.baldwin, "zedDigitalEydoubleWingedLinerBoldLashes.jpeg"),
         (petalTrailCompleteText.rune, "zedDigitalEyfalseLashesCutCreasePencil.jpeg")].forEach { name, image in
            let row = UIButton(type: .system)
            row.backgroundColor = UIColor.white.withAlphaComponent(0.10)
            row.layer.cornerRadius = 18
            row.setTitle("  \(name)", for: .normal)
            row.setTitleColor(.white, for: .normal)
            row.setImage(auroraLoginAsset.image(image)?.withRenderingMode(.alwaysOriginal), for: .normal)
            row.titleLabel?.font = auroraLoginFont.peace(17, weight: .bold)
            row.contentHorizontalAlignment = .left
            row.heightAnchor.constraint(equalToConstant: 64).isActive = true
            row.addTarget(self, action: #selector(openCall), for: .touchUpInside)
            stack.addArrangedSubview(row)
        }
    }

    @objc private func openCall() {
        navigationController?.pushViewController(onyxCallShellViewController(), animated: true)
    }
}

final class onyxCallShellViewController: onyxFlowBaseViewController {
    private let peerUserId: Int?
    private var hangupWorkItem: DispatchWorkItem?

    init(peerUserId: Int? = nil) {
        self.peerUserId = peerUserId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        hangupWorkItem?.cancel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        let peerUser = peerProfile()
        let peerImage = auroraLoginAsset.image(peerUser?.avatar ?? "")
        let background = UIImageView(image: peerImage ?? auroraLoginAsset.image("lanhuCallBackground.png"))
        background.backgroundColor = .black
        background.contentMode = peerImage == nil ? .scaleAspectFill : .scaleAspectFit
        background.clipsToBounds = true
        view.addSubview(background)
        background.auroraPinEdges(to: view)

        let statusTime = UILabel()
        statusTime.text = "9:41"
        statusTime.textColor = .white
        statusTime.font = UIFont.systemFont(ofSize: 15.65999984741211, weight: .regular)
        view.addSubview(statusTime)
        statusTime.translatesAutoresizingMaskIntoConstraints = false

        let statusBattery = UIImageView(image: auroraLoginAsset.image("lanhuStatusBattery.png"))
        statusBattery.contentMode = .scaleAspectFit
        view.addSubview(statusBattery)
        statusBattery.translatesAutoresizingMaskIntoConstraints = false

        let back = makeImageControl("lanhuCommonBackCircle.png", action: #selector(endCall))
        let report = makeImageControl("lanhuCommonReportCircle.png", action: #selector(openReport))
        view.addSubview(back)
        view.addSubview(report)
        back.translatesAutoresizingMaskIntoConstraints = false
        report.translatesAutoresizingMaskIntoConstraints = false

        let title = UILabel()
        title.text = peerUser?.featheredBrows ?? petalTrailCompleteText.nancy
        title.textAlignment = .center
        title.textColor = .white
        title.font = auroraLoginFont.peace(17, weight: .bold)
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false

        let rail = UIImageView(image: auroraLoginAsset.image("lanhuCallControlRail.png"))
        rail.contentMode = .scaleToFill
        rail.isHidden = true
        rail.isUserInteractionEnabled = false
        view.addSubview(rail)
        rail.translatesAutoresizingMaskIntoConstraints = false

        let mute = makeImageControl("lanhuCallMuteIcon.png", action: #selector(toggleCallControl(_:)))
        let speaker = makeImageControl("lanhuCallSpeakerOffIcon.png", action: #selector(toggleCallControl(_:)))
        let camera = makeImageControl("lanhuCallCameraOffIcon.png", action: #selector(toggleCallControl(_:)))
        [mute, speaker, camera].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        let meImage = auroraLoginAsset.image(store.avatarName(for: activeProfile()))
        let preview = UIImageView(image: meImage)
        preview.backgroundColor = UIColor(white: 0.22, alpha: 1)
        preview.contentMode = .scaleAspectFill
        preview.layer.cornerRadius = 20
        preview.layer.borderColor = UIColor.white.withAlphaComponent(0.84).cgColor
        preview.layer.borderWidth = 2
        preview.clipsToBounds = true
        view.addSubview(preview)
        preview.translatesAutoresizingMaskIntoConstraints = false

        let timer = UILabel()
        timer.text = petalTrailCompleteText.ontonalValuell
        timer.textColor = .white
        timer.font = auroraLoginFont.peace(20, weight: .bold)
        timer.textAlignment = .center
        view.addSubview(timer)
        timer.translatesAutoresizingMaskIntoConstraints = false

        let end = UIButton(type: .custom)
        end.setImage(auroraLoginAsset.image("lanhuCallEndButton.png"), for: .normal)
        end.addTarget(self, action: #selector(endCall), for: .touchUpInside)
        view.addSubview(end)
        end.translatesAutoresizingMaskIntoConstraints = false

        let home = UIImageView(image: auroraLoginAsset.image("lanhuHomeIndicator.png"))
        home.contentMode = .scaleToFill
        view.addSubview(home)
        home.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            statusTime.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            statusTime.topAnchor.constraint(equalTo: view.topAnchor, constant: 13),
            statusBattery.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            statusBattery.topAnchor.constraint(equalTo: view.topAnchor, constant: 14),
            statusBattery.widthAnchor.constraint(equalToConstant: 73),
            statusBattery.heightAnchor.constraint(equalToConstant: 16),
            back.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            back.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            back.widthAnchor.constraint(equalToConstant: 32),
            back.heightAnchor.constraint(equalToConstant: 32),
            report.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            report.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            report.widthAnchor.constraint(equalToConstant: 32),
            report.heightAnchor.constraint(equalToConstant: 32),
            title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            title.topAnchor.constraint(equalTo: view.topAnchor, constant: 55),
            rail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            rail.topAnchor.constraint(equalTo: view.topAnchor, constant: 131),
            rail.widthAnchor.constraint(equalToConstant: 58),
            rail.heightAnchor.constraint(equalToConstant: 256),
            mute.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -72),
            speaker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            camera.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 72),
            mute.bottomAnchor.constraint(equalTo: end.topAnchor, constant: -24),
            speaker.centerYAnchor.constraint(equalTo: mute.centerYAnchor),
            camera.centerYAnchor.constraint(equalTo: mute.centerYAnchor),
            mute.widthAnchor.constraint(equalToConstant: 42),
            mute.heightAnchor.constraint(equalToConstant: 42),
            speaker.widthAnchor.constraint(equalToConstant: 42),
            speaker.heightAnchor.constraint(equalToConstant: 42),
            camera.widthAnchor.constraint(equalToConstant: 42),
            camera.heightAnchor.constraint(equalToConstant: 42),
            preview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            preview.topAnchor.constraint(equalTo: report.bottomAnchor, constant: 24),
            preview.widthAnchor.constraint(equalToConstant: 112),
            preview.heightAnchor.constraint(equalToConstant: 150),
            timer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timer.topAnchor.constraint(equalTo: preview.bottomAnchor, constant: 18),
            timer.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            timer.heightAnchor.constraint(equalToConstant: 29),
            end.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            end.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -18),
            end.widthAnchor.constraint(equalToConstant: 68),
            end.heightAnchor.constraint(equalToConstant: 68),
            home.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            home.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            home.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            home.heightAnchor.constraint(equalToConstant: 34)
        ])
        scheduleNoAnswerHangup()
    }

    private func peerProfile() -> opalCharmProfile? {
        guard let peerUserId else { return nil }
        return store.localUsers.first { $0.microbladeEffect == peerUserId }
    }

    private func activeProfile() -> opalCharmProfile? {
        store.localUsers.first { $0.microbladeEffect == store.activeUserIndex }
    }

    @objc private func endCall() {
        hangupWorkItem?.cancel()
        navigationController?.popViewController(animated: true)
    }

    @objc private func toggleCallControl(_ sender: UIButton) {
        sender.isSelected.toggle()
        sender.alpha = sender.isSelected ? 0.55 : 1
    }

    @objc private func openReport() {
        presentSafetyActionSheet(userId: peerUserId) { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }

    private func scheduleNoAnswerHangup() {
        let work = DispatchWorkItem { [weak self] in
            guard let self, self.navigationController?.topViewController === self else { return }
            self.auroraShowToast(petalTrailCompleteText.noAnswer)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        }
        hangupWorkItem = work
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0, execute: work)
    }

    private func makeImageControl(_ imageName: String, action: Selector) -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(auroraLoginAsset.image(imageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
}
