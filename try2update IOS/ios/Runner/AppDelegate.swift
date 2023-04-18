import Flutter
import LeanCloud
import UserNotifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        do {
                   
            LCApplication.logLevel = .all
            try LCApplication.default.set(
                 id: "vLjk73Kg9j1qWLs8yI8PUn61-gzGzoHsz",
                               key: "QGpcS9G0SD2KJOaqSpC99mjY",
                               serverURL: "https://vljk73kg.lc-cn-n1-shared.com")
            GeneratedPluginRegistrant.register(with: self)
            /*
            register APNs to access token, like this:
            */
            UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                switch settings.authorizationStatus {
                case .authorized:
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                case .notDetermined:
                    UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound]) { (granted, error) in
                        if granted {
                            DispatchQueue.main.async {
                                UIApplication.shared.registerForRemoteNotifications()
                            }
                        }
                    }
                default:
                    break
                }
                _ = LCApplication.default.currentInstallation
            }
            return super.application(application, didFinishLaunchingWithOptions: launchOptions)
        } catch {
            fatalError("\(error)")
        }
    }

    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("测试")
        /*
        set APNs deviceToken and Team ID.
        */
        LCApplication.default.currentInstallation.set(
            deviceToken: deviceToken,
            apnsTeamId: "7J5XFNL99Q")
        /*
        save to LeanCloud.
        */
        LCApplication.default.currentInstallation.save { (result) in
            switch result {
            case .success:
                break
            case .failure(error: let error):
                print(error)
            }
        }
    }
    override func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
    
override func applicationDidBecomeActive(_ application: UIApplication) {
    //本地清空角标
    application.applicationIconBadgeNumber = 0
    //currentInstallation 的角标清零
    LCApplication.default.currentInstallation.badge = 0
    LCApplication.default.currentInstallation.save { (result) in
        switch result {
        case .success:
            break
        case .failure(error: let error):
            print(error)
        }
    }
    
 }
}


