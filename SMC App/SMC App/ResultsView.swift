//
//  ResultsView.swift
//  SMC App
//
//  Created by Harrison Balogh on 4/7/15.
//  Copyright (c) 2015 CPC iOS. All rights reserved.
//

import UIKit

class ResultsView: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var resultsTable: UITableView!
    let tableTestData = ["Man, Super", "Cable Guy", "Beyonce", "Dog Whisperer", "Bojangles", "Chapstick", "Monopoly Man", "Turnt Up", "This is all tabel test data", "Need actual data", "Need to figure out SQL server", "Much list. Names many."]
    let textCellIdentifier = "ResultCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsTable.delegate = self
        resultsTable.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableTestData.count
    }
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as UITableViewCell
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
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
