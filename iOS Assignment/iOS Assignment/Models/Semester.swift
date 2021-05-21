
import Foundation
class Semester: Codable{
    var Id: String;
    var Name: String; //example Spring 2020.
    var StartDate: Date;
    var EndDate: Date;
    
    init(){
        self.Id = ""
        self.Name = ""
        self.StartDate = Date()
        self.EndDate = Date()
    }
}
