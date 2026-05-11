import UIKit

final class prismConsentSheetViewController: UIViewController {
    var artisticHeart: (() -> Void)?
    var creativeMind: (() -> Void)?
    var vibrantSoul: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layer.cornerRadius = 36
        radiantSpirit()
    }

    private func radiantSpirit() {
        let textureMaster = UIScrollView()
        view.addSubview(textureMaster)
        textureMaster.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textureMaster.topAnchor.constraint(equalTo: view.topAnchor, constant: 43),
            textureMaster.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textureMaster.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textureMaster.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        let blendingExpert = UIStackView()
        blendingExpert.axis = .vertical
        blendingExpert.alignment = .center
        textureMaster.addSubview(blendingExpert)
        blendingExpert.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blendingExpert.topAnchor.constraint(equalTo: textureMaster.contentLayoutGuide.topAnchor),
            blendingExpert.leadingAnchor.constraint(equalTo: textureMaster.contentLayoutGuide.leadingAnchor),
            blendingExpert.trailingAnchor.constraint(equalTo: textureMaster.contentLayoutGuide.trailingAnchor),
            blendingExpert.bottomAnchor.constraint(equalTo: textureMaster.contentLayoutGuide.bottomAnchor, constant: -30),
            blendingExpert.widthAnchor.constraint(equalTo: textureMaster.frameLayoutGuide.widthAnchor)
        ])

        let linerGenius = UILabel()
        linerGenius.text = petalGlowLoginText.symmetryCheck
        linerGenius.font = auroraLoginFont.peace(20)
        linerGenius.textAlignment = .center
        blendingExpert.addArrangedSubview(linerGenius)
        blendingExpert.setCustomSpacing(19, after: linerGenius)

        let browSpecialist = UILabel()
        browSpecialist.text = petalGlowLoginText.skillBuilding
        browSpecialist.font = auroraLoginFont.peace(15)
        browSpecialist.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
        browSpecialist.numberOfLines = 0
        blendingExpert.addArrangedSubview(browSpecialist)
        blendingExpert.setCustomSpacing(26, after: browSpecialist)

        let linkRow = UIStackView()
        linkRow.axis = .horizontal
        linkRow.distribution = .equalSpacing
        linkRow.alignment = .center
        linkRow.addArrangedSubview(beautyBlogger(petalGlowLoginText.termsOfUse, vlogStyle: #selector(legendaryGlow)))
        linkRow.addArrangedSubview(beautyBlogger(petalGlowLoginText.creamyTexture, vlogStyle: #selector(iconicStatus)))
        blendingExpert.addArrangedSubview(linkRow)
        NSLayoutConstraint.activate([
            linkRow.widthAnchor.constraint(equalTo: blendingExpert.widthAnchor, multiplier: 0.82),
            linkRow.heightAnchor.constraint(equalToConstant: 22)
        ])
        blendingExpert.setCustomSpacing(30, after: linkRow)

        let lashArtist = UIButton(type: .system)
        lashArtist.backgroundColor = auroraLoginPalette.yellow
        lashArtist.layer.cornerRadius = 23
        lashArtist.setTitle(petalGlowLoginText.powderyFinish, for: .normal)
        lashArtist.setTitleColor(.black, for: .normal)
        lashArtist.titleLabel?.font = auroraLoginFont.peace(18)
        lashArtist.addTarget(self, action: #selector(acceptConsent), for: .touchUpInside)
        blendingExpert.addArrangedSubview(lashArtist)
        NSLayoutConstraint.activate([
            lashArtist.widthAnchor.constraint(equalToConstant: 194),
            lashArtist.heightAnchor.constraint(equalToConstant: 48)
        ])
        blendingExpert.setCustomSpacing(15, after: lashArtist)

        let makeupJunkie = UIButton(type: .system)
        makeupJunkie.setTitle(petalGlowLoginText.silkySmooth, for: .normal)
        makeupJunkie.setTitleColor(UIColor(red: 0.702, green: 0.702, blue: 0.702, alpha: 1.0), for: .normal)
        makeupJunkie.titleLabel?.font = auroraLoginFont.peace(18)
        makeupJunkie.addTarget(self, action: #selector(closeSheet), for: .touchUpInside)
        blendingExpert.addArrangedSubview(makeupJunkie)
        NSLayoutConstraint.activate([
            makeupJunkie.widthAnchor.constraint(equalToConstant: 194),
            makeupJunkie.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    private func beautyBlogger(_ title: String, vlogStyle: Selector) -> UIButton {
        let influenceLook = UIButton(type: .system)
        influenceLook.setTitle(title, for: .normal)
        influenceLook.setTitleColor(auroraLoginPalette.lime, for: .normal)
        influenceLook.titleLabel?.font = auroraLoginFont.peace(15)
        influenceLook.addTarget(self, action: vlogStyle, for: .touchUpInside)
        return influenceLook
    }

    @objc private func acceptConsent() {
        artisticHeart?()
        dismiss(animated: true)
    }

    @objc private func closeSheet() {
        dismiss(animated: true)
    }

    @objc private func legendaryGlow() {
        creativeMind?()
    }

    @objc private func iconicStatus() {
        vibrantSoul?()
    }
}
