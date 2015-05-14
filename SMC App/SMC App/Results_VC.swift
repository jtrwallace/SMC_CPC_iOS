//
//  ResultsView.swift
//  SMC App
//
//  Created by Harrison Balogh on 4/7/15.
//  Copyright (c) 2015 CPC iOS. All rights reserved.
//

import UIKit

class Results_VC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var resultsTable: UITableView!
    let tableTestData = ["Coral, Mark", "Stonich, Hank", "Tresle, Laura", "Kalitz, Guter", "West, Tray", "Luto, Derick", "Poster, Sara", "Feriece, Deborah", "Pascal, Joqeue", "Verta, Maria", "Rusterson, Bill", "Fenning, Michael", "Patter, Herry", "Soyo, Kim"]
    let textCellIdentifier = "ResultCell"
    var searchName:String!
    var selectedProfessor:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsTable.delegate = self
        resultsTable.dataSource = self
        //searchedNameLabel.text = "Grade Distribution"
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        //self.searchedNameLabel.slideFromLeft(duration: 0.5, completionDelegate: nil)
        //searchedNameLabel.text = searchName
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton(sender: UIButton) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    // TABLE VIEW FUNC'S
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableTestData.count
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        let row = indexPath.row
        
        cell.textLabel?.text = tableTestData[row]

        var imageName = ""
        
               if row <= tableTestData.count/3 { // need this to implement various colored dots to each professor name
            imageName = "ratingDot_high.png"
        } else if row <= tableTestData.count*2/3 {
            imageName = "ratingDot_medium.png"
        } else if row <= tableTestData.count{
            imageName = "ratingDot_low.png"
        }
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
            imageView.frame = CGRect(x: 0, y: 15, width: 14, height: 14)
        
        cell.contentView.addSubview(imageView)
        
        imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        //constraints programmatically set for dot
        var constX = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: cell.contentView, attribute: NSLayoutAttribute.TrailingMargin, multiplier: 1, constant: -10)
        cell.addConstraint(constX)
        var constY = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: cell.contentView, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        cell.addConstraint(constY)
        var constW = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 14)
        cell.contentView.addConstraint(constW)
        var constH = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 14)
        cell.addConstraint(constH)
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let row = indexPath.row
        println(tableTestData[row])
        selectedProfessor = tableTestData[row]
        performSegueWithIdentifier("NextView", sender: self)
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier! == "ProfessorProfile"{
            var destinationView = segue.destinationViewController as! ProfessorProfile_VC
            destinationView.selectedProfessor = selectedProfessor
            destinationView.focusedClass = searchName
        }
    }

}
