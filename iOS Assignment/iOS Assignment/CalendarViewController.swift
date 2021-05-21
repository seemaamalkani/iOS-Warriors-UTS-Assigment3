

import FSCalendar
import UIKit
import EventKit


class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {

    @IBOutlet weak var dateDetail: UILabel!
    @IBOutlet weak var timeDetail: UILabel!
    @IBOutlet weak var activityDetail: UILabel!
    @IBOutlet weak var subjectDetail: UILabel!
    @IBOutlet weak var notesDetail: UILabel!
    
    private weak var calendar: FSCalendar!
    var dateString:String = ""

    
    @IBAction func btnDashboard(_ sender: Any) {
        //Navigates to the dashboard page.
          let destinationView = self.storyboard?.instantiateViewController(withIdentifier: "LandingPageViewController") as! LandingPageViewController
        present(destinationView, animated:true, completion: nil);
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let calendar = FSCalendar(frame: CGRect(x: 40, y: 150, width: 320, height: 320))
        calendar.dataSource = self
        calendar.delegate = self
        calendar.firstWeekday = 2;
        calendar.appearance.headerTitleColor = .orange
        calendar.appearance.weekdayTextColor = .orange
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        view.addSubview(calendar)
        self.calendar = calendar
        
        //Sample set
       if dateString == "12-06-2020" {
           dateDetail.text = "12/06/2020"
           timeDetail.text = "6:30 PM"
           activityDetail.text = "Project"
           subjectDetail.text = "42889 iOS Development"
           notesDetail.text = "Assignment Due"
       } else {
           dateDetail.text = "please select"
           timeDetail.text = "please select"
           activityDetail.text = "please select"
           subjectDetail.text = "please select"
           notesDetail.text = "please select"
       }
    }
    
    
    //Calendar functionality
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-YYYY"
        let string = formatter.string(from: date)
        print ("\(string)")
        dateString =  "\(string)"
        
        //Sample set
        if dateString == "12-06-2020" {
            dateDetail.text = "12/06/2020"
            timeDetail.text = "6:30 PM"
            activityDetail.text = "Project"
            subjectDetail.text = "42889 iOS Development"
            notesDetail.text = "Assignment Due"
        } else {
            dateDetail.text = "No timetable on the date"
            timeDetail.text = "No timetable at the time"
            activityDetail.text = "No activity"
            subjectDetail.text = "No subject"
            notesDetail.text = "No details"
        }
    }
}
