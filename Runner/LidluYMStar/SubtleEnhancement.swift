//
//  SubtleEnhancement.swift
//  Runner
//
//  Created by  on 2026/5/12.
//

import UIKit


//loading 提示框 控件

class SubtleEnhancement {
    
    static let shared = SubtleEnhancement()
    private var APPPREFIX_overlayWindow: UIWindow?
       
    private var APPPREFIX_containerView: UIView?
    private var APPPREFIX_indicator: UIActivityIndicatorView?
    private var APPPREFIX_messageLabel: UILabel?
    private var APPPREFIX_iconView: UIImageView?
    // MARK: - Show Loading
    class func APPPREFIX_show(APPPREFIX_info:String) {
        shared.APPPREFIX_present(APPPREFIX_message: APPPREFIX_info, APPPREFIX_icon: nil, APPPREFIX_isLoading: true)
    }
    
    // MARK: - Show Info
    class func APPPREFIX_showInfo(APPPREFIX_withStatus message: String) {//系统图片 不要改动
        shared.APPPREFIX_present(APPPREFIX_message: message, APPPREFIX_icon: UIImage(systemName: IceCreamDrip.APPPREFIX_5), APPPREFIX_isLoading: false)
    }
    
    // MARK: - Show Success
    class func APPPREFIX_showSuccess(APPPREFIX_withStatus message: String) {//系统图片 不要改动
        shared.APPPREFIX_present(APPPREFIX_message: message, APPPREFIX_icon: UIImage(systemName: IceCreamDrip.APPPREFIX_6), APPPREFIX_isLoading: false)
    }
    
    // MARK: - Dismiss
    class func APPPREFIX_dismiss() {
        shared.APPPREFIX_dismissIndicator()
    }
    
    // MARK: - Core View
    private func APPPREFIX_present(APPPREFIX_message: String, APPPREFIX_icon: UIImage?, APPPREFIX_isLoading: Bool) {
            APPPREFIX_dismissIndicator()
            
            let APPPREFIX_window = UIWindow(frame: UIScreen.main.bounds)
            APPPREFIX_window.windowLevel = .alert + 1
            APPPREFIX_window.backgroundColor = .clear
            
            let APPPREFIX_container = UIView()
            APPPREFIX_container.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            APPPREFIX_container.layer.cornerRadius = 14
            APPPREFIX_container.translatesAutoresizingMaskIntoConstraints = false
            
            let APPPREFIX_stack = UIStackView()
            APPPREFIX_stack.axis = .vertical
            APPPREFIX_stack.alignment = .center
            APPPREFIX_stack.spacing = 12
            APPPREFIX_stack.translatesAutoresizingMaskIntoConstraints = false
            
            let APPPREFIX_indicatorView = UIActivityIndicatorView(style: .large)
            APPPREFIX_indicatorView.color = .white
        APPPREFIX_indicatorView.stopAnimating()
            let APPPREFIX_imageView = UIImageView(image: APPPREFIX_icon)
            APPPREFIX_imageView.tintColor = .white
            APPPREFIX_imageView.contentMode = .scaleAspectFit
            APPPREFIX_imageView.translatesAutoresizingMaskIntoConstraints = false
            APPPREFIX_imageView.widthAnchor.constraint(equalToConstant: 36).isActive = true
            APPPREFIX_imageView.heightAnchor.constraint(equalToConstant: 36).isActive = true
            
            let APPPREFIX_label = UILabel()
            APPPREFIX_label.text = APPPREFIX_message
            APPPREFIX_label.textColor = .white
            APPPREFIX_label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            APPPREFIX_label.numberOfLines = 2
            APPPREFIX_label.textAlignment = .center
            
            if APPPREFIX_isLoading {
                APPPREFIX_stack.addArrangedSubview(APPPREFIX_indicatorView)
                APPPREFIX_indicatorView.startAnimating()
            } else if let icon = APPPREFIX_icon {
                APPPREFIX_stack.addArrangedSubview(APPPREFIX_imageView)
            }
            APPPREFIX_stack.addArrangedSubview(APPPREFIX_label)
            
            APPPREFIX_container.addSubview(APPPREFIX_stack)
            APPPREFIX_window.addSubview(APPPREFIX_container)
            
            NSLayoutConstraint.activate([
                APPPREFIX_container.centerXAnchor.constraint(equalTo: APPPREFIX_window.centerXAnchor),
                APPPREFIX_container.centerYAnchor.constraint(equalTo: APPPREFIX_window.centerYAnchor),
                APPPREFIX_container.widthAnchor.constraint(lessThanOrEqualToConstant: 200),
                
                APPPREFIX_stack.topAnchor.constraint(equalTo: APPPREFIX_container.topAnchor, constant: 20),
                APPPREFIX_stack.bottomAnchor.constraint(equalTo: APPPREFIX_container.bottomAnchor, constant: -20),
                APPPREFIX_stack.leadingAnchor.constraint(equalTo: APPPREFIX_container.leadingAnchor, constant: 16),
                APPPREFIX_stack.trailingAnchor.constraint(equalTo: APPPREFIX_container.trailingAnchor, constant: -16),
            ])
            
            APPPREFIX_window.makeKeyAndVisible()
            
            APPPREFIX_overlayWindow = APPPREFIX_window
            APPPREFIX_containerView = APPPREFIX_container
            APPPREFIX_indicator = APPPREFIX_indicatorView
            APPPREFIX_messageLabel = APPPREFIX_label
            APPPREFIX_iconView = APPPREFIX_imageView
            
            // 轻微缩放动画
            APPPREFIX_container.alpha = 0
            APPPREFIX_container.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
            UIView.animate(withDuration: 0.25,
                           delay: 0,
                           usingSpringWithDamping: 0.7,
                           initialSpringVelocity: 0.8,
                           options: .curveEaseOut,
                           animations: {
                APPPREFIX_container.alpha = 1
                APPPREFIX_container.transform = .identity
            })
            
            // 自动隐藏非 loading 的提示
            if !APPPREFIX_isLoading {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                    self?.APPPREFIX_dismissIndicator()
                }
            }
        }
        
        private func APPPREFIX_dismissIndicator() {
            self.APPPREFIX_overlayWindow?.isHidden = true
            self.APPPREFIX_overlayWindow = nil
            self.APPPREFIX_containerView = nil
            self.APPPREFIX_indicator?.stopAnimating()
            self.APPPREFIX_indicator = nil
            self.APPPREFIX_messageLabel = nil
        }
    }

