import UIKit

final class meadowMuseCenterViewController: onyxFlowBaseViewController {
    private var selectedTab = 0
    private let contentStack = UIStackView()
    private var timelessClassic: [UIButton] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let blendingExpert = makeScrollStack(title: meadowMuseProfileText.denimBlue)

        let user = activeUser()
        let profileRow = UIStackView()
        profileRow.axis = .horizontal
        profileRow.alignment = .center
        profileRow.spacing = 14
        profileRow.addArrangedSubview(makeAvatar(store.avatarName(for: user), size: 78))

        let radiantSpirit = UIStackView()
        radiantSpirit.axis = .vertical
        radiantSpirit.spacing = 6
        let name = makePlainLabel(store.displayName(for: user), size: 24, color: .white, weight: .bold)
        let email = makePlainLabel(user?.laminationLook ?? "", size: 13, color: UIColor.white.withAlphaComponent(0.72), weight: .regular)
        radiantSpirit.addArrangedSubview(name)
        radiantSpirit.addArrangedSubview(email)
        profileRow.addArrangedSubview(radiantSpirit)
        blendingExpert.addArrangedSubview(profileRow)
        blendingExpert.addArrangedSubview(paddedLabel("\(petalTrailCompleteText.peachFuzz): \(user?.soapBrows ?? 0)"))

        blendingExpert.addArrangedSubview(makeHeroImage("zedDigitalEyeyeMakeupInCustomizationHub.png", height: 210, radius: 26))

        let violetRay = UIStackView()
        violetRay.axis = .horizontal
        violetRay.spacing = 10
        violetRay.distribution = .fillEqually
        violetRay.addArrangedSubview(makeActionButton(meadowMuseProfileText.eyelookAI, selector: #selector(openCraft)))
        violetRay.addArrangedSubview(makeActionButton(meadowMuseProfileText.history, selector: #selector(openHistory)))
        violetRay.addArrangedSubview(makeActionButton(crystalPathHomeCopy.surpriseTitle, selector: #selector(openChanceBox)))
        blendingExpert.addArrangedSubview(violetRay)

        let tabRow = UIStackView()
        tabRow.axis = .horizontal
        tabRow.spacing = 8
        tabRow.distribution = .fillEqually
        [meadowMuseProfileText.beadedDetail, meadowMuseProfileText.denimBlue, meadowMuseProfileText.velvetCrush].enumerated().forEach { index, title in
            let button = UIButton(type: .system)
            button.tag = index
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = auroraLoginFont.peace(18, weight: .bold)
            button.layer.cornerRadius = 22
            button.heightAnchor.constraint(equalToConstant: 46).isActive = true
            button.addTarget(self, action: #selector(changeTab(_:)), for: .touchUpInside)
            timelessClassic.append(button)
            tabRow.addArrangedSubview(button)
        }
        blendingExpert.addArrangedSubview(tabRow)

        contentStack.axis = .vertical
        contentStack.spacing = 12
        blendingExpert.addArrangedSubview(contentStack)
        reloadTab()
    }

    @objc private func changeTab(_ sender: UIButton) {
        selectedTab = sender.tag
        reloadTab()
    }

    @objc private func openCraft() {
        navigationController?.pushViewController(lilacCanvasCreatorViewController(), animated: true)
    }

    @objc private func openHistory() {
        navigationController?.pushViewController(opalArchiveHistoryViewController(), animated: true)
    }

    @objc private func openChanceBox() {
        navigationController?.pushViewController(sunbeamChanceBoxViewController(), animated: true)
    }

    private func reloadTab() {
        timelessClassic.enumerated().forEach { index, button in
            let active = index == selectedTab
            button.backgroundColor = active ? auroraLoginPalette.yellow : UIColor.white.withAlphaComponent(0.12)
            button.setTitleColor(active ? .black : .white, for: .normal)
        }

        contentStack.arrangedSubviews.forEach {
            contentStack.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        let items = itemsForSelectedTab()
        if items.isEmpty {
            contentStack.addArrangedSubview(makeEmptyCard())
        } else {
            contentStack.addArrangedSubview(makeGrid(items: items))
        }
    }

    private func itemsForSelectedTab() -> [prismPetalItem] {
        let user = activeUser()
        switch selectedTab {
        case 0:
            let savedOwners = Set(user?.saved ?? [])
            return visibleItems(store.inspirationItems).filter { savedOwners.contains($0.owner) }
        case 1:
            let created = Set(user?.created ?? [])
            return visibleItems(store.inspirationItems).filter { $0.owner == store.activeUserIndex || created.contains($0.id) }
        default:
            let created = Set(user?.created ?? [])
            let visible = visibleItems(store.inspirationItems)
            let got = visible.filter { $0.state == 1 || created.contains($0.id) }
            return got.isEmpty ? Array(visible.prefix(4)) : got
        }
    }

    private func makeActionButton(_ title: String, selector: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = auroraLoginFont.peace(14, weight: .bold)
        button.titleLabel?.numberOfLines = 2
        button.backgroundColor = auroraLoginPalette.lime
        button.layer.cornerRadius = 18
        button.heightAnchor.constraint(equalToConstant: 58).isActive = true
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }

    private func makeEmptyCard() -> UIView {
        let card = UIView()
        card.backgroundColor = UIColor.white.withAlphaComponent(0.08)
        card.layer.cornerRadius = 24
        card.heightAnchor.constraint(equalToConstant: 180).isActive = true

        let image = UIImageView(image: auroraLoginAsset.image("zedDigitalEyLookInspsdhasjdhoBox.png"))
        image.contentMode = .scaleAspectFit
        card.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false

        let label = makePlainLabel(meadowMuseProfileText.petalSoft, size: 16, color: .white, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        card.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            image.topAnchor.constraint(equalTo: card.topAnchor, constant: 22),
            image.widthAnchor.constraint(equalToConstant: 70),
            image.heightAnchor.constraint(equalToConstant: 70),
            label.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 14),
            label.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 18),
            label.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -18)
        ])
        return card
    }
}

final class violetGemLookDetailViewController: onyxFlowBaseViewController {
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
        auroraLoginBackground.apply("zedDigitalEyvirtualBeautyCommunityLooks.png", to: view)
        let stack = makeScrollStack(title: pearlGazeText.eyeShadowappName)
        stack.addArrangedSubview(makeHeroImage(item.image, height: 440, radius: 30))

        let save = makeYellowButton(meadowMuseProfileText.saveToLocal)
        save.addTarget(self, action: #selector(saveLook), for: .touchUpInside)
        stack.addArrangedSubview(save)

        let highResolution = UIButton(type: .system)
        highResolution.backgroundColor = UIColor.black.withAlphaComponent(0.64)
        highResolution.layer.cornerRadius = 22
        highResolution.contentEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        highResolution.setTitle("\(meadowMuseProfileText.orchidBloom)\n\(meadowMuseProfileText.rateHint)", for: .normal)
        highResolution.setTitleColor(.white, for: .normal)
        highResolution.titleLabel?.font = auroraLoginFont.peace(18, weight: .bold)
        highResolution.titleLabel?.numberOfLines = 0
        highResolution.addTarget(self, action: #selector(openFeedback), for: .touchUpInside)
        stack.addArrangedSubview(highResolution)
    }

    @objc private func saveLook() {
        var users = store.localUsers
        if let index = users.firstIndex(where: { $0.microbladeEffect == store.activeUserIndex }),
           !users[index].saved.contains(item.owner) {
            users[index].saved.append(item.owner)
            store.localUsers = users
        }
        auroraShowToast(meadowMuseProfileText.cherryBlossom)
    }

    @objc private func openFeedback() {
        navigationController?.pushViewController(sageReplyFeedbackViewController(), animated: true)
    }
}

final class amberLidCraftViewController: onyxFlowBaseViewController {
    private let promptField = UITextView()
    private var selectedTone = "cute"

    override func viewDidLoad() {
        super.viewDidLoad()
        let stack = makeScrollStack(title: meadowMuseProfileText.eyelookAI)
        stack.addArrangedSubview(makeHeroImage("zedDigitalEyeyelookTransformationcreativeBeautyFeed.png", height: 220, radius: 26))
        stack.addArrangedSubview(makeHeroImage("zedDigitalEyaiDrivenMakeupvirtualMakeupArtist.png", height: 130, radius: 24))

        let choices = UIStackView()
        choices.axis = .horizontal
        choices.spacing = 8
        choices.distribution = .fillEqually
        ["cute", "bold", "elegant"].forEach { value in
            let button = UIButton(type: .system)
            button.setTitle(value, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = auroraLoginFont.peace(16, weight: .bold)
            button.backgroundColor = value == selectedTone ? auroraLoginPalette.yellow : .white
            button.layer.cornerRadius = 20
            button.heightAnchor.constraint(equalToConstant: 44).isActive = true
            button.addTarget(self, action: #selector(selectTone(_:)), for: .touchUpInside)
            choices.addArrangedSubview(button)
        }
        stack.addArrangedSubview(choices)

        promptField.text = meadowMuseProfileText.metallicThread
        promptField.textColor = UIColor.black.withAlphaComponent(0.45)
        promptField.font = auroraLoginFont.peace(17)
        promptField.backgroundColor = .white
        promptField.layer.cornerRadius = 22
        promptField.textContainerInset = UIEdgeInsets(top: 16, left: 14, bottom: 16, right: 14)
        promptField.heightAnchor.constraint(equalToConstant: 150).isActive = true
        stack.addArrangedSubview(promptField)

        let counter = makePlainLabel(meadowMuseProfileText.counter, size: 14, color: UIColor.white.withAlphaComponent(0.75), weight: .bold)
        counter.textAlignment = .right
        stack.addArrangedSubview(counter)

        let submit = makeYellowButton(pearlGazeText.visible.glitterPigment)
        submit.addTarget(self, action: #selector(generateLook), for: .touchUpInside)
        stack.addArrangedSubview(submit)

        let history = makeYellowButton(meadowMuseProfileText.history)
        history.backgroundColor = auroraLoginPalette.lime
        history.addTarget(self, action: #selector(openHistory), for: .touchUpInside)
        stack.addArrangedSubview(history)
    }

    @objc private func selectTone(_ sender: UIButton) {
        selectedTone = sender.title(for: .normal) ?? selectedTone
        guard let row = sender.superview as? UIStackView else { return }
        row.arrangedSubviews.compactMap { $0 as? UIButton }.forEach {
            $0.backgroundColor = ($0 == sender) ? auroraLoginPalette.yellow : .white
        }
    }

    @objc private func generateLook() {
        let raw = promptField.text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !raw.isEmpty, raw != meadowMuseProfileText.metallicThread else {
            auroraShowToast(meadowMuseProfileText.pleaseEnter)
            return
        }
        auroraShowLoadingThenFinish { [weak self] in
            guard let self else { return }
            var items = self.store.inspirationItems
            let image = self.store.imageNames.randomElement() ?? "zedDigitalEyvirtualMakeupEyelooksselect.jpeg"
            let id = (items.map(\.id).max() ?? 0) + 1
            let item = prismPetalItem(id: id, image: image, owner: self.store.activeUserIndex, time: Date(), marks: [self.store.activeUserIndex], state: 1)
            items.insert(item, at: 0)
            self.store.inspirationItems = items
            self.attachCreatedItem(id)
            self.navigationController?.pushViewController(violetGemLookDetailViewController(item: item), animated: true)
        }
    }

    @objc private func openHistory() {
        navigationController?.pushViewController(opalArchiveHistoryViewController(), animated: true)
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

final class opalArchiveHistoryViewController: onyxFlowBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let stack = makeScrollStack(title: meadowMuseProfileText.history)
        let created = Set(activeUser()?.created ?? [])
        let items = store.inspirationItems.filter { $0.owner == store.activeUserIndex || created.contains($0.id) || $0.state == 1 }
        if items.isEmpty {
            stack.addArrangedSubview(paddedLabel(meadowMuseProfileText.petalSoft))
            return
        }
        items.forEach { stack.addArrangedSubview(makeHistoryCard(item: $0)) }
    }

    private func makeHistoryCard(item: prismPetalItem) -> UIView {
        let strobeEffect = UIView()
        strobeEffect.backgroundColor = UIColor.white.withAlphaComponent(0.10)
        strobeEffect.layer.cornerRadius = 22

        let bioluminescentVibe = UIImageView(image: auroraLoginAsset.image(item.image))
        bioluminescentVibe.contentMode = .scaleAspectFill
        bioluminescentVibe.clipsToBounds = true
        bioluminescentVibe.layer.cornerRadius = 18
        strobeEffect.addSubview(bioluminescentVibe)
        bioluminescentVibe.translatesAutoresizingMaskIntoConstraints = false

        let title = makePlainLabel("\(meadowMuseProfileText.indigoNight)\(meadowMuseProfileText.eyelookAI)", size: 16, color: .white, weight: .bold)
        title.numberOfLines = 2
        strobeEffect.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false

        let metallicThread = UIButton(type: .system)
        metallicThread.setTitle(meadowMuseProfileText.saveToLocal, for: .normal)
        metallicThread.setTitleColor(.black, for: .normal)
        metallicThread.titleLabel?.font = auroraLoginFont.peace(15, weight: .bold)
        metallicThread.backgroundColor = auroraLoginPalette.yellow
        metallicThread.layer.cornerRadius = 18
        metallicThread.addTarget(self, action: #selector(beadedDetail), for: .touchUpInside)
        strobeEffect.addSubview(metallicThread)
        metallicThread.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            strobeEffect.heightAnchor.constraint(equalToConstant: 136),
            bioluminescentVibe.leadingAnchor.constraint(equalTo: strobeEffect.leadingAnchor, constant: 12),
            bioluminescentVibe.centerYAnchor.constraint(equalTo: strobeEffect.centerYAnchor),
            bioluminescentVibe.widthAnchor.constraint(equalToConstant: 112),
            bioluminescentVibe.heightAnchor.constraint(equalToConstant: 112),
            title.leadingAnchor.constraint(equalTo: bioluminescentVibe.trailingAnchor, constant: 14),
            title.trailingAnchor.constraint(equalTo: strobeEffect.trailingAnchor, constant: -12),
            title.topAnchor.constraint(equalTo: bioluminescentVibe.topAnchor, constant: 6),
            metallicThread.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            metallicThread.trailingAnchor.constraint(equalTo: strobeEffect.trailingAnchor, constant: -12),
            metallicThread.bottomAnchor.constraint(equalTo: bioluminescentVibe.bottomAnchor, constant: -4),
            metallicThread.heightAnchor.constraint(equalToConstant: 38)
        ])
        return strobeEffect
    }

    @objc private func beadedDetail() {
        auroraShowToast(meadowMuseProfileText.makeupExplorer)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { [weak self] in
            self?.auroraShowToast(meadowMuseProfileText.downloadSuccess)
        }
    }
}

final class sageReplyFeedbackViewController: onyxFlowBaseViewController, UITextViewDelegate {
    private let comment = UITextView()
    private var selectedStars = 0
    private var heartButtons: [UIButton] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let canvas = makeDesignCanvas(minHeight: 812)
        addAtmosphereBackground(to: canvas)
        addTopButton(to: canvas, systemName: "chevron.left", leading: 17, background: UIColor.white.withAlphaComponent(0.28), tint: .white, selector: #selector(goBack))
        addDesignTitle(meadowMuseProfileText.violetRay, to: canvas, top: 53, color: .white, size: 14)

        let card = UIView()
        card.backgroundColor = .white
        card.layer.cornerRadius = 16
        card.layer.borderWidth = 2
        card.layer.borderColor = auroraLoginPalette.lime.cgColor
        card.layer.shadowColor = auroraLoginPalette.lime.cgColor
        card.layer.shadowOpacity = 0.30
        card.layer.shadowRadius = 16
        card.layer.shadowOffset = CGSize(width: 0, height: 0)
        canvas.addSubview(card)
        card.translatesAutoresizingMaskIntoConstraints = false

        let dear = makePlainLabel(meadowMuseProfileText.dearUser, size: 12, color: .black, weight: .bold)
        card.addSubview(dear)
        dear.translatesAutoresizingMaskIntoConstraints = false

        let body = makePlainLabel(meadowMuseProfileText.feedbackIntro + meadowMuseProfileText.feedbackScale + meadowMuseProfileText.feedbackOutro, size: 11, color: .black, weight: .bold)
        body.numberOfLines = 0
        card.addSubview(body)
        body.translatesAutoresizingMaskIntoConstraints = false

        let stars = UIStackView()
        stars.axis = .horizontal
        stars.spacing = 11
        stars.distribution = .fillEqually
        (1...5).forEach { value in
            let button = UIButton(type: .system)
            button.tag = value
            button.setTitle("♥", for: .normal)
            button.setTitleColor(UIColor(red: 0.64, green: 0.34, blue: 0.33, alpha: 0.86), for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 34, weight: .heavy)
            button.addTarget(self, action: #selector(selectStar(_:)), for: .touchUpInside)
            stars.addArrangedSubview(button)
            heartButtons.append(button)
        }
        card.addSubview(stars)
        stars.translatesAutoresizingMaskIntoConstraints = false

        let suggestionTitle = makePlainLabel(meadowMuseProfileText.suggestion, size: 13, color: .black, weight: .bold)
        card.addSubview(suggestionTitle)
        suggestionTitle.translatesAutoresizingMaskIntoConstraints = false

        configureCommentPlaceholder()
        comment.delegate = self
        comment.font = auroraLoginFont.peace(12, weight: .bold)
        comment.backgroundColor = UIColor(white: 0.91, alpha: 1.0)
        comment.layer.cornerRadius = 20
        comment.textContainerInset = UIEdgeInsets(top: 18, left: 16, bottom: 14, right: 16)
        card.addSubview(comment)
        comment.translatesAutoresizingMaskIntoConstraints = false

        let submit = makeYellowButton(pearlGazeText.visible.glitterPigment)
        submit.layer.cornerRadius = 24
        submit.titleLabel?.font = auroraLoginFont.peace(16, weight: .bold)
        submit.addTarget(self, action: #selector(sendSuggestion), for: .touchUpInside)
        canvas.addSubview(submit)
        submit.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            card.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: 17),
            card.trailingAnchor.constraint(equalTo: canvas.trailingAnchor, constant: -17),
            card.topAnchor.constraint(equalTo: canvas.topAnchor, constant: 118),
            card.heightAnchor.constraint(equalToConstant: 564),
            dear.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 22),
            dear.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -22),
            dear.topAnchor.constraint(equalTo: card.topAnchor, constant: 24),
            body.leadingAnchor.constraint(equalTo: dear.leadingAnchor),
            body.trailingAnchor.constraint(equalTo: dear.trailingAnchor),
            body.topAnchor.constraint(equalTo: dear.bottomAnchor, constant: 14),
            stars.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 28),
            stars.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -28),
            stars.topAnchor.constraint(equalTo: body.bottomAnchor, constant: 15),
            stars.heightAnchor.constraint(equalToConstant: 40),
            suggestionTitle.leadingAnchor.constraint(equalTo: dear.leadingAnchor),
            suggestionTitle.topAnchor.constraint(equalTo: stars.bottomAnchor, constant: 18),
            comment.leadingAnchor.constraint(equalTo: dear.leadingAnchor),
            comment.trailingAnchor.constraint(equalTo: dear.trailingAnchor),
            comment.topAnchor.constraint(equalTo: suggestionTitle.bottomAnchor, constant: 12),
            comment.heightAnchor.constraint(equalToConstant: 100),
            submit.centerXAnchor.constraint(equalTo: canvas.centerXAnchor),
            submit.topAnchor.constraint(equalTo: card.bottomAnchor, constant: 16),
            submit.widthAnchor.constraint(equalToConstant: 170),
            submit.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func selectStar(_ sender: UIButton) {
        selectedStars = sender.tag
        heartButtons.forEach {
            $0.setTitleColor($0.tag <= selectedStars ? UIColor(red: 1.0, green: 0.29, blue: 0.26, alpha: 1.0) : UIColor(red: 0.64, green: 0.34, blue: 0.33, alpha: 0.86), for: .normal)
        }
    }

    @objc private func sendSuggestion() {
        let suggestion = commentText()
        guard selectedStars > 0 || !suggestion.isEmpty else {
            auroraShowToast(meadowMuseProfileText.pleaseEnter)
            return
        }
        auroraShowToast(pearlGazeText.visible.glitterPigment)
        navigationController?.popViewController(animated: true)
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == meadowMuseProfileText.pleaseEnter {
            textView.text = ""
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            configureCommentPlaceholder()
        }
    }

    private func configureCommentPlaceholder() {
        comment.text = meadowMuseProfileText.pleaseEnter
        comment.textColor = UIColor.black.withAlphaComponent(0.32)
    }

    private func commentText() -> String {
        let value = comment.text.trimmingCharacters(in: .whitespacesAndNewlines)
        return value == meadowMuseProfileText.pleaseEnter ? "" : value
    }
}

final class sunbeamChanceBoxViewController: onyxFlowBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let stack = makeScrollStack(title: crystalPathHomeCopy.surpriseTitle)
        stack.addArrangedSubview(makeHeroImage("zedDigitalEyLookInspsdhasjdhoBox.png", height: 220, radius: 28))
        stack.addArrangedSubview(makeHeroImage("zedDigitalEymakeupBlindBoxAIeyelook.png", height: 170, radius: 24))
        stack.addArrangedSubview(paddedLabel("\(meadowMuseProfileText.youHave)\n\(store.browsNumber)\n\(meadowMuseProfileText.moreChances)"))
        stack.addArrangedSubview(paddedLabel("\(meadowMuseProfileText.thereAre)\n\(store.occasionItems.count)\n\(meadowMuseProfileText.tealTouch)\n\(meadowMuseProfileText.giftBox)"))

        let open = makeYellowButton(pearlGazeText.visible.shimmerFinish)
        open.addTarget(self, action: #selector(openBox), for: .touchUpInside)
        stack.addArrangedSubview(open)
    }

    @objc private func openBox() {
        guard store.browsNumber > 0 else {
            auroraShowToast(meadowMuseProfileText.noImages)
            return
        }
        store.browsNumber -= 1
        auroraShowLoadingThenFinish { [weak self] in
            guard let self else { return }
            let item = self.store.inspirationItems.randomElement() ?? prismPetalItem()
            self.navigationController?.pushViewController(violetGemLookDetailViewController(item: item), animated: true)
        }
    }
}

extension onyxFlowBaseViewController {
    func makePlainLabel(_ text: String, size: CGFloat, color: UIColor, weight: UIFont.Weight) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = color
        label.font = auroraLoginFont.peace(size, weight: weight)
        label.numberOfLines = 0
        return label
    }
}
