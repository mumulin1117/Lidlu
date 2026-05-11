import UIKit

final class ivorygorgeousFinishViewController: UIViewController {
    private let kind: ivoryPolicyKind

    init(kind: ivoryPolicyKind) {
        self.kind = kind
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        beautifulYou()
    }

    private func beautifulYou() {
        let creativeLidLu = UIButton(type: .custom)
        creativeLidLu.setImage(auroraLoginAsset.image("zedDigitalEyeyelookRecommendationBlack.png"), for: .normal)
        creativeLidLu.addTarget(self, action: #selector(eyeMagic), for: .touchUpInside)
        view.addSubview(creativeLidLu)
        creativeLidLu.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            creativeLidLu.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            creativeLidLu.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            creativeLidLu.widthAnchor.constraint(equalToConstant: 32),
            creativeLidLu.heightAnchor.constraint(equalToConstant: 32)
        ])

        let scroll = UIScrollView()
        view.addSubview(scroll)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: creativeLidLu.bottomAnchor, constant: 15),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        let makeupBlindBox = UIStackView()
        makeupBlindBox.axis = .vertical
        makeupBlindBox.alignment = .fill
        scroll.addSubview(makeupBlindBox)
        makeupBlindBox.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            makeupBlindBox.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor),
            makeupBlindBox.leadingAnchor.constraint(equalTo: scroll.contentLayoutGuide.leadingAnchor, constant: 12),
            makeupBlindBox.trailingAnchor.constraint(equalTo: scroll.contentLayoutGuide.trailingAnchor, constant: -12),
            makeupBlindBox.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor, constant: -30),
            makeupBlindBox.widthAnchor.constraint(equalTo: scroll.frameLayoutGuide.widthAnchor, constant: -24)
        ])

        let title = UILabel()
        title.text = kind == .stunningResult ? "Privacy Policy": "User Agreement"
        title.font = auroraLoginFont.peace(20, weight: .medium)
        title.textAlignment = .center
        makeupBlindBox.addArrangedSubview(title)
        makeupBlindBox.setCustomSpacing(15, after: title)

        let body = UILabel()
        body.text = kind == .stunningResult ? ivoryPolicyText.privacyBody : ivoryPolicyText.termsBody
        body.font = auroraLoginFont.peace(16, weight: .medium)
        body.textColor = .black
        body.numberOfLines = 0
        makeupBlindBox.addArrangedSubview(body)
    }

    @objc private func eyeMagic() {
        navigationController?.popViewController(animated: true)
    }
}
