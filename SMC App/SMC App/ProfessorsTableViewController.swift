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
    
    var professors: [Professor] = []
    var professorSearchResults: [Professor]!
    
    var selectedCourse: Course? // this is nil if it didn't enter in from the course view.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Retreive the managedObjectContext from AppDelegate
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let fetchRequestProfessors = NSFetchRequest(entityName: "Professor")
        
        if selectedCourse == nil {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Home", style: UIBarButtonItemStyle.Plain, target: self, action: "homeButton")
            if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequestProfessors, error: nil) as? [Professor] {
                professors = fetchResults
            }
        } else {
            self.navigationItem.title = selectedCourse!.title
            
            //get all the courses with the same title as was selected in courses view and go thru this array, appending all professors
            let fetchRequestCoursesWithTitle = NSFetchRequest(entityName: "Course")
            fetchRequestCoursesWithTitle.predicate = NSPredicate(format: "title == %@", selectedCourse!.title)
            if let coursesWithSelectedTitle: [Course] = managedObjectContext!.executeFetchRequest(fetchRequestCoursesWithTitle, error: nil) as? [Course]{
                for crs in coursesWithSelectedTitle {
                    professors.append(crs.professor)
                }
            }
        }
        professors = professors.sorted({$0.name < $1.name})
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
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.hidesBarsWhenKeyboardAppears = true
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
            println("Alphabetical Sorting")
        } else if sender.restorationIdentifier == "TopRating" {
            selectionOrderButton_Alphabetical.enabled = true
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
        cell.textLabel?.textColor = UIColor.whiteColor()
        
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
        }
        if selectedCourse != nil {
            destinationView.selectedCourse = selectedCourse
        }
        searchBar.resignFirstResponder()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
