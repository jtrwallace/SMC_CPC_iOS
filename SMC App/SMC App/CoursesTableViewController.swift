//
//  CoursesTableViewController.swift
//  SMC App
//
//  Created by Harrison Balogh on 5/13/15.
//  Copyright (c) 2015 CPC iOS. All rights reserved.
//

import UIKit

class CoursesTableViewController: UITableViewController {

    let tableTestData = ["Math 7", "Math 8", "Math 11", "Math 12", "Math 21", "Math 22", "Math 101", "Math 123", "Math 321", "Math 666"]
    var departmentSelected:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = departmentSelected
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
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableTestData.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44        // remove this func to check default height... unnecessary function
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
        performSegueWithIdentifier("NextView", sender: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
