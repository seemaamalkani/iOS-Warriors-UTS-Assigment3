
import Foundation
class EducationProvider: Codable{
    var Code: String;
    var Name: String;
    var Location: String
    
    //use this to initialise the new object
    init(){
        self.Code = ""
        self.Name = ""
        self.Location = ""
    }
}
