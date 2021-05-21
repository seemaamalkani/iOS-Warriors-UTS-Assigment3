

import UIKit

class LandingPageViewController: UIViewController {

    var regoService = ResgistrationService();
    var timetableService = TimetableService();
    var calendarScheduleService = CalendarScheduleService();
    var subjectServices = SubjectService();
    var providerCode = "1234" //Default to UTS
    
    //Provider code numbers defaults
    @IBAction func schoolSite(_ sender: Any) {
        if providerCode == "00001" {
            if let url = URL(string: "https://mq.edu.au") {
                UIApplication.shared.open(url)
            }
        } else if providerCode == "00002" {
            if let url = URL(string: "https://www.unsw.edu.au/") {
                UIApplication.shared.open(url)
            }
        } else if providerCode == "00003" {
            if let url = URL(string: "https://www.sydney.edu.au/") {
                UIApplication.shared.open(url)
            }
        } else if providerCode == "1234" {
            if let url = URL(string: "https://www.uts.edu.au/") {
            UIApplication.shared.open(url)
            }
        }
    }
    
    @IBAction func btnLogOut(_ sender: Any) {
        
        //Navigates to the sign in page.
         let destinationView = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
         present(destinationView, animated:true, completion: nil);
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadDataForTheCurrentUser();
    }
    
    
    
    //Loads the student details, timetable and calendarSchedules associated with the currently logged in user.
    func loadDataForTheCurrentUser() {
        //Load the student by email address and save it to the static variable so that it can be accessed everywhere once the user logs in.
        regoService.GetStudentByEmail(regoService.CurrentUser) { (item) in
            ResgistrationService.currentStudent = item
            //Load the student timetable
            self.timetableService.GetListByStudentCode(item.StudentId) { (timetableList) in
                TimetableService.currentStudentTimetableList = timetableList;
                //Clears the static content before adding the fresh data
                CalendarScheduleService.currentStudentScheduleList = [];
                for timeTable in timetableList{
                    //Load the calendarSchedules for each timetable
                    self.calendarScheduleService.GetListByTimetableId(timeTable.Id) { (scheduleList) in
                        CalendarScheduleService.currentStudentScheduleList.append(contentsOf: scheduleList)
                    }
                } //Closing bracket for calendar schedule list of the current timetables of the current user.
            }//Closing bracket for timetablelist load
        }//Closing bracket for student details call.
            //Load all the available subjects.
            subjectServices.GetList { (subjectList) in
            //Clears the variable before assigning the latest subjects.
            SubjectService.currentSubjectList = []
            SubjectService.currentSubjectList.append(contentsOf: subjectList)
        }
    }
}
