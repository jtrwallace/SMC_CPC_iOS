//
//  ProfessorsTableViewController.swift
//  SMC App
//
//  Created by Harrison Balogh on 5/13/15.
//  Copyright (c) 2015 CPC iOS. All rights reserved.
//

import UIKit
import CoreData

class ProfessorsTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var selectionOrderButton_Alphabetical: UIButton!
    @IBOutlet weak var selectionOrderButton_TopRating: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // Retreive the managedObjectContext from AppDelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var professors: [Professor] = []
    //list of unique names
    var professorSearchResults: [Professor]!
    
    var selectedCourse: Course? // this is nil if it didn't enter in from the course view.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selectedCourse == nil {
            //If this view was entered from the Professor button, then there was no course selected so fetchRequest every professor.
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Home", style: UIBarButtonItemStyle.Plain, target: self, action: "homeButton")
            
            let fetchRequestProfessors = NSFetchRequest(entityName: "Professor")
            if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequestProfessors, error: nil) as? [Professor] {
                professors = fetchResults
            }
        } else {
            //Else this view was entered after selected a course, therefore get every professor who teaches a course with selected title.
            self.navigationItem.title = selectedCourse!.title
        
            let fetchRequestCoursesWithTitle = NSFetchRequest(entityName: "Course")
            fetchRequestCoursesWithTitle.predicate = NSPredicate(format: "title == %@", selectedCourse!.title)
            if let coursesWithSelectedTitle: [Course] = managedObjectContext!.executeFetchRequest(fetchRequestCoursesWithTitle, error: nil) as? [Course]{
                for crs in coursesWithSelectedTitle {
                    professors.append(crs.professor)
                }
            }
        }
        
        //Sort all fetched professors by name
        professors = professors.sorted({$0.name < $1.name})
        
        //Removes duplicates by making tempProf list
        var tempProfs: [Professor] = []
        for prf in professors {
            if tempProfs.filter({$0.name == prf.name}).count == 0 {
                tempProfs.append(prf)
            }
        }
        
        professors = tempProfs
        professorSearchResults = professors
        searchBar.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Search Bar
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            professorSearchResults = []
            for prof in professors {
                if prof.name.lowercaseString.rangeOfString(searchText.lowercaseString) != nil {
                    professorSearchResults.append(prof)
                }
            }
        } else {
            professorSearchResults = professors
        }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar){
        professorSearchResults = professors
    }
    
    // MARK: - Navigation to Root Menu
    
    func homeButton(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK: - Table View of Professors
    
    @IBAction func OrderSelectionChange(sender: UIButton) {
        // Changes table view order for alphabetical and rating based sorting.
        if sender.restorationIdentifier == "Alphabetical" {
            selectionOrderButton_TopRating.enabled = true
            
            professors = professors.sorted({$0.name < $1.name})
            professorSearchResults = professorSearchResults.sorted({$0.name < $1.name})
            
            tableView.reloadData()
            println("Alphabetical Sorting")
        } else if sender.restorationIdentifier == "TopRating" {
            selectionOrderButton_Alphabetical.enabled = true
            
            //selectedCourse property is not specific to a professor so fetches specific courses owned by each professor in list
            var tempCrs: [Course] = []
            for prf in professors {
                println("Finding this course for professor '" + prf.name + "'.")
                let fetchRequestCourse = NSFetchRequest(entityName: "Course")
                let predicateTitle = NSPredicate(format: "title == %@", selectedCourse!.title)
                let predicateProf = NSPredicate(format: "professor == %@", prf)
                let compound_predicate = NSCompoundPredicate(type: NSCompoundPredicateType.AndPredicateType, subpredicates: [predicateTitle, predicateProf])
                fetchRequestCourse.predicate = compound_predicate
                if let courseWithTitleAndProf: [Course] = managedObjectContext!.executeFetchRequest(fetchRequestCourse, error: nil) as? [Course]{
                    if courseWithTitleAndProf.count != 0{
                        tempCrs.append(courseWithTitleAndProf[0])
                    }
                }
            }
            // now has a list of courses and will sort by their avGPA's before converting to professors
            tempCrs = tempCrs.sorted({$0.grade_distribution.avgGPA > $1.grade_distribution.avgGPA})
            professors = []
            for crs in tempCrs {
                println("Pulling professor name from ordered list: " + crs.professor.name + ".")
                professors.append(crs.professor)
            }
            
            //reloads the list for searched list also
            if searchBar.text != "" {
                professorSearchResults = []
                for prof in professors {
                    if prof.name.lowercaseString.rangeOfString(searchBar.text.lowercaseString) != nil {
                        professorSearchResults.append(prof)
                    }
                }
            } else {
                professorSearchResults = professors
            }
            
            
            
            tableView.reloadData()
            println("Top Rating Sorting")
        }
        sender.enabled = false
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return professorSearchResults!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PrototypeCell", forIndexPath: indexPath) as! UITableViewCell
        let row = indexPath.row
        cell.textLabel?.text = professorSearchResults[row].name
        if selectedCourse != nil {
            var crs: Course!
            //gets the specific course taught by each professor in the list
            let fetchRequestCourse = NSFetchRequest(entityName: "Course")
            let predicateTitle = NSPredicate(format: "title == %@", selectedCourse!.title)
            let predicateProf = NSPredicate(format: "professor == %@", professorSearchResults[row])
            let compound_predicate = NSCompoundPredicate(type: NSCompoundPredicateType.AndPredicateType, subpredicates: [predicateTitle, predicateProf])
            fetchRequestCourse.predicate = compound_predicate
            if let courseWithTitleAndProf: [Course] = managedObjectContext!.executeFetchRequest(fetchRequestCourse, error: nil) as? [Course]{
                if courseWithTitleAndProf.count != 0{
                    crs = courseWithTitleAndProf[0]
                }
            }
            cell.detailTextLabel?.text = "\(Int(Double(crs!.grade_distribution.avgGPA)/4.0 * 100.0))"
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let row = indexPath.row
        println("Selected: " + professorSearchResults[row].name)
        performSegueWithIdentifier("ProfessorToProfile", sender: professorSearchResults[row])
    }

    // MARK - Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationView = segue.destinationViewController as! ProfessorProfileViewController
        if let prf: Professor = sender as? Professor {
            destinationView.selectedProfessor = prf
            if selectedCourse != nil {
                // Finds the unique course corresponding to a specific professor
                
                //get all the courses with the same title as was selected in courses view and go thru this array, appending all professors
                let fetchRequestCourse = NSFetchRequest(entityName: "Course")
                let predicateTitle = NSPredicate(format: "title == %@", selectedCourse!.title)
                let predicateProf = NSPredicate(format: "professor == %@", prf)
                let compound_predicate = NSCompoundPredicate(type: NSCompoundPredicateType.AndPredicateType, subpredicates: [predicateTitle, predicateProf])
                fetchRequestCourse.predicate = compound_predicate
                if let courseWithTitleAndProf: [Course] = managedObjectContext!.executeFetchRequest(fetchRequestCourse, error: nil) as? [Course]{
                    if courseWithTitleAndProf.count != 0{
                        println("Found this many: \(courseWithTitleAndProf.count)")
                        destinationView.selectedCourse = courseWithTitleAndProf[0]
                    }
                }
                
            }
        }
        searchBar.resignFirstResponder()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
