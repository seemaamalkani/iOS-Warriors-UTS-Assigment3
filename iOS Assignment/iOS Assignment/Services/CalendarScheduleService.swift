

import Foundation
import  Firebase
class CalendarScheduleService {
    
    let SUCCESS = "SUCCESS";
      let FAILURE = "FAILURE!";
      let CALENDAR_SCHEDULE_LIST = "CalendarScheduleList"
      
      var ref: DatabaseReference
    
    // The static variable is used to make sure its value is not lost in the application
    static var currentStudentScheduleList: [CalendarSchedule] = [CalendarSchedule]()
       
       init() {
           ref = Database.database().reference()
       }
    
    //saves a calendar schedule in the system.
    func Save(_ calSched: CalendarSchedule, completion: @escaping(String)-> Void) {
           do{
               let dataValue = try JSONEncoder().encode(calSched)
               if let dataString = String(data: dataValue, encoding: .utf8){
                  ref.child(CALENDAR_SCHEDULE_LIST).child(calSched.Id).setValue(dataString)
                  completion(SUCCESS)
               }
           }catch{
              completion("\(FAILURE) \(error.localizedDescription)")
           }
    }
    
    //loads the calendar schedule associated with a calendar schedule
    func GetById(_ id: String, completion: @escaping(CalendarSchedule) -> Void){
         ref.child(CALENDAR_SCHEDULE_LIST).child(id).observeSingleEvent(of: .value, with: { (snapshot) in
             if let jsonString = snapshot.value as? String{
                 if let jsonData = jsonString.data(using: .utf8){
                     let decoder = JSONDecoder()
                     do{
                         let dataObj = try decoder.decode(CalendarSchedule.self, from: jsonData)
                         completion(dataObj)
                     }catch{
                         print(error.localizedDescription)
                     }
                 }
             }
         })
     }
    
    //loads the schedules associated with a timetable.
    func GetListByTimetableId(_ timeTableId: String, completion: @escaping ([CalendarSchedule]) -> Void){
        GetList { (calendarScheduleList) in
            let filterredList = calendarScheduleList.filter { (item) -> Bool in
                item.TimetableId == timeTableId
            }
            completion(filterredList)
        }
    }
    
    //loads all the available calendar schedules.
    func GetList(completion: @escaping ([CalendarSchedule]) -> Void){
             
             ref.child(CALENDAR_SCHEDULE_LIST).observe(.value, with:{ snapshot in
                  
                  var dataList: [CalendarSchedule] = []
                  if let dictData =  snapshot.value as? [String: Any]{
                      let decoder = JSONDecoder();
                      for(_, value) in dictData{
                          
                          if let jsonString = value as? String{
                              if let jsonData = jsonString.data(using: .utf8){
                                  
                                  do{
                                      let dataObj = try decoder.decode(CalendarSchedule.self, from: jsonData)
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
    
    
    
}
