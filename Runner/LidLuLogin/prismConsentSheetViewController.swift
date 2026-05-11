import UIKit

final class prismConsentSheetViewController: UIViewController {
    var onAgree: (() -> Void)?
    var onTerms: (() -> Void)?
    var onPrivacy: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layer.cornerRadius = 36
        buildScene()
    }

    private func buildScene() {
        let scroll = UIScrollView()
        view.addSubview(scroll)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: view.topAnchor, constant: 43),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        scroll.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor),
            stack.leadingAnchor.constraint(equalTo: scroll.contentLayoutGuide.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: scroll.contentLayoutGuide.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor, constant: -30),
            stack.widthAnchor.constraint(equalTo: scroll.frameLayoutGuide.widthAnchor)
        ])

        let title = UILabel()
        title.text = petalGlowLoginText.eula
        title.font = auroraLoginFont.peace(20)
        title.textAlignment = .center
        stack.addArrangedSubview(title)
        stack.setCustomSpacing(19, after: title)

        let body = UILabel()
        body.text = petalGlowLoginText.eulaBody
        body.font = auroraLoginFont.peace(15)
        body.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
        body.numberOfLines = 0
        stack.addArrangedSubview(body)
        stack.setCustomSpacing(26, after: body)

        let linkRow = UIStackView()
        linkRow.axis = .horizontal
        linkRow.distribution = .equalSpacing
        linkRow.alignment = .center
        linkRow.addArrangedSubview(linkButton(petalGlowLoginText.termsOfUse, selector: #selector(openTerms)))
        linkRow.addArrangedSubview(linkButton(petalGlowLoginText.privacyPolicy, selector: #selector(openPrivacy)))
        stack.addArrangedSubview(linkRow)
        NSLayoutConstraint.activate([
            linkRow.widthAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 0.82),
            linkRow.heightAnchor.constraint(equalToConstant: 22)
        ])
        stack.setCustomSpacing(30, after: linkRow)

        let agree = UIButton(type: .system)
        agree.backgroundColor = auroraLoginPalette.yellow
        agree.layer.cornerRadius = 23
        agree.setTitle(petalGlowLoginText.agree, for: .normal)
        agree.setTitleColor(.black, for: .normal)
        agree.titleLabel?.font = auroraLoginFont.peace(18)
        agree.addTarget(self, action: #selector(acceptConsent), for: .touchUpInside)
        stack.addArrangedSubview(agree)
        NSLayoutConstraint.activate([
            agree.widthAnchor.constraint(equalToConstant: 194),
            agree.heightAnchor.constraint(equalToConstant: 48)
        ])
        stack.setCustomSpacing(15, after: agree)

        let cancel = UIButton(type: .system)
        cancel.setTitle(petalGlowLoginText.cancel, for: .normal)
        cancel.setTitleColor(UIColor(red: 0.702, green: 0.702, blue: 0.702, alpha: 1.0), for: .normal)
        cancel.titleLabel?.font = auroraLoginFont.peace(18)
        cancel.addTarget(self, action: #selector(closeSheet), for: .touchUpInside)
        stack.addArrangedSubview(cancel)
        NSLayoutConstraint.activate([
            cancel.widthAnchor.constraint(equalToConstant: 194),
            cancel.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    private func linkButton(_ title: String, selector: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(auroraLoginPalette.lime, for: .normal)
        button.titleLabel?.font = auroraLoginFont.peace(15)
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }

    @objc private func acceptConsent() {
        onAgree?()
        dismiss(animated: true)
    }

    @objc private func closeSheet() {
        dismiss(animated: true)
    }

    @objc private func openTerms() {
        onTerms?()
    }

    @objc private func openPrivacy() {
        onPrivacy?()
    }
}
