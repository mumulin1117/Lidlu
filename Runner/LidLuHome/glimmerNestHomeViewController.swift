import UIKit

final class glimmerNestHomeViewController: UIViewController {
    private static let surpriseBoxItemTag = -7001
    private let store = velvetAuraStore.shared
    private var selectedStream = 0
    private let contentStack = UIStackView()
    private let gridStack = UIStackView()
    private var streamButtons: [UIButton] = []
    private let streamIndicator = UIImageView(image: auroraLoginAsset.image("zedDigitalEybeautyTrendTrackerpirationFeed.png"))
    private var streamIndicatorCenterX: NSLayoutConstraint?
    private weak var activeAvatarButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        buildScene()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshActiveAvatar()
    }

    private func buildScene() {
        let scroll = UIScrollView()
        scroll.backgroundColor = .black
        view.addSubview(scroll)
        scroll.auroraPinEdges(to: view)

        contentStack.axis = .vertical
        contentStack.alignment = .fill
        contentStack.spacing = 0
        scroll.addSubview(contentStack)
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor),
            contentStack.leadingAnchor.constraint(equalTo: scroll.contentLayoutGuide.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: scroll.contentLayoutGuide.trailingAnchor),
            contentStack.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor, constant: -110),
            contentStack.widthAnchor.constraint(equalTo: scroll.frameLayoutGuide.widthAnchor)
        ])

        contentStack.addArrangedSubview(heroView())
        contentStack.addArrangedSubview(tabRow())
        contentStack.addArrangedSubview(gridStack)
        gridStack.axis = .horizontal
        gridStack.alignment = .top
        gridStack.spacing = 10
        gridStack.layoutMargins = UIEdgeInsets(top: 12, left: 16, bottom: 0, right: 16)
        gridStack.isLayoutMarginsRelativeArrangement = true
        rebuildGrid()
        buildTopBar()
    }

    private func heroView() -> UIView {
        let container = UIView()
        container.heightAnchor.constraint(equalToConstant: 540).isActive = true

        let image = UIImageView(image: auroraLoginAsset.image("zedDigitalEymakeupExperienceBoxEyeStylist.png"))
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        container.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: container.topAnchor),
            image.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            image.heightAnchor.constraint(equalToConstant: 498)
        ])

        let tryNow = UIButton(type: .system)
        tryNow.backgroundColor = UIColor(red: 0.894, green: 0.004, blue: 0.153, alpha: 1.0)
        tryNow.layer.cornerRadius = 21
        tryNow.setTitle(emberHavenHomeText.tryNow, for: .normal)
        tryNow.setTitleColor(.white, for: .normal)
        tryNow.titleLabel?.font = auroraLoginFont.peace(16)
        tryNow.addTarget(self, action: #selector(openCustomCreator), for: .touchUpInside)
        container.addSubview(tryNow)
        tryNow.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tryNow.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            tryNow.centerYAnchor.constraint(equalTo: image.centerYAnchor, constant: 112),
            tryNow.widthAnchor.constraint(equalToConstant: 103),
            tryNow.heightAnchor.constraint(equalToConstant: 42)
        ])

        let recommender = recommendStrip()
        container.addSubview(recommender)
        recommender.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recommender.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            recommender.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            recommender.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            recommender.heightAnchor.constraint(equalToConstant: 134)
        ])

        let title = UIImageView(image: auroraLoginAsset.image("zedDigitalEycreativeInspoBoxbeautyTalks.png"))
        title.contentMode = .scaleAspectFit
        container.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: container.centerXAnchor, constant: 6),
            title.bottomAnchor.constraint(equalTo: recommender.topAnchor, constant: 42),
            title.widthAnchor.constraint(equalToConstant: 200),
            title.heightAnchor.constraint(equalToConstant: 42)
        ])

        return container
    }

    private func recommendStrip() -> UIView {
        let outer = UIView()
        outer.backgroundColor = .white
        outer.layer.cornerRadius = 33
        outer.layer.borderColor = auroraLoginPalette.lime.cgColor
        outer.layer.borderWidth = 2

        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        outer.addSubview(scroll)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scroll.leadingAnchor.constraint(equalTo: outer.leadingAnchor, constant: 15),
            scroll.trailingAnchor.constraint(equalTo: outer.trailingAnchor),
            scroll.topAnchor.constraint(equalTo: outer.topAnchor),
            scroll.bottomAnchor.constraint(equalTo: outer.bottomAnchor)
        ])

        let row = UIStackView()
        row.axis = .horizontal
        row.spacing = 10
        scroll.addSubview(row)
        row.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            row.leadingAnchor.constraint(equalTo: scroll.contentLayoutGuide.leadingAnchor),
            row.trailingAnchor.constraint(equalTo: scroll.contentLayoutGuide.trailingAnchor),
            row.centerYAnchor.constraint(equalTo: scroll.centerYAnchor, constant: 15),
            row.heightAnchor.constraint(equalToConstant: 64)
        ])

        let activeId = store.activeUserIndex
        let activeSaved = store.localUsers.first(where: { $0.id == activeId })?.saved ?? []
        let suggestions = store.localUsers.filter { $0.id != activeId && !activeSaved.contains($0.id) && !store.isBlocked(userId: $0.id) }.prefix(5)
        for profile in suggestions {
            let avatar = UIButton(type: .custom)
            avatar.setImage(auroraLoginAsset.image(profile.avatar), for: .normal)
            avatar.imageView?.contentMode = .scaleAspectFill
            avatar.tag = profile.id
            avatar.contentMode = .scaleAspectFill
            avatar.clipsToBounds = true
            avatar.layer.cornerRadius = 30
            avatar.layer.borderColor = auroraLoginPalette.yellow.cgColor
            avatar.layer.borderWidth = 2
            avatar.addTarget(self, action: #selector(openSuggestedProfile(_:)), for: .touchUpInside)
            row.addArrangedSubview(avatar)
            NSLayoutConstraint.activate([
                avatar.widthAnchor.constraint(equalToConstant: 60),
                avatar.heightAnchor.constraint(equalToConstant: 60)
            ])
        }
        return outer
    }

    private func tabRow() -> UIView {
        let container = UIView()
        container.heightAnchor.constraint(equalToConstant: 84).isActive = true
        streamButtons.removeAll()

        let trending = tabButton(title: emberHavenHomeText.trending, index: 0)
        let follow = tabButton(title: emberHavenHomeText.follow, index: 1)
        container.addSubview(trending)
        container.addSubview(follow)
        trending.translatesAutoresizingMaskIntoConstraints = false
        follow.translatesAutoresizingMaskIntoConstraints = false
        streamButtons = [trending, follow]

        streamIndicator.contentMode = .scaleAspectFit
        container.addSubview(streamIndicator)
        streamIndicator.translatesAutoresizingMaskIntoConstraints = false

        let side = UIButton()
        side.backgroundColor = UIColor.white.withAlphaComponent(0.24)
        side.layer.cornerRadius = 22
        side.setImage(UIImage(named: "alloweecreate"), for: .normal)
        side.addTarget(self, action: #selector(openShareComposer), for: .touchUpInside)
        container.addSubview(side)
        side.translatesAutoresizingMaskIntoConstraints = false

        streamIndicatorCenterX = streamIndicator.centerXAnchor.constraint(equalTo: trending.centerXAnchor)
        NSLayoutConstraint.activate([
            trending.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 24),
            trending.topAnchor.constraint(equalTo: container.topAnchor, constant: 32),
            follow.leadingAnchor.constraint(equalTo: trending.trailingAnchor, constant: 34),
            follow.centerYAnchor.constraint(equalTo: trending.centerYAnchor),
            streamIndicator.topAnchor.constraint(equalTo: trending.bottomAnchor, constant: 2),
            streamIndicator.widthAnchor.constraint(equalToConstant: 62),
            streamIndicator.heightAnchor.constraint(equalToConstant: 20),
            streamIndicatorCenterX!,
            side.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            side.topAnchor.constraint(equalTo: container.topAnchor, constant: 32),
            side.widthAnchor.constraint(equalToConstant: 88),
            side.heightAnchor.constraint(equalToConstant: 44)
        ])
        updateStreamIndicator(animated: false)
        return container
    }

    private func tabButton(title: String, index: Int) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = auroraLoginFont.peace(18)
        button.tag = index
        button.addTarget(self, action: #selector(changeStream(_:)), for: .touchUpInside)
        return button
    }

    @objc private func changeStream(_ sender: UIButton) {
        selectedStream = sender.tag
        updateStreamIndicator(animated: true)
        rebuildGrid()
    }

    private func updateStreamIndicator(animated: Bool) {
        guard streamButtons.indices.contains(selectedStream) else { return }
        streamIndicatorCenterX?.isActive = false
        streamIndicatorCenterX = streamIndicator.centerXAnchor.constraint(equalTo: streamButtons[selectedStream].centerXAnchor)
        streamIndicatorCenterX?.isActive = true
        streamButtons.enumerated().forEach { index, button in
            button.alpha = index == selectedStream ? 1.0 : 0.72
        }
        guard animated else { return }
        UIView.animate(withDuration: 0.18) {
            self.streamIndicator.superview?.layoutIfNeeded()
        }
    }

    private func rebuildGrid() {
        gridStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let left = UIStackView()
        let right = UIStackView()
        [left, right].forEach {
            $0.axis = .vertical
            $0.spacing = 10
            gridStack.addArrangedSubview($0)
            $0.widthAnchor.constraint(equalTo: gridStack.widthAnchor, multiplier: 0.5, constant: -21).isActive = true
        }

        let items = selectedStream == 0 ? trendingItems() : followedItems()
        for (index, item) in items.enumerated() {
            let imageView = UIButton()
            let isSurpriseBoxItem = selectedStream == 0 && index == 1
            print(item.image,isSurpriseBoxItem)
            
            imageView.setImage(isSurpriseBoxItem ? UIImage(named: "hollyubanner") : auroraLoginAsset.image(item.image), for: .normal)
            imageView.imageView?.contentMode = isSurpriseBoxItem ? .scaleToFill : .scaleAspectFill
            imageView.contentHorizontalAlignment = .fill
            imageView.contentVerticalAlignment = .fill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 8
            imageView.tag = isSurpriseBoxItem ? Self.surpriseBoxItemTag : item.id
            imageView.addTarget(self, action: #selector(openInspirationDetail(_:)), for: .touchUpInside)
            imageView.heightAnchor.constraint(equalToConstant: index % 2 == 0 ? 120 : 228).isActive = true
            (index % 2 == 0 ? left : right).addArrangedSubview(imageView)
        }
    }

    private func trendingItems() -> [prismPetalItem] {
        let activeSaved = store.localUsers.first(where: { $0.id == store.activeUserIndex })?.saved ?? []
        return store.inspirationItems.filter { $0.state == 0 && !activeSaved.contains($0.owner) && !store.isBlocked(userId: $0.owner) }
    }

    private func followedItems() -> [prismPetalItem] {
        let liked = store.localUsers.first(where: { $0.id == store.activeUserIndex })?.liked ?? []
        return store.inspirationItems.filter { liked.contains($0.owner) && !store.isBlocked(userId: $0.owner) }
    }

    private func buildTopBar() {
        let row = UIStackView()
        row.axis = .horizontal
        row.alignment = .center
        row.distribution = .equalSpacing
        view.addSubview(row)
        row.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            row.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            row.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            row.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            row.heightAnchor.constraint(equalToConstant: 40)
        ])

        let active = store.localUsers.first(where: { $0.id == store.activeUserIndex }) ?? store.localUsers.first
        let avatar = UIButton(type: .custom)
        avatar.setImage(auroraLoginAsset.image(store.avatarName(for: active)), for: .normal)
        activeAvatarButton = avatar
        avatar.imageView?.contentMode = .scaleAspectFill
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = 20
        avatar.layer.borderWidth = 2
        avatar.addTarget(self, action: #selector(openActiveProfile), for: .touchUpInside)
        row.addArrangedSubview(avatar)
        NSLayoutConstraint.activate([
            avatar.widthAnchor.constraint(equalToConstant: 40),
            avatar.heightAnchor.constraint(equalToConstant: 40)
        ])

        let brand = UIImageView(image: auroraLoginAsset.image("zedDigitalEymakeupMasterybeautyCraftsShare.png"))
        brand.contentMode = .scaleAspectFit
        row.addArrangedSubview(brand)
        NSLayoutConstraint.activate([
            brand.widthAnchor.constraint(equalToConstant: 59),
            brand.heightAnchor.constraint(equalToConstant: 33)
        ])

        let message = UIButton(type: .custom)
        message.setImage(auroraLoginAsset.image("zedDigitalEyeyeMakeupDesignermakeupExperienceB.png"), for: .normal)
        message.imageView?.contentMode = .scaleAspectFit
        message.addTarget(self, action: #selector(openMessages), for: .touchUpInside)
        row.addArrangedSubview(message)
        NSLayoutConstraint.activate([
            message.widthAnchor.constraint(equalToConstant: 40),
            message.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func refreshActiveAvatar() {
        let active = store.localUsers.first(where: { $0.id == store.activeUserIndex }) ?? store.localUsers.first
        activeAvatarButton?.setImage(auroraLoginAsset.image(store.avatarName(for: active)), for: .normal)
    }

    @objc private func openSurpriseBox() {
        crystalPathHomeRouter.showSurprise(from: self)
    }

    @objc private func openCustomCreator() {
        crystalPathHomeRouter.showCustom(from: self)
    }

    @objc private func openShareComposer() {
        crystalPathHomeRouter.showShare(from: self)
    }

    @objc private func openSuggestedProfile(_ sender: UIButton) {
        crystalPathHomeRouter.showUser(from: self, userId: sender.tag)
    }

    @objc private func openInspirationDetail(_ sender: UIButton) {
        if sender.tag == Self.surpriseBoxItemTag {
            crystalPathHomeRouter.showSurprise(from: self)
            return
        }
        guard let item = store.inspirationItems.first(where: { $0.id == sender.tag }) else { return }
        crystalPathHomeRouter.showImageDetail(from: self, item: item)
    }

    @objc private func openActiveProfile() {
        if let tabs = rootTabsController() {
            tabs.showProfileTab()
        }
    }

    private func rootTabsController() -> prismRootTabsViewController? {
        var node = parent
        while let current = node {
            if let tabs = current as? prismRootTabsViewController {
                return tabs
            }
            node = current.parent
        }
        return nil
    }

    @objc private func openMessages() {
        crystalPathHomeRouter.showMessages(from: self)
    }

}

final class prismRootTabsViewController: UIViewController {
    private let pages: [UIViewController]
    private let tabBar = UIView()
    private let tabRow = UIStackView()
    private var buttons: [UIButton] = []
    private var currentIndex = 1

    private let iconSets = [
        ("zedDigitalEymakeupCreationBoxTrendInspo.png", "zedDigitalEymakeupCreationBoxTrendInsposelct.png"),
        ("zedDigitalEybeautyCommunityShareMatch.png", "zedDigitalEybeautyCommunityShareMatchselect.png"),
        ("zedDigitalEybeautyCommunitySharermation.png", "zedDigitalEybeautyCommunitySharermationselect.png")
    ]

    init(initialIndex: Int = 1) {
        pages = [
            velvetProfileLandingViewController(),
            glimmerNestHomeViewController(),
            velvetInspiraBoxViewController()
        ]
        currentIndex = initialIndex
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        buildTabBar()
        switchTo(index: currentIndex, animated: false)
    }

    private func buildTabBar() {
        tabBar.backgroundColor = UIColor.white.withAlphaComponent(0.90)
        tabBar.layer.cornerRadius = 28
        tabBar.layer.masksToBounds = true
        view.addSubview(tabBar)
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tabBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -18),
            tabBar.widthAnchor.constraint(equalToConstant: 252),
            tabBar.heightAnchor.constraint(equalToConstant: 60)
        ])

        tabRow.axis = .horizontal
        tabRow.alignment = .center
        tabRow.distribution = .equalSpacing
        tabBar.addSubview(tabRow)
        tabRow.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tabRow.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor, constant: 24),
            tabRow.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor, constant: -24),
            tabRow.topAnchor.constraint(equalTo: tabBar.topAnchor),
            tabRow.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor)
        ])

        for index in 0..<iconSets.count {
            let button = UIButton(type: .custom)
            button.tag = index
            button.layer.cornerRadius = 18
            button.imageView?.contentMode = .scaleAspectFit
            button.addTarget(self, action: #selector(changeTab(_:)), for: .touchUpInside)
            tabRow.addArrangedSubview(button)
            buttons.append(button)
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 56),
                button.heightAnchor.constraint(equalToConstant: 36)
            ])
        }
    }

    @objc private func changeTab(_ sender: UIButton) {
        switchTo(index: sender.tag, animated: true)
    }

    func showProfileTab() {
        switchTo(index: 0, animated: true)
    }

    private func switchTo(index: Int, animated: Bool) {
        guard pages.indices.contains(index), index != currentIndex || children.isEmpty else { return }
        let old = children.first
        let next = pages[index]
        currentIndex = index
        updateTabs()

        addChild(next)
        view.insertSubview(next.view, belowSubview: tabBar)
        next.view.auroraPinEdges(to: view)
        next.view.alpha = animated ? 0 : 1

        let complete: (Bool) -> Void = { [weak old, weak next] _ in
            old?.willMove(toParent: nil)
            old?.view.removeFromSuperview()
            old?.removeFromParent()
            next?.didMove(toParent: self)
        }

        if animated {
            UIView.animate(withDuration: 0.18, animations: {
                next.view.alpha = 1
                old?.view.alpha = 0
            }, completion: complete)
        } else {
            complete(true)
        }
    }

    private func updateTabs() {
        for (index, button) in buttons.enumerated() {
            let isSelected = index == currentIndex
            let name = isSelected ? iconSets[index].1 : iconSets[index].0
            button.backgroundColor = isSelected ? .black : .clear
            button.setImage(auroraLoginAsset.image(name)?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
}

final class velvetInspiraBoxViewController: onyxFlowBaseViewController {
    private var selectedTab = 0
    private var tabButtons: [UIButton] = []
    private let gridHost = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        buildContent()
    }

    private func buildContent() {
        let scroll = UIScrollView()
        scroll.backgroundColor = .black
        scroll.showsVerticalScrollIndicator = false
        view.addSubview(scroll)
        scroll.auroraPinEdges(to: view)

        let canvas = UIView()
        canvas.backgroundColor = .black
        scroll.addSubview(canvas)
        canvas.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            canvas.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor),
            canvas.leadingAnchor.constraint(equalTo: scroll.contentLayoutGuide.leadingAnchor),
            canvas.trailingAnchor.constraint(equalTo: scroll.contentLayoutGuide.trailingAnchor),
            canvas.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor),
            canvas.widthAnchor.constraint(equalTo: scroll.frameLayoutGuide.widthAnchor),
            canvas.heightAnchor.constraint(greaterThanOrEqualTo: scroll.frameLayoutGuide.heightAnchor)
        ])

        let hero = UIImageView(image: auroraLoginAsset.image("lanhuInspiraBackground.png"))
        hero.contentMode = .scaleToFill
        hero.clipsToBounds = true
        canvas.addSubview(hero)
        hero.translatesAutoresizingMaskIntoConstraints = false

        let title = makePlainLabel("InspiraBox", size: 54, color: auroraLoginPalette.yellow, weight: .bold)
        title.textAlignment = .center
        title.shadowColor = UIColor(red: 1.0, green: 0.149, blue: 0.686, alpha: 1.0)
        title.shadowOffset = CGSize(width: 0, height: 4)
        canvas.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false

        let segment = segmentRow()
        canvas.addSubview(segment)
        segment.translatesAutoresizingMaskIntoConstraints = false

        canvas.addSubview(gridHost)
        gridHost.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            hero.topAnchor.constraint(equalTo: canvas.topAnchor),
            hero.leadingAnchor.constraint(equalTo: canvas.leadingAnchor),
            hero.trailingAnchor.constraint(equalTo: canvas.trailingAnchor),
            hero.heightAnchor.constraint(equalToConstant: 372),
            title.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: 24),
            title.trailingAnchor.constraint(equalTo: canvas.trailingAnchor, constant: -24),
            title.topAnchor.constraint(equalTo: canvas.topAnchor, constant: 174),
            title.heightAnchor.constraint(equalToConstant: 64),
            segment.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: 11),
            segment.topAnchor.constraint(equalTo: canvas.topAnchor, constant: 307),
            segment.widthAnchor.constraint(equalToConstant: 353),
            segment.heightAnchor.constraint(equalToConstant: 64),
            gridHost.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: 19),
            gridHost.trailingAnchor.constraint(equalTo: canvas.trailingAnchor, constant: -21),
            gridHost.topAnchor.constraint(equalTo: canvas.topAnchor, constant: 394),
            gridHost.heightAnchor.constraint(equalToConstant: 418),
            canvas.bottomAnchor.constraint(greaterThanOrEqualTo: gridHost.bottomAnchor, constant: 110)
        ])
        reloadTab()
    }

    private func segmentRow() -> UIView {
        let outer = UIView()
        outer.backgroundColor = .black
        outer.layer.cornerRadius = 24
        outer.layer.borderColor = UIColor(red: 0.78, green: 0.73, blue: 0.96, alpha: 1.0).cgColor
        outer.layer.borderWidth = 1

        let row = UIStackView()
        row.axis = .horizontal
        row.distribution = .fillEqually
        row.spacing = 0
        outer.addSubview(row)
        row.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            row.leadingAnchor.constraint(equalTo: outer.leadingAnchor, constant: 10),
            row.trailingAnchor.constraint(equalTo: outer.trailingAnchor, constant: -10),
            row.topAnchor.constraint(equalTo: outer.topAnchor),
            row.bottomAnchor.constraint(equalTo: outer.bottomAnchor)
        ])

        [meadowMuseProfileText.picked, meadowMuseProfileText.mine, meadowMuseProfileText.got].enumerated().forEach { index, title in
            let button = UIButton(type: .system)
            button.tag = index
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = auroraLoginFont.peace(18, weight: .bold)
            button.addTarget(self, action: #selector(changeInspiraTab(_:)), for: .touchUpInside)
            tabButtons.append(button)
            row.addArrangedSubview(button)
        }

        [129.0, 246.0].forEach { offset in
            let separator = UIView()
            separator.backgroundColor = UIColor(white: 0.59, alpha: 1.0)
            outer.addSubview(separator)
            separator.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                separator.leadingAnchor.constraint(equalTo: outer.leadingAnchor, constant: offset),
                separator.centerYAnchor.constraint(equalTo: outer.centerYAnchor),
                separator.widthAnchor.constraint(equalToConstant: 1),
                separator.heightAnchor.constraint(equalToConstant: 16)
            ])
        }
        return outer
    }

    @objc private func changeInspiraTab(_ sender: UIButton) {
        selectedTab = sender.tag
        reloadTab()
    }

    private func reloadTab() {
        tabButtons.enumerated().forEach { index, button in
            let active = index == selectedTab
            button.backgroundColor = .clear
            button.setTitleColor(active ? auroraLoginPalette.yellow : UIColor.white.withAlphaComponent(0.62), for: .normal)
        }
        gridHost.subviews.forEach { $0.removeFromSuperview() }
        let items = itemsForCurrentTab()
        let content = items.isEmpty ? emptyCard() : makeLanhuInspiraGrid(items: items)
        gridHost.addSubview(content)
        content.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: gridHost.topAnchor),
            content.leadingAnchor.constraint(equalTo: gridHost.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: gridHost.trailingAnchor),
            content.bottomAnchor.constraint(equalTo: gridHost.bottomAnchor)
        ])
    }

    private func makeLanhuInspiraGrid(items: [prismPetalItem]) -> UIView {
        let grid = UIView()
        let specs: [(String, CGFloat, CGFloat, CGFloat, CGFloat)] = [
            ("lanhuInspiraCardSmallTop.png", 0, 0, 118, 118),
            ("lanhuInspiraCardSmallBottom.png", 0, 130, 118, 118),
            ("lanhuInspiraCardLargeTop.png", 130, 0, 205, 248),
            ("lanhuInspiraCardWideBottom.png", 0, 260, 205, 158),
            ("lanhuInspiraCardSmallBottomRight.png", 217, 260, 118, 158)
        ]
        specs.enumerated().forEach { index, spec in
            let button = UIButton(type: .custom)
            button.clipsToBounds = true
            button.layer.cornerRadius = 24
            button.setImage(auroraLoginAsset.image(spec.0), for: .normal)
            button.imageView?.contentMode = .scaleAspectFill
            button.contentHorizontalAlignment = .fill
            button.contentVerticalAlignment = .fill
            button.tag = items.indices.contains(index) ? items[index].id : (items.first?.id ?? -1)
            button.addTarget(self, action: #selector(openLanhuInspiraItem(_:)), for: .touchUpInside)
            grid.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(equalTo: grid.leadingAnchor, constant: spec.1),
                button.topAnchor.constraint(equalTo: grid.topAnchor, constant: spec.2),
                button.widthAnchor.constraint(equalToConstant: spec.3),
                button.heightAnchor.constraint(equalToConstant: spec.4)
            ])
        }
        return grid
    }

    @objc private func openLanhuInspiraItem(_ sender: UIButton) {
        guard let item = store.inspirationItems.first(where: { $0.id == sender.tag }) else { return }
        navigationController?.pushViewController(violetGemLookDetailViewController(item: item), animated: true)
    }

    private func itemsForCurrentTab() -> [prismPetalItem] {
        let user = activeUser()
        switch selectedTab {
        case 0:
            let savedOwners = Set(user?.saved ?? [])
            return store.inspirationItems.filter { savedOwners.contains($0.owner) && !store.isBlocked(userId: $0.owner) }
        case 1:
            let created = Set(user?.created ?? [])
            return store.inspirationItems.filter { $0.owner == store.activeUserIndex || created.contains($0.id) }
        default:
            let created = Set(user?.created ?? [])
            let got = store.inspirationItems.filter { ($0.state == 1 || created.contains($0.id)) && !store.isBlocked(userId: $0.owner) }
            return got.isEmpty ? Array(store.inspirationItems.filter { !store.isBlocked(userId: $0.owner) }.prefix(6)) : got
        }
    }

    private func emptyCard() -> UIView {
        let card = UIView()
        card.backgroundColor = UIColor.white.withAlphaComponent(0.10)
        card.layer.cornerRadius = 24

        let image = UIImageView(image: auroraLoginAsset.image("zedDigitalEyLookInspsdhasjdhoBox.png"))
        image.contentMode = .scaleAspectFit
        card.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false

        let label = makePlainLabel(meadowMuseProfileText.empty, size: 16, color: .white, weight: .bold)
        label.textAlignment = .center
        card.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            image.topAnchor.constraint(equalTo: card.topAnchor, constant: 72),
            image.widthAnchor.constraint(equalToConstant: 90),
            image.heightAnchor.constraint(equalToConstant: 82),
            label.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -20),
            label.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 18)
        ])
        return card
    }
}

final class velvetProfileLandingViewController: onyxFlowBaseViewController {
    private var hasBuiltProfile = false

    override func viewDidLoad() {
        super.viewDidLoad()
        reloadProfile()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if hasBuiltProfile {
            reloadProfile()
        }
    }

    private func reloadProfile() {
        view.subviews.forEach { $0.removeFromSuperview() }
        buildProfile()
        hasBuiltProfile = true
    }

    private func buildProfile() {
        view.backgroundColor = .black

        let scroll = UIScrollView()
        scroll.backgroundColor = .black
        scroll.showsVerticalScrollIndicator = false
        view.addSubview(scroll)
        scroll.auroraPinEdges(to: view)

        let canvas = UIView()
        canvas.backgroundColor = .black
        scroll.addSubview(canvas)
        canvas.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            canvas.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor),
            canvas.leadingAnchor.constraint(equalTo: scroll.contentLayoutGuide.leadingAnchor),
            canvas.trailingAnchor.constraint(equalTo: scroll.contentLayoutGuide.trailingAnchor),
            canvas.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor),
            canvas.widthAnchor.constraint(equalTo: scroll.frameLayoutGuide.widthAnchor),
            canvas.heightAnchor.constraint(greaterThanOrEqualTo: scroll.frameLayoutGuide.heightAnchor)
        ])

        let hero = UIImageView(image: auroraLoginAsset.image("lanhuProfileHeroBackground.png"))
        hero.contentMode = .scaleToFill
        hero.clipsToBounds = true
        canvas.addSubview(hero)
        hero.translatesAutoresizingMaskIntoConstraints = false

        let user = activeUser()
        let avatar = UIImageView(image: auroraLoginAsset.image(store.avatarName(for: user)))
        avatar.contentMode = .scaleAspectFill
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = 41
        avatar.layer.borderColor = UIColor.white.cgColor
        avatar.layer.borderWidth = 2
        canvas.addSubview(avatar)
        avatar.translatesAutoresizingMaskIntoConstraints = false

        let name = makePlainLabel(store.displayName(for: user), size: 28, color: .white, weight: .bold)
        name.textAlignment = .center
        name.shadowColor = UIColor.black.withAlphaComponent(0.36)
        name.shadowOffset = CGSize(width: 0, height: 2)
        canvas.addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false

        let stats = statsCard(user: user)
        canvas.addSubview(stats)
        stats.translatesAutoresizingMaskIntoConstraints = false

        let wallet = walletCard(user: user)
        canvas.addSubview(wallet)
        wallet.translatesAutoresizingMaskIntoConstraints = false

        let menu = menuCard()
        canvas.addSubview(menu)
        menu.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            hero.topAnchor.constraint(equalTo: canvas.topAnchor),
            hero.leadingAnchor.constraint(equalTo: canvas.leadingAnchor),
            hero.trailingAnchor.constraint(equalTo: canvas.trailingAnchor),
            hero.heightAnchor.constraint(equalToConstant: 380),
            avatar.topAnchor.constraint(equalTo: canvas.topAnchor, constant: 214),
            avatar.centerXAnchor.constraint(equalTo: canvas.centerXAnchor),
            avatar.widthAnchor.constraint(equalToConstant: 82),
            avatar.heightAnchor.constraint(equalToConstant: 82),
            name.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 6),
            name.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: 24),
            name.trailingAnchor.constraint(equalTo: canvas.trailingAnchor, constant: -24),
            stats.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: 24),
            stats.topAnchor.constraint(equalTo: canvas.topAnchor, constant: 349),
            stats.widthAnchor.constraint(equalToConstant: 327),
            stats.heightAnchor.constraint(equalToConstant: 74),
            wallet.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: 24),
            wallet.topAnchor.constraint(equalTo: stats.bottomAnchor, constant: 12),
            wallet.widthAnchor.constraint(equalToConstant: 327),
            wallet.heightAnchor.constraint(equalToConstant: 100),
            menu.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: 24),
            menu.topAnchor.constraint(equalTo: wallet.bottomAnchor, constant: 12),
            menu.widthAnchor.constraint(equalToConstant: 327),
            menu.heightAnchor.constraint(equalToConstant: 136),
            canvas.bottomAnchor.constraint(greaterThanOrEqualTo: menu.bottomAnchor, constant: 122)
        ])
    }

    private func statsCard(user: opalCharmProfile?) -> UIView {
        let card = UIView()
        card.backgroundColor = .white
        card.layer.cornerRadius = 24
        card.layer.masksToBounds = true

        let row = UIStackView()
        row.axis = .horizontal
        row.distribution = .fillEqually
        row.alignment = .center
        card.addSubview(row)
        row.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            row.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 76),
            row.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -76),
            row.centerYAnchor.constraint(equalTo: card.centerYAnchor)
           
        ])
        row.addArrangedSubview(statLabel(value: "0", title: petalTrailCompleteText.following))
        row.addArrangedSubview(statLabel(value: "0", title: petalTrailCompleteText.fans))
        return card
    }

    private func statLabel(value: String, title: String) -> UILabel {
        let label = UILabel()
        label.text = "\(value)\n\(title)"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .black
        label.font = auroraLoginFont.peace(17, weight: .bold)
        return label
    }

    private func walletCard(user: opalCharmProfile?) -> UIView {
        let card = UIButton(type: .custom)
        card.layer.cornerRadius = 24
        card.clipsToBounds = true
        card.addTarget(self, action: #selector(openWallet), for: .touchUpInside)

        let background = UIImageView(image: auroraLoginAsset.image("lanhuProfileWalletCard.png"))
        background.contentMode = .scaleToFill
        background.isUserInteractionEnabled = false
        card.addSubview(background)
        background.auroraPinEdges(to: card)

        let icon = UIImageView(image: auroraLoginAsset.image("lanhuProfileWalletIcon.png"))
        icon.contentMode = .scaleAspectFit
        icon.isUserInteractionEnabled = false
        card.addSubview(icon)
        icon.translatesAutoresizingMaskIntoConstraints = false

        let title = makePlainLabel("wallet", size: 23, color: .white, weight: .bold)
        title.isUserInteractionEnabled = false
        card.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false

        let amount = makePlainLabel("\(user?.balance ?? 0)", size: 18, color: .white, weight: .bold)
        amount.isUserInteractionEnabled = false
        card.addSubview(amount)
        amount.translatesAutoresizingMaskIntoConstraints = false

        let diamond = makePlainLabel(petalTrailCompleteText.diamond, size: 15, color: .white, weight: .bold)
        diamond.isUserInteractionEnabled = false
        card.addSubview(diamond)
        diamond.translatesAutoresizingMaskIntoConstraints = false

        let recharge = UIButton(type: .system)
        recharge.backgroundColor = .white
        recharge.layer.cornerRadius = 31
        recharge.setTitle("Recharge", for: .normal)
        recharge.setTitleColor(UIColor(red: 1.0, green: 0.286, blue: 0.612, alpha: 1.0), for: .normal)
        recharge.titleLabel?.font = auroraLoginFont.peace(23, weight: .bold)
        recharge.addTarget(self, action: #selector(openWallet), for: .touchUpInside)
        card.addSubview(recharge)
        recharge.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            icon.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 12),
            icon.topAnchor.constraint(equalTo: card.topAnchor, constant: 13),
            icon.widthAnchor.constraint(equalToConstant: 36),
            icon.heightAnchor.constraint(equalToConstant: 36),
            title.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 7),
            title.centerYAnchor.constraint(equalTo: icon.centerYAnchor),
            amount.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 17),
            amount.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 9),
            diamond.leadingAnchor.constraint(equalTo: amount.trailingAnchor, constant: 5),
            diamond.centerYAnchor.constraint(equalTo: amount.centerYAnchor, constant: 1),
            recharge.trailingAnchor.constraint(equalTo: card.trailingAnchor),
            recharge.centerYAnchor.constraint(equalTo: card.centerYAnchor),
            recharge.widthAnchor.constraint(equalToConstant: 132),
            recharge.heightAnchor.constraint(equalToConstant: 62)
        ])
        return card
    }

    private func menuCard() -> UIView {
        let card = UIView()
        card.backgroundColor = .white
        card.layer.cornerRadius = 28
        card.layer.masksToBounds = true

        let first = menuButton(
            title: petalTrailCompleteText.modifyProfile,
            icon: "lanhuProfileModifyIcon.png",
            selector: #selector(openEditor)
        )
        let second = menuButton(
            title: petalTrailCompleteText.settings,
            icon: "lanhuProfileSettingsIcon.png",
            selector: #selector(openSettings)
        )
        card.addSubview(first)
        card.addSubview(second)
        first.translatesAutoresizingMaskIntoConstraints = false
        second.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            first.leadingAnchor.constraint(equalTo: card.leadingAnchor),
            first.trailingAnchor.constraint(equalTo: card.trailingAnchor),
            first.topAnchor.constraint(equalTo: card.topAnchor),
            first.heightAnchor.constraint(equalToConstant: 68),
            second.leadingAnchor.constraint(equalTo: card.leadingAnchor),
            second.trailingAnchor.constraint(equalTo: card.trailingAnchor),
            second.topAnchor.constraint(equalTo: first.bottomAnchor),
            second.heightAnchor.constraint(equalToConstant: 68)
        ])
        return card
    }

    private func menuButton(title: String, icon: String, selector: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: selector, for: .touchUpInside)

        let iconView = UIImageView(image: auroraLoginAsset.image(icon))
        iconView.contentMode = .scaleAspectFit
        iconView.isUserInteractionEnabled = false
        button.addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false

        let titleLabel = makePlainLabel(title, size: 22, color: .black, weight: .bold)
        titleLabel.isUserInteractionEnabled = false
        button.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let chevron = UIImageView(image: auroraLoginAsset.image("lanhuProfileChevron.png"))
        chevron.contentMode = .scaleAspectFit
        chevron.isUserInteractionEnabled = false
        button.addSubview(chevron)
        chevron.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 19),
            iconView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 28),
            iconView.heightAnchor.constraint(equalToConstant: 28),
            titleLabel.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 74),
            titleLabel.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: chevron.leadingAnchor, constant: -12),
            chevron.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -24),
            chevron.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            chevron.widthAnchor.constraint(equalToConstant: 16),
            chevron.heightAnchor.constraint(equalToConstant: 16)
        ])
        return button
    }

    @objc private func openWallet() {
        navigationController?.pushViewController(cinderCoinWalletViewController(), animated: true)
    }

    @objc private func openEditor() {
        navigationController?.pushViewController(blushNameEditorViewController(), animated: true)
    }

    @objc private func openSettings() {
        navigationController?.pushViewController(ivoryMenuSettingsViewController(), animated: true)
    }
}
