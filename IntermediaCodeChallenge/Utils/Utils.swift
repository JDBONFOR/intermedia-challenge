import UIKit
import CommonCrypto

class Utils: NSObject {
    
    // Loader
    static func showLoader(in controller: UIViewController) {
                
        let loaderVC = LoaderViewController()
        loaderVC.modalPresentationStyle = .overCurrentContext
        loaderVC.modalTransitionStyle = .crossDissolve
                
        controller.present(loaderVC, animated: false, completion: nil)
    }
    
    static func hideLoader(in controller: UIViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    // Toast
    static func showToast(in controller: UIViewController,
                          backgroundColor: UIColor,
                          title: String) {
                
        let toastVC = ToastVC()
        toastVC.modalPresentationStyle = .overCurrentContext
        toastVC.modalTransitionStyle = .crossDissolve
        
        toastVC.backgroundColor = backgroundColor
        toastVC.message = title
                
        controller.present(toastVC, animated: false, completion: {
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
    
    // Date formatter
    public static func formateDate(_ date: String) -> String {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "d MMMM yyyy"

        if let newDate = dateFormatterGet.date(from: date) {
            return dateFormatterPrint.string(from: newDate)
        } else {
            return ""
        }
        
    }
    
}
