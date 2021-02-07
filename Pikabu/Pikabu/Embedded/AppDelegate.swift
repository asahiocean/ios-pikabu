import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    internal(set) public var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //        let size = UIScreen.main.bounds
        //        window = .init(frame: size)
        //        defaultConfig(window)
        DispatchQueue(label: "com.report.launch", qos: .utility).async {
            API.post(with: ["REPORT":"APP LAUNCH"])
        }
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) { }
}
