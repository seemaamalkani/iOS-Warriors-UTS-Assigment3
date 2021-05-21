

import Foundation
import NotificationBannerSwift

class NotificationsViewController: UIViewController {
    
    @IBOutlet var myButton:UIButton!

    @IBAction func btnDashboard(_ sender: Any) {
        
        //Navigates to the dshboard page.
         let destinationView = self.storyboard?.instantiateViewController(withIdentifier: "LandingPageViewController") as! LandingPageViewController
         
         present(destinationView, animated:true, completion: nil);
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapButton(){
        //Show notification
        let notification = NotificationBanner(title: "You have a new message", subtitle: "Eric: Hello student, you have assignment deadline tomorrow", leftView: nil, rightView: nil, style:.info, colors: nil)
        
        notification.show()
    }
}

