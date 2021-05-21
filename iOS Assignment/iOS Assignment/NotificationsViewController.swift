

import UIKit

class NotificationController: UIViewController{

    @IBAction func btnDashboard(_ sender: Any) {
        
        //Navigates to the dashboard page.
        let destinationView = self.storyboard?.instantiateViewController(withIdentifier: "LandingPageViewController") as! LandingPageViewController
        
        present(destinationView, animated:true, completion: nil);
    }
    
    override func viewDidLoad() {
    super.viewDidLoad()
   
   

}
}
