//
//  ProfessorsTableViewController.swift
//  SMC App
//
//  Created by Harrison Balogh on 5/13/15.
//  Copyright (c) 2015 CPC iOS. All rights reserved.
//

import UIKit

class ProfessorsTableViewController: UITableViewController {
    
    //This table has one extra cell at the top containing buttons to switch between 'Alphabetical' and 'Top Rating' called OrderSelectionCell
    @IBOutlet weak var selectionOrderButton_Alphabetical: UIButton!
    @IBOutlet weak var selectionOrderButton_TopRating: UIButton!
    
    let tableTestData = ["Lannister, Tyrion", "Stark, Sansa", "Tyrell, Margaery", "Bolton, Ramsay", "Baratheon, Stannis", "Targaryen, Daenerys", "Martell, Oberyn"]
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
    
    @IBAction func OrderSelectionChange(sender: UIButton) {
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
        let row = indexPath.row
        println("Selected: " + tableTestData[row])
        performSegueWithIdentifier("NextView", sender: tableTestData[row])
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationView = segue.destinationViewController as! ProfessorProfileViewController
        destinationView.professorName = sender as! String
    }

}
