

import Foundation
import Firebase
import FirebaseDatabase
class SubjectService {
    
    let SUCCESS = "SUCCESS";
    let FAILURE = "FAILURE!";
    let SUBJECT_LIST = "SubjectList"
    
    static var currentSubjectList :[Subject] = [];
    
    var ref: DatabaseReference
     
     init() {
         ref = Database.database().reference()
     }
    
    func Save(_ subject: Subject) -> String {
        do{
            let subItem = try JSONEncoder().encode(subject)
            if let subString = String(data: subItem, encoding: .utf8){
                ref.child(SUBJECT_LIST).child(subject.Code).setValue(subString)
            }
        }catch{
            return "\(FAILURE) \(error.localizedDescription)"
        }
        return SUCCESS
    }
    
    func GetByCode(_ code: String, completion: @escaping(Subject) -> Void){
        ref.child(SUBJECT_LIST).child(code).observeSingleEvent(of: .value, with: { (snapshot) in
            if let jsonString = snapshot.value as? String{
                if let jsonData = jsonString.data(using: .utf8){
                    let decoder = JSONDecoder()
                    do{
                        let subjectObj = try decoder.decode(Subject.self, from: jsonData)
                        completion(subjectObj)
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }
        })
    }
    
    func GetList(completion: @escaping ([Subject]) -> Void){
        
        ref.child(SUBJECT_LIST).observe(.value, with:{ snapshot in
             //print(snapshot.value as! [String:Any])
             var subjectList: [Subject] = []
             if let dictData =  snapshot.value as? [String: Any]{
                 let decoder = JSONDecoder();
                 for(_, value) in dictData{
                     
                     if let jsonString = value as? String{
                         if let jsonData = jsonString.data(using: .utf8){
                             
                             do{
                                 let subjectObj = try decoder.decode(Subject.self, from: jsonData)
                                 subjectList.append(subjectObj)
                             }catch{
                                 print(error.localizedDescription)
                             }
                         }
                     }
                     
                 }
                 completion(subjectList)
             }
         })
        
    }
    
    
}
