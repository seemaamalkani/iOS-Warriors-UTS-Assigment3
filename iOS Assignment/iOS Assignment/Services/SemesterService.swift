

import Foundation
import Firebase
import FirebaseDatabase
class SemesterService {
    
    let SUCCESS = "SUCCESS";
     let FAILURE = "FAILURE!";
     let SEMESTER_LIST = "SemesterList"
     
     var ref: DatabaseReference
      
      init() {
          ref = Database.database().reference()
      }
    
    func Save(_ semester: Semester, completion: @escaping(String)-> Void) {
          do{
              let dataValue = try JSONEncoder().encode(semester)
              if let dataString = String(data: dataValue, encoding: .utf8){
                 ref.child(SEMESTER_LIST).child(semester.Id).setValue(dataString)
                 completion(SUCCESS)
              }
          }catch{
             completion("\(FAILURE) \(error.localizedDescription)")
          }
      }
    
    func GetById(_ id: String, completion: @escaping(Semester) -> Void){
         ref.child(SEMESTER_LIST).child(id).observeSingleEvent(of: .value, with: { (snapshot) in
             if let jsonString = snapshot.value as? String{
                 if let jsonData = jsonString.data(using: .utf8){
                     let decoder = JSONDecoder()
                     do{
                         let semesterObj = try decoder.decode(Semester.self, from: jsonData)
                         completion(semesterObj)
                     }catch{
                         print(error.localizedDescription)
                     }
                 }
             }
         })
     }
    
    func GetList(completion: @escaping ([Semester]) -> Void){
            
            ref.child(SEMESTER_LIST).observe(.value, with:{ snapshot in
                 
                 var dataList: [Semester] = []
                 if let dictData =  snapshot.value as? [String: Any]{
                     let decoder = JSONDecoder();
                     for(_, value) in dictData{
                         
                         if let jsonString = value as? String{
                             if let jsonData = jsonString.data(using: .utf8){
                                 
                                 do{
                                     let dataObj = try decoder.decode(Semester.self, from: jsonData)
                                     dataList.append(dataObj)
                                 }catch{
                                     print(error.localizedDescription)
                                 }
                             }
                         }
                         
                     }
                     completion(dataList)
                 }
             })
        }
    
    //converts a valid string of date to Date type value.
    func GetDateFromStringFromatValue(_ dateValue: String, _ stringFormat: String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = stringFormat; //example: dd/MM/yyyy
        
        let valueInDateType = dateFormatter.date(from: dateValue);
        
        return valueInDateType ?? Date()
    }
    
    //converts a Date type value to string date
    func GateDateStringFromDate(dateValue: Date) -> String {
         let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .full
        
        return dateFormatter.string(from: dateValue)
    }
    
    
    
    
}
