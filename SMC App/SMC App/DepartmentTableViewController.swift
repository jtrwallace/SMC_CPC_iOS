//
//  DepartmentTableViewController.swift
//  SMC App
//
//  Created by Harrison Balogh on 5/13/15.
//  Copyright (c) 2015 CPC iOS. All rights reserved.
//

import UIKit

class DepartmentTableViewController: UITableViewController{

    let tableTestData = ["Mathematics", "Chemistry", "Biology", "Sociology", "Psychology", "Art", "Philosophy", "Business", "Accounting", "Economics", "Computer Science", "Advertising", "Marketing", "Communications", "Anatomy"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Home", style: UIBarButtonItemStyle.Plain, target: self, action: "homeButton")
        // preserve selection between presentations: self.clearsSelectionOnViewWillAppear = false
        // display an Edit button in the navigation bar for this view controller: self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.hidesBarsWhenKeyboardAppears = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func homeButton(){
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableTestData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PrototypeCell", forIndexPath: indexPath) as! UITableViewCell
        let row = indexPath.row
        cell.textLabel?.text = tableTestData[row]
        cell.textLabel?.textColor = UIColor.whiteColor()
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let row = indexPath.row
        println("Selected: " + tableTestData[row])
        performSegueWithIdentifier("NextView", sender: tableTestData[row])
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationView = segue.destinationViewController as! CoursesTableViewController
        destinationView.departmentSelected = sender as! String
    }
}
