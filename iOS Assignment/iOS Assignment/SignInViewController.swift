

import UIKit
import Foundation
import FirebaseDatabase

class SignInViewController: UIViewController {
    
    let regoService = ResgistrationService()

    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //The async method is called while loading so that the sign button click will be able to check the value without waiting.
        regoService.GetStudentDictionary { (itemList) in
        }
    }
    
    //On SigningIn run the below
    @IBAction func signInButton(_ sender: Any) {
         SignIn()
     }
    
    func SignIn(){
        if let txtEmailWithValue = emailAddress.text, !txtEmailWithValue.isEmpty{
            if let txtPasswordWithValue = password.text, !txtPasswordWithValue.isEmpty{
                 //Check with the database
                let userPassword = regoService.checkPasswordForEmail(self.emailAddress.text!);
                     if(self.password.text! != userPassword){
                         let errorMsg = UIAlertController(title: "Invalid email or password!", message: "Please check your details and enter again", preferredStyle: UIAlertController.Style.alert);
                          //Add an action (button)
                        errorMsg.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil));
                        //Show the alert
                        self.present(errorMsg, animated: true, completion: nil);
                     }else {
                         //Set the current user in the system.
                         regoService.CurrentUser = self.emailAddress.text!;
                         //Go to the landing page.
                         let landingPage = storyboard?.instantiateViewController(withIdentifier: "LandingPageViewController") as! LandingPageViewController
                         present(landingPage, animated: true, completion: nil);
                 }
            }
            //Add alert
            let errorMsg = UIAlertController(title: "Password is required", message: "Enter the password", preferredStyle: UIAlertController.Style.alert);
            //Add an action (button)
            errorMsg.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil));
            //Show the alert
            self.present(errorMsg, animated: true, completion: nil);
        } else {
            //Add alert
            let errorMsg = UIAlertController(title: "Email is required", message: "Enter the email", preferredStyle: UIAlertController.Style.alert);
            //Add an action (button)
            errorMsg.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil));
            //Show the alert
            self.present(errorMsg, animated: true, completion: nil);
        }
    }
}
