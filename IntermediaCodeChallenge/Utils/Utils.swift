import UIKit
import CommonCrypto

class Utils: NSObject {
    
    // Toast
    static func showToast(in controller: UIViewController,
                          backgroundColor: UIColor,
                          title: String) {
                
        let toastVC = ToastVC()
        toastVC.modalPresentationStyle = .overCurrentContext
        
        toastVC.backgroundColor = backgroundColor
        toastVC.message = title
                
        controller.present(toastVC, animated: true, completion: {
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: {_ in
                controller.dismiss(animated: true, completion: nil)
            })
        })
    }
    
    // Endpoint.plist
    public static func getEndpoints() -> [String: Any]? {
        guard let path = Bundle.main.path(forResource: Constants.EndpointDictionary, ofType: Constants.EndpointExtension) else {
            return nil
        }
        guard let dictionary = NSDictionary(contentsOfFile: path) else {
            return nil
        }
        guard let result = dictionary as? [String: Any] else {
            return nil
        }
        return result
    }
    
}
