

import UIKit
import FirebaseDatabase

class RegistrationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    //Default school selection
    let universities = ["Macquarie University", "University of New South Wales (UNSW)", "University of Sydney (USYD)", "University of Technology Sydney (UTS)"]
   
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var middleName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var studentID: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var selectedInstitution: UILabel!
    
    var rowLineUniversity = 0
    var providerCode = ""
    var registrationService = ResgistrationService()
    var timetableService = TimetableService();
    
    //On clicking Connect run registration
    @IBAction func connectButton(_ sender: Any) {
        registerStudent()
    }
    
    //Email address default
    override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
           if let viewController = segue.destination as? SignInViewController {
               viewController.emailAddress = emailAddress
           }
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Registration function
    func registerStudent(){
        let student1 = Student();
        student1.FirstName = firstName.text!
        student1.MiddleName = middleName.text!
        student1.LastName = lastName.text!
        student1.StudentId = studentID.text!
        student1.EmailAddress = emailAddress.text!
        student1.Password = password.text!
        
        let registrationStatus =  registrationService.SaveStudent(student1)
        
        if registrationStatus == "SUCCESS" {
            saveTimeTable();
            let alert = UIAlertController(title: "Success", message: "Record added", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(okAction)
            present(alert, animated:true)
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationView = storyBoard.instantiateViewController(withIdentifier: "SignInViewController")
             present(destinationView, animated:true, completion: nil);
            
             //       self.present(newViewController, animated: true, completion: nil)
            
        } else {
            let alert = UIAlertController(title: "Failed", message: "Please retry", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            present(alert, animated:true)
        }
    }
    
    func saveTimeTable(){
        let timeTbl = Timetable()
        timeTbl.Id = studentID.text!+providerCode
        timeTbl.Name = "\(firstName.text!)-\(lastName.text!)-\(providerCode)";
        timeTbl.ProviderId = providerCode;
        timeTbl.SemesterId = ""; //For next release
        timeTbl.StudentId = studentID.text!;
        timeTbl.SubjectCode = ""; //For next release
        timetableService.Save(timeTbl) {
            (item) in
            // do nothing at the moment.
        }
    }
    
    //Picker options and default values
    @IBAction func selectButton(_ sender: Any) {
        if rowLineUniversity == 0 {
            selectedInstitution.text = "Macquarie University"
            providerCode = "00001"
        } else if rowLineUniversity == 1 {
            selectedInstitution.text = "University of New South Wales (UNSW)"
            providerCode = "00002"
        } else if rowLineUniversity == 2 {
            selectedInstitution.text = "University of Sydney (USYD)"
            providerCode = "00003"
        } else if rowLineUniversity == 3 {
            selectedInstitution.text = "University of Technology Sydney (UTS)"
            providerCode = "1234"
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return universities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return universities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        rowLineUniversity = row
    }
  
    func hideKeyboard() {
        studentID.resignFirstResponder()
    }
}
