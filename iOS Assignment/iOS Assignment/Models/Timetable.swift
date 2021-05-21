

import Foundation
class Timetable: Codable{
    var Id: String;
    var Name: String;
    var ProviderId: String;
    var SubjectCode: String;
    var SemesterId: String;
    var StudentId: String
    
    init(){
        self.Id = ""
        self.Name = ""
        self.ProviderId = ""
        self.SubjectCode = ""
        self.SemesterId = ""
        self.StudentId = ""
    }
    
}
