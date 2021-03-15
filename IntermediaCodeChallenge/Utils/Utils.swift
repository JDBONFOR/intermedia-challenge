import UIKit

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
    
}
