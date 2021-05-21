

import Foundation

//Each timetable instance is expected to have multiple calendar schedules.
//There is no guarantee that the schedule falls on exactly the same day and time of a week because of mid term holiday, building and time changes, //etc.
class CalendarSchedule: Codable{
    
    var Id: String;
    var TimetableId: String;
    var DateOfTheSchedule: Date;
    var DayOfTheWeek: String;
    var StartTime:String;// may be date with time?
    var EndTime: String;
    var Location: String;// could include room number, build number, level, address.
    var AlertInAdvance: Bool;
    var AlertBeforeStartTime: Double; // could be 1.5, could be 2, could be 45
    var AlertBeforeStartTimeUnitName: String;// could be minute, could be hour. If hours 1.5 means 90 minute. If minute 1.5 means 1 minute 30 secs.
    
    init(){
        self.Id = ""
        self.TimetableId = ""
        self.DateOfTheSchedule = Date()
        self.DayOfTheWeek = ""
        self.StartTime = ""
        self.EndTime = ""
        self.Location = ""
        self.AlertInAdvance = false
        self.AlertBeforeStartTime = 0
        self.AlertBeforeStartTimeUnitName = "S"
    }
    
}
