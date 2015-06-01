//
//  DepartmentTableViewController.swift
//  SMC App
//
//  Created by Harrison Balogh on 5/13/15.
//  Copyright (c) 2015 CPC iOS. All rights reserved.
//

import UIKit
import CoreData

class DepartmentTableViewController: UITableViewController, UISearchBarDelegate{

    var departments: [Department]!
    var departmentSearchResults: [Department]!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Home", style: UIBarButtonItemStyle.Plain, target: self, action: "homeButton")
        searchBar.delegate = self
        // Retreive the managedObjectContext from AppDelegate
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let fetchRequestDepartments = NSFetchRequest(entityName: "Department")
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequestDepartments, error: nil) as? [Department] {
            departments = fetchResults
            departments = departments.sorted({$0.title < $1.title})
            departmentSearchResults = departments
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
    
    // MARK: - Navigation to Root Menu
    
    func homeButton(){
        dismissViewControllerAnimated(true, completion: nil)
    }

    // MARK: - Search Bar
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            departmentSearchResults = []
            for dept in departments {
                if dept.title.lowercaseString.rangeOfString(searchText.lowercaseString) != nil {
                    departmentSearchResults.append(dept)
                }
            }
        } else {
            departmentSearchResults = departments
        }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar){
        departmentSearchResults = departments
    }
    
    // MARK: - Table View of Departments
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return departmentSearchResults.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PrototypeCell", forIndexPath: indexPath) as! UITableViewCell
        let row = indexPath.row
        cell.textLabel?.text = departmentSearchResults[indexPath.row].valueForKey("title") as? String
        cell.textLabel?.textColor = UIColor.whiteColor()
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let row = indexPath.row
        println("Selected: " + String(stringInterpolationSegment: departmentSearchResults[indexPath.row].valueForKey("title")))
        performSegueWithIdentifier("NextView", sender: departmentSearchResults[indexPath.row])
    }
    
    // MARK: - Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationView = segue.destinationViewController as! CoursesTableViewController
        destinationView.departmentSelected = sender as! Department
        searchBar.resignFirstResponder()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
