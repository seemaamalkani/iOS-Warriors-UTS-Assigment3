

import Foundation
class Student: Codable{
    var FirstName: String;
    var MiddleName: String;
    var LastName: String;
    var StudentId: String;
    var EmailAddress: String;
    var Password: String;
    
    //use this constructor to initialise new object which is used to add values.
    init(){
        self.FirstName = ""
        self.MiddleName = ""
        self.LastName = ""
        self.StudentId = ""
        self.EmailAddress = ""
        self.Password = ""
    }
    
    //use this constructor to copy the existing values
    init(studentId: String, firstName: String, middleName: String, lastName: String, emailAddress: String, password: String){
        self.EmailAddress = emailAddress
        self.FirstName = firstName
        self.MiddleName = middleName
        self.LastName = lastName
        self.StudentId = studentId
        self.Password = password
    }
}
