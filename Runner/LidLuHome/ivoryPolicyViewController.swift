import UIKit

final class ivoryPolicyViewController: UIViewController {
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
        buildScene()
    }

    private func buildScene() {
        let back = UIButton(type: .custom)
        back.setImage(auroraLoginAsset.image("zedDigitalEyeyelookRecommendationBlack.png"), for: .normal)
        back.addTarget(self, action: #selector(closePage), for: .touchUpInside)
        view.addSubview(back)
        back.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            back.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            back.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            back.widthAnchor.constraint(equalToConstant: 32),
            back.heightAnchor.constraint(equalToConstant: 32)
        ])

        let scroll = UIScrollView()
        view.addSubview(scroll)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: back.bottomAnchor, constant: 15),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        scroll.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor),
            stack.leadingAnchor.constraint(equalTo: scroll.contentLayoutGuide.leadingAnchor, constant: 12),
            stack.trailingAnchor.constraint(equalTo: scroll.contentLayoutGuide.trailingAnchor, constant: -12),
            stack.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor, constant: -30),
            stack.widthAnchor.constraint(equalTo: scroll.frameLayoutGuide.widthAnchor, constant: -24)
        ])

        let title = UILabel()
        title.text = kind == .privacy ? "Privacy Policy": "User Agreement"
        title.font = auroraLoginFont.peace(20, weight: .medium)
        title.textAlignment = .center
        stack.addArrangedSubview(title)
        stack.setCustomSpacing(15, after: title)

        let body = UILabel()
        body.text = kind == .privacy ? ivoryPolicyText.privacyBody : ivoryPolicyText.termsBody
        body.font = auroraLoginFont.peace(16, weight: .medium)
        body.textColor = .black
        body.numberOfLines = 0
        stack.addArrangedSubview(body)
    }

    @objc private func closePage() {
        navigationController?.popViewController(animated: true)
    }
}
