import UIKit
import UserNotifications

@main
final class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    var window: UIWindow?
     let nativeRoot = UINavigationController()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        configureNotifications(application)
        installNativeRoot()
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        velvetAuraStore.shared.pushToken = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
    }

    private func configureNotifications(_ application: UIApplication) {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
                if granted {
                    DispatchQueue.main.async {
                        application.registerForRemoteNotifications()
                    }
                }
            }
        } else {
            let settings = UIUserNotificationSettings(types: [.alert, .sound, .badge], categories: nil)
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        }
    }

     func installNativeRoot() {
        window = UIWindow(frame: UIScreen.main.bounds)
        nativeRoot.setNavigationBarHidden(true, animated: false)
        if velvetAuraStore.shared.choseMain {
            nativeRoot.setViewControllers([prismRootTabsViewController(initialIndex: 1)], animated: false)
        } else {
            nativeRoot.setViewControllers([makeLoginGate()], animated: false)
        }
        window?.rootViewController = nativeRoot
        window?.makeKeyAndVisible()
    }

     func makeLoginGate() -> velvetEntryGateViewController {
        let page = velvetEntryGateViewController()
        page.visualDiary = { [weak self] in
            self?.nativeRoot.setViewControllers([prismRootTabsViewController(initialIndex: 1)], animated: true)
        }
        page.portfolioPiece = { [weak self] in
            self?.nativeRoot.pushViewController(ivorygorgeousFinishViewController(kind: .epicTransformation), animated: true)
        }
        page.creativeCanvas = { [weak self] in
            self?.nativeRoot.pushViewController(ivorygorgeousFinishViewController(kind: .stunningResult), animated: true)
        }
        return page
    }
}
