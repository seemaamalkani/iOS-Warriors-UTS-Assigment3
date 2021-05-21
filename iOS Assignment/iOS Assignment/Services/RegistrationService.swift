
import Foundation
import Firebase
import FirebaseDatabase
class ResgistrationService{
    let SUCCESS = "SUCCESS";
    let FAILURE = "FAILURE!";
    let STUDENT_LIST = "StudentList";
    let userDefaults = UserDefaults.standard;
    let CURRENT_USER = "CurrentUser";
    let EMAIL_PASSWORD_PAIR = "userEmailPasswords"
    
    var emailPasswordDictionary = [String:String]()
    
    // The static variable is used to make sure its value is not lost in the application
    static var currentStudent: Student = Student()
    
    var ref: DatabaseReference
    
    init() {
        ref = Database.database().reference()
    }
    
    //gets the current user or adds (if empty) or updates (to replace other value) the current user.
    var CurrentUser: String {
        get {
            return userDefaults.string(forKey: CURRENT_USER) ?? "";
        }set {
            userDefaults.set(newValue, forKey: CURRENT_USER);
        }
    }
    
    func saveEmailPasswordToDictionary(_ emailAddress: String, _ password: String){
        emailPasswordDictionary.updateValue(password, forKey: emailAddress)
        userDefaults.set(emailPasswordDictionary, forKey: EMAIL_PASSWORD_PAIR)
    }
    
    func checkPasswordForEmail(_ emailAddress: String) -> String {
        let userPassword = userDefaults.dictionary(forKey: EMAIL_PASSWORD_PAIR) as? Dictionary<String, String>;
        if let password = userPassword![emailAddress]{
            return password
        }else{
            return "";
        }
    }
    
    
    
    //This function adds new student or updates an existing student.
    func SaveStudent(_ newStudentObject: Student) -> String {
        
        do{
            let studentItem = try JSONEncoder().encode(newStudentObject)
            if let studentString = String(data: studentItem, encoding: .utf8){
                
                ref.child(STUDENT_LIST).child(newStudentObject.StudentId).setValue(studentString)
            }
        }catch{
            return "\(FAILURE) \(error.localizedDescription)";
        }
        
        return SUCCESS;
    }
    
    
    
    //This function loads an student associated with the given StudentId.
    func GetStudentById(_ studentId: String, completion: @escaping (Student) -> Void) {
        
               ref.child(STUDENT_LIST).child(studentId).observeSingleEvent(of: .value, with: {
             (snapshot) -> Void in
            
             if let jsonString = snapshot.value as? String{
                
                 if  let jsonData = jsonString.data(using: .utf8){
                 
                 let decoder = JSONDecoder()
                 do{
                      let studentObj = try decoder.decode(Student.self, from: jsonData)
                   completion(studentObj)
                    
                 }catch{
                    print(error.localizedDescription)
                 }
                 }
                 
             }
         }
        )
    }
    
    //This function loads an student associated with the given email address.
    func GetStudentByEmail(_ email: String, completion: @escaping (Student) -> Void){
        
        GetStudentDictionary { (itemList) in
            
            let filteredItem = itemList.filter{
                $0.EmailAddress.contains(email)
            }
            if let firstItem = filteredItem.first{
                completion(firstItem)
            }else {
                //
            }
        }
    }

    
    //This function loads the list of all the available student
    func GetStudentDictionary(completion: @escaping ([Student]) -> Void) {
        
        ref.child(STUDENT_LIST).observe(.value, with:{ snapshot in
            //print(snapshot.value as! [String:Any])
            var studentList: [Student] = []
            if let dictData =  snapshot.value as? [String: Any]{
                let decoder = JSONDecoder();
                for(_, value) in dictData{
                    
                    if let jsonString = value as? String{
                        if let jsonData = jsonString.data(using: .utf8){
                            
                            do{
                                let studentObj = try decoder.decode(Student.self, from: jsonData)
                                //persist the loaded data
                                self.saveEmailPasswordToDictionary(studentObj.EmailAddress, studentObj.Password)
                                studentList.append(studentObj)
                            }catch{
                                print(error.localizedDescription)
                            }
                        }
                    }
                    
                }
                completion(studentList)
            }
        })
       }
    
}
