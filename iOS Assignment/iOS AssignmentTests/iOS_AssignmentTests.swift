//
//  iOS_AssignmentTests.swift
//  iOS AssignmentTests
//
//  Created by Bhavana on 6/6/20.
//  Copyright © 2020 Bhavana. All rights reserved.
//

import XCTest

@testable import iOS_Assignment

class iOS_AssignmentTests: XCTestCase {
    
    var registrationService = ResgistrationService()
    
    func testLoadStudent(){
        
    registrationService.GetStudentById("1234")
    {
        (item) in
            
        XCTAssertEqual("1234", item.StudentId, "The expected result is 1234");
    
        }
       
    }
    
    func testSaveStudent(){
        
        let student1 = Student();
                      student1.FirstName = "eric"
                      student1.MiddleName = "b"
                      student1.LastName = "gernan"
                      student1.StudentId = "1236"
                      student1.EmailAddress = "modified@gmail.com"
                      student1.Password = "1236"
       let  responseCode =  registrationService.SaveStudent(student1);
        XCTAssertEqual(responseCode, registrationService.SUCCESS, "The expected response was \(registrationService.SUCCESS) but the actual response is \(responseCode)")
        
    }
    
    func testLoadStudentDictionary() {
     registrationService.GetStudentDictionary {
             (itemList) in
        
        XCTAssertEqual(itemList.count > 0, true, "The student list is expected to contain some record");
         }
       
    }
    
    func testSaveEducationProvider() {
        
        let eduProvider = EducationProvider();
        
        eduProvider.Code = "1234"
        eduProvider.Name = "UTS"
        eduProvider.Location = "Central Broadway, Sydney, NSW"
        
        let eduService = EducationProviderService();
        let responseCode = eduService.Save(eduProvider);
        
         XCTAssertEqual(responseCode, eduService.SUCCESS, "The expected response was \(eduService.SUCCESS) but the actual response is \(responseCode)")
        
    }
    
    func testEducationProviderGetByCode(){
        let eduProvider = EducationProviderService();
        eduProvider.GetByCode("1234"){
            (item) in
            XCTAssertEqual(item.Code, "1234", "The expected code is 1234 but the returned code was \(item.Code)")
            
        }
    }
    
    func testEducationProviderGetList() {
        let eduProvider = EducationProviderService();
        eduProvider.GetList {
              (itemList) in
            print("Total number : \(itemList.count)");
         XCTAssertEqual(itemList.count > 0, true, "The education provider list is expected to contain some record");
          }
        
     }
    
    func testSubjectGetByCode() {
        let subjectService = SubjectService();
        subjectService.GetByCode("1234"){
            (item) in
            
            XCTAssertEqual(item.Code, "1234", "The expected code is 1234 but the returned code was \(item.Code)")
            
        }
    }
    /*
     func testSubjectGetByEmail() {
         let subjectService = SubjectService();
         subjectService.GetByCode("1234"){
             (item) in
             
             XCTAssertEqual(item.Code, "1234", "The expected code is 1234 but the returned code was \(item.Code)")
             
         }
     }
     */
    func testSubjectGetList(){
         let subjectService = SubjectService();
        subjectService.GetList() {
            (itemList) in
            XCTAssertEqual(itemList.count > 0, true, "The education provider list is expected to contain some record");
        }
    }
    
    func testTimetableSave(){
        let timetableService = TimetableService();
        
        let tmTbl = Timetable();
               tmTbl.Id = "1234";
        tmTbl.Name = "Test time table";
               tmTbl.SemesterId = "1234";
               tmTbl.StudentId = "1234";
               tmTbl.SubjectCode = "1234";
               tmTbl.ProviderId = "1234";
               timetableService.Save(tmTbl) { (item) in
                XCTAssertEqual(item, timetableService.SUCCESS, "The expected value is \(timetableService.SUCCESS), but, the value \(item) was retrieved.");
               }
        
    }
    
    func testTimetableGetById() {
        let timetableService = TimetableService();
        timetableService.GetById("1234"){
            (item) in
            
             XCTAssertEqual(item.Id, "1234", "The expected id is 1234 but the returned id was \(item.Id)")
        }
    }
    
    func testTimetableGetList(){
        let timetableService = TimetableService()
        timetableService.GetList(){
            (itemList) in
            
            XCTAssertEqual(itemList.count > 0, true, "The list is expected to contain some record");
            
        }
    }
    
    func testSemesterSave(){
         let semesterServ = SemesterService()
               
               let smstr = Semester();
               smstr.Id = "1234"
               smstr.EndDate = Date()
               smstr.Name = "Spring 2020"
               smstr.StartDate = Date()
        semesterServ.Save(smstr){
            (response) in
            
            XCTAssertEqual(response, semesterServ.SUCCESS, "The expected value is \(semesterServ.SUCCESS), but, the value \(response) was retrieved.");
            
        }
    }
    
    func testSemesterGetById(){
        let semesterServ = SemesterService();
        semesterServ.GetById("1234"){
            (item) in
            XCTAssertEqual(item.Id, "1234", "The expected value was 1234, the acutal value is \(item.Id)");
        }
    }
    
    func testSemesterGetList(){
         let semesterServ = SemesterService();
         semesterServ.GetList(){
             (itemList) in
             
             XCTAssertEqual(itemList.count > 0, true, "The list is expected to contain some record");
             
         }
     }
    
    func testCalendarScheduleSave(){
        let calSchedSrvc = CalendarScheduleService();
        
        let calSchedObj = CalendarSchedule()
        calSchedObj.Id = "1234";
        calSchedObj.TimetableId = "1234";
        calSchedObj.DateOfTheSchedule = Date()
        calSchedObj.DayOfTheWeek = "Monday";
        calSchedObj.StartTime = "10:00"
        calSchedObj.EndTime = "13:00"
        calSchedObj.Location = "Building 11, Room No 401";
        calSchedObj.AlertInAdvance = false
        calSchedObj.AlertBeforeStartTime = 30
        calSchedObj.AlertBeforeStartTimeUnitName = "M"
        
        calSchedSrvc.Save(calSchedObj){
            (response) in
            XCTAssertEqual(response, calSchedSrvc.SUCCESS, "The expected value is \(calSchedSrvc.SUCCESS), but, the value \(response) was retrieved.");
            
        }
    }
    
    func testCalendarScheduleGetById(){
         let calSchedSrvc = CalendarScheduleService();
        calSchedSrvc.GetById("1234"){
            (item) in
            
        XCTAssertEqual(item.Id, "1234", "The expected value was 1234, the acutal value is \(item.Id)");
            
        }
    }
    
    func testCalendarScheduleGetList(){
        
        let calSchedSrvc = CalendarScheduleService();
        calSchedSrvc.GetList(){
            (itemList) in
            
            XCTAssertEqual(itemList.count > 0, true, "The list is expected to contain some record");
            
        }
        
    }
    
    

}
