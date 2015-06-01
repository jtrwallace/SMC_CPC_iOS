//
//  DataManager.swift
//  SMC App
//
//  Created by Harrison Balogh on 5/26/15.
//  Copyright (c) 2015 CPC iOS. All rights reserved.
//

import Foundation

let coursesDataURL = "http://www.profsquire.com/api/v1/courses_data"
let professorsDataURL = "http://www.profsquire.com/api/v1/professors_data"

class DataManager {
    
    class func getCoursesFromProfsquireWithSuccess(success: ((coursesData: NSData!) -> Void)) {
        loadDataFromURL(NSURL(string: coursesDataURL)!, completion:{(data, error) -> Void in
            if let urlData = data {
                success(coursesData: urlData)
            }
        })
    }
    
    class func getProfessorsFromProfsquireWithSuccess(success: ((professorsData: NSData!) -> Void)) {
        loadDataFromURL(NSURL(string: professorsDataURL)!, completion:{(data, error) -> Void in
            if let urlData = data {
                success(professorsData: urlData)
            }
        })
    }
    
    class func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
        var session = NSURLSession.sharedSession()
        
        // Use NSURLSession to get data from an NSURL
        let loadDataTask = session.dataTaskWithURL(url, completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            if let responseError = error {
                completion(data: nil, error: responseError)
            } else if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    var statusError = NSError(domain:"com.profsquire", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    completion(data: nil, error: statusError)
                } else {
                    completion(data: data, error: nil)
                }
            }
        })
        loadDataTask.resume()
    }
    
    
    
    //        //LOADING PROFESSOR NAMES: (local text file)
    //        var path = NSBundle.mainBundle().pathForResource("GDFall2012ProfessorList", ofType: "txt")
    //        var text = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)!
    //        var name = ""
    //        for character in text {
    //            if character == "\n"{
    //                Professor.professorInManagedObjectContext(managedObjectContext!, name: name)
    //                name = ""
    //                continue
    //            }
    //            name = name + String(character)
    //        }
    
    //        //LOADING DEPARTMENT NAMES: (local text file)
    //        path = NSBundle.mainBundle().pathForResource("DepartmentNames", ofType: "txt")
    //        text = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)!
    //        var department = ""
    //        for character in text {
    //            if character == "\n"{
    //                Department.departmentInManagedObjectContext(managedObjectContext!, title: department, crs: [])
    //                department = ""
    //                continue
    //            }
    //            department = department + String(character)
    //            println("Appending \(character) to this")
    //        }
    
    //        let newDeptItem = NSEntityDescription.insertNewObjectForEntityForName("Department", inManagedObjectContext: managedObjectContext!) as! Department
    //        newDeptItem.title = "mathhhh"
    //        let newProfItem = NSEntityDescription.insertNewObjectForEntityForName("Professor", inManagedObjectContext: managedObjectContext!) as! Professor
    //        newProfItem.name = "DEHKHODA A"
    //        //LOADING COURSE NAMES: (local text file)
    //        path = NSBundle.mainBundle().pathForResource("ClassNames", ofType: "txt")
    //        text = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)!
    //        var course = ""
    //        for character in text {
    //            if character == "\n"{
    //                Course.courseInManagedObjectContext(managedObjectContext!, title: course, department: newDeptItem, professor: newProfItem)
    //                course = ""
    //                continue
    //            }
    //            course = course + String(character)
    //        }
}