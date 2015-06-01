//
//  CoursesTableViewController.swift
//  SMC App
//
//  Created by Harrison Balogh on 5/13/15.
//  Copyright (c) 2015 CPC iOS. All rights reserved.
//

import UIKit
import CoreData

class CoursesTableViewController: UITableViewController, UISearchBarDelegate {

    var departmentSelected: Department!
    var courses: [Course]!
    var courseSearchResults: [Course]!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = departmentSelected.title
        searchBar.delegate = self
        // Retreive the managedObjectContext from AppDelegate
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let fetchRequestCourses = NSFetchRequest(entityName: "Course")
        fetchRequestCourses.predicate = NSPredicate(format: "department == %@", departmentSelected)
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequestCourses, error: nil) as? [Course] {
            courses = fetchResults
            courses = courses.sorted({$0.title < $1.title})
            var tempCourses: [Course] = []
            for course in courses {
                if tempCourses.filter({$0.title == course.title}).count == 0 {
                    tempCourses.append(course)
                }
            }
            courses = tempCourses
            courseSearchResults = courses
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.hidesBarsWhenKeyboardAppears = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Search Bar
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            courseSearchResults = []
            for crs in courses {
                if crs.title.lowercaseString.rangeOfString(searchText.lowercaseString) != nil {
                    courseSearchResults.append(crs)
                }
            }
        } else {
            courseSearchResults = courses
        }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar){
        courseSearchResults = courses
    }
    
    // MARK: - Table View of Courses
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseSearchResults.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44        // remove this func to check default height... unnecessary function
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PrototypeCell", forIndexPath: indexPath) as! UITableViewCell
        let row = indexPath.row
        cell.textLabel?.text = courseSearchResults[row].title
        cell.textLabel?.textColor = UIColor.whiteColor()
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let row = indexPath.row
        println("Selected: \(courseSearchResults[row])")
        performSegueWithIdentifier("CourseToProfessor", sender: courseSearchResults[row])
    }

    // MARK: - Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier! == "CourseToProfessor"{
            var destinationView = segue.destinationViewController as! ProfessorsTableViewController
            if let crs: Course = sender as? Course {
                destinationView.selectedCourse = crs
            }
            searchBar.resignFirstResponder()
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }

}
