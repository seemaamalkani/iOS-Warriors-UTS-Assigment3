

import Foundation
import Firebase
import FirebaseDatabase
class EducationProviderService{
    
    let SUCCESS = "SUCCESS";
    let FAILURE = "FAILURE!";
    let EDUCATIONPROVIDER_LIST = "EducationProviderList"
    
    // The static variable is used to make sure its value is not lost in the application
    static var universityList: [EducationProvider] = []

    var ref: DatabaseReference
    
    init() {
        ref = Database.database().reference()
    }
    
    func Save(_ newSchool:EducationProvider) -> String {
        
        do{
            let schoolItem = try JSONEncoder().encode(newSchool);
            if let schoolString = String(data: schoolItem, encoding: .utf8){
                ref.child(EDUCATIONPROVIDER_LIST).child(newSchool.Code).setValue(schoolString)
            }
        }catch{
            return "\(FAILURE) \(error.localizedDescription)";
        }
        return SUCCESS;
    }
    
    
    func GetByCode(_ code: String, completion: @escaping (EducationProvider) -> Void) {
        
                ref.child(EDUCATIONPROVIDER_LIST).child(code).observeSingleEvent(of: .value, with: {
              (snapshot) -> Void in
             
              if let jsonString = snapshot.value as? String{
                 
                  if  let jsonData = jsonString.data(using: .utf8){
                  
                  let decoder = JSONDecoder()
                  do{
                       let providerObj = try decoder.decode(EducationProvider.self, from: jsonData)
                    completion(providerObj)
                     
                  }catch{
                     print(error.localizedDescription)
                  }
                }
              }
          }
         )
     }
    
    
    func GetList(completion: @escaping ([EducationProvider]) -> Void) {
        
        ref.child(EDUCATIONPROVIDER_LIST).observe(.value, with:{ snapshot in
        
            var providerList: [EducationProvider] = []
            if let dictData =  snapshot.value as? [String: Any]{
                let decoder = JSONDecoder();
                for(_, value) in dictData{
                    
                    if let jsonString = value as? String{
                        if let jsonData = jsonString.data(using: .utf8){
                            
                            do{
                                let providerObj = try decoder.decode(EducationProvider.self, from: jsonData)
                                providerList.append(providerObj)
                            }catch{
                                print(error.localizedDescription)
                            }
                        }
                    }
                    
                }
                completion(providerList)
            }
        })
       }
    
   
    
}
