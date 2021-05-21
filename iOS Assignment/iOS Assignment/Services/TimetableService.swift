

import Foundation
import Firebase
import FirebaseDatabase
class TimetableService {
    
    let SUCCESS = "SUCCESS";
    let FAILURE = "FAILURE!";
    let TIMETABLE_LIST = "TimetableList"
    var ref: DatabaseReference
    
    //the timetable list of the current students which will be available across the system as long as the user is logged in.
    //Note: This field should be refreshed from firebase database everytime we update the timetable. this field should be cleared everytime we do the log out.
    static var currentStudentTimetableList: [Timetable] = [Timetable]()
     
     init() {
         ref = Database.database().reference()
     }
    
    //saves a timetable in the system.
    func Save(_ timetable: Timetable, completion: @escaping(String)-> Void) {
         do{
             let timeTbl = try JSONEncoder().encode(timetable)
             if let subString = String(data: timeTbl, encoding: .utf8){
                ref.child(TIMETABLE_LIST).child(timetable.Id).setValue(subString)
                completion(SUCCESS)
             }
         }catch{
            completion("\(FAILURE) \(error.localizedDescription)")
         }
     }
    
    //loads the timetable associated with a timetable Id.
    func GetById(_ id: String, completion: @escaping(Timetable) -> Void){
        ref.child(TIMETABLE_LIST).child(id).observeSingleEvent(of: .value, with: { (snapshot) in
            if let jsonString = snapshot.value as? String{
                if let jsonData = jsonString.data(using: .utf8){
                    let decoder = JSONDecoder()
                    do{
                        let timetableObj = try decoder.decode(Timetable.self, from: jsonData)
                        completion(timetableObj)
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }
        })
    }
    
    //loads all the timetables associated with a student.
    func GetListByStudentCode(_ studentId: String, completion: @escaping ([Timetable]) -> Void){
        GetList { (timetableList) in
            let filteredItems = timetableList.filter { (item) -> Bool in
                item.StudentId == studentId
            }
            completion(filteredItems)
        }
    }
    
    //loads all the timetable available in the system.
    func GetList(completion: @escaping ([Timetable]) -> Void){
         
         ref.child(TIMETABLE_LIST).observe(.value, with:{ snapshot in
              
              var timetableList: [Timetable] = []
              if let dictData =  snapshot.value as? [String: Any]{
                  let decoder = JSONDecoder();
                  for(_, value) in dictData{
                      
                      if let jsonString = value as? String{
                          if let jsonData = jsonString.data(using: .utf8){
                              
                              do{
                                  let timetableObj = try decoder.decode(Timetable.self, from: jsonData)
                                  timetableList.append(timetableObj)
                              }catch{
                                  print(error.localizedDescription)
                              }
                          }
                      }
                      
                  }
                  completion(timetableList)
              }
          })
     }
    
    
    
}
