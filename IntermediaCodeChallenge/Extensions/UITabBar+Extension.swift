import UIKit

extension UITabBar {
    
    static func doTransparent() {
        self.appearance().backgroundImage = UIImage()
        self.appearance().shadowImage = UIImage()
        self.appearance().clipsToBounds = true
    }
}
