//
//  ProfessorProfile_VC.swift
//  SMC App
//
//  Created by Harrison Balogh on 4/10/15.
//  Copyright (c) 2015 CPC iOS. All rights reserved.
//

import UIKit

class ProfessorProfile_VC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedProfessor:String!
    var focusedClass:String!
    
    let tableTestData = ["Chem 11", "Chem 12", "Chem 31", "Bloop 101", "Stoop 010", "Croop 123", "Kroop 321"]
    let textCellIdentifier = "OtherClasses"

    @IBOutlet weak var progressView_A: UIProgressView!
    @IBOutlet weak var progressView_B: UIProgressView!
    @IBOutlet weak var progressView_C: UIProgressView!
    @IBOutlet weak var progressView_D: UIProgressView!
    @IBOutlet weak var progressView_F: UIProgressView!
    
    @IBOutlet weak var otherClassesTable: UITableView!
    @IBOutlet weak var focusedClassLabel: UILabel!
    
    @IBOutlet weak var numberOf_A_Label: UILabel!
    @IBOutlet weak var numberOf_B_Label: UILabel!
    @IBOutlet weak var numberOf_C_Label: UILabel!
    @IBOutlet weak var numberOf_D_Label: UILabel!
    @IBOutlet weak var numberOf_F_Label: UILabel!
    
    //Temp...
    var numberOf_F:Int!
    var numberOf_D:Int!
    var numberOf_C:Int!
    var numberOf_B:Int!
    var numberOf_A:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        otherClassesTable.delegate = self
        otherClassesTable.dataSource = self
        //professorNameLabel.text = focusedClass
        focusedClassLabel.text = focusedClass
        
        //TEMP RANDOM GRADE DISTRIBUTION DATA GENERATION:=\
        var upperRange:Int = 101
        numberOf_F = Int(arc4random_uniform(UInt32(upperRange)))
        upperRange = upperRange - numberOf_F
        numberOf_D = Int(arc4random_uniform(UInt32(upperRange)))
        upperRange = upperRange - numberOf_D
        numberOf_C = Int(arc4random_uniform(UInt32(upperRange)))
        upperRange = upperRange - numberOf_C
        numberOf_B = Int(arc4random_uniform(UInt32(upperRange)))
        upperRange = upperRange - numberOf_B
        numberOf_A = Int(arc4random_uniform(UInt32(upperRange)))
        progressView_A.progress = Float(numberOf_A)/100
        progressView_B.progress = Float(numberOf_B)/100
        progressView_C.progress = Float(numberOf_C)/100
        progressView_D.progress = Float(numberOf_D)/100
        progressView_F.progress = Float(numberOf_F)/100
        //================================================/
        
        numberOf_A_Label.text = String(numberOf_A)
        numberOf_B_Label.text = String(numberOf_B)
        numberOf_C_Label.text = String(numberOf_C)
        numberOf_D_Label.text = String(numberOf_D)
        numberOf_F_Label.text = String(numberOf_F)
    }
    override func viewDidAppear(animated: Bool) {
        //self.professorNameLabel.slideFromLeft(duration: 0.5, completionDelegate: nil)
        //professorNameLabel.text = firstLastNameConversion(selectedProfessor)//selectedProfessor
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func firstLastNameConversion(lastFirstNameString: String) -> String {
        let first = lastFirstNameString.substringToIndex(lastFirstNameString.rangeOfString(",")!.startIndex)
        let last = lastFirstNameString.substringFromIndex(lastFirstNameString.rangeOfString(",")!.startIndex)
        let firstLastName = first + last
        return firstLastName
        
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
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let row = indexPath.row
        println(tableTestData[row])
        self.focusedClassLabel.slideFromRight(duration: 0.3, completionDelegate: nil)
        focusedClassLabel.text = tableTestData[row]
        
        //TEMP RANDOM GRADE DISTRIBUTION DATA GENERATION:=\
        var upperRange:Int = 101
        numberOf_F = Int(arc4random_uniform(UInt32(upperRange)))
        upperRange = upperRange - numberOf_F
        numberOf_D = Int(arc4random_uniform(UInt32(upperRange)))
        upperRange = upperRange - numberOf_D
        numberOf_C = Int(arc4random_uniform(UInt32(upperRange)))
        upperRange = upperRange - numberOf_C
        numberOf_B = Int(arc4random_uniform(UInt32(upperRange)))
        upperRange = upperRange - numberOf_B
        numberOf_A = Int(arc4random_uniform(UInt32(upperRange)))
        progressView_A.progress = Float(numberOf_A)/100
        progressView_B.progress = Float(numberOf_B)/100
        progressView_C.progress = Float(numberOf_C)/100
        progressView_D.progress = Float(numberOf_D)/100
        progressView_F.progress = Float(numberOf_F)/100
        //================================================/
        
        numberOf_A_Label.text = String(numberOf_A)
        numberOf_B_Label.text = String(numberOf_B)
        numberOf_C_Label.text = String(numberOf_C)
        numberOf_D_Label.text = String(numberOf_D)
        numberOf_F_Label.text = String(numberOf_F)
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier! == "ReturnToResults" {
            var destinationController = segue.destinationViewController as! Results_VC
            destinationController.searchName = focusedClass
        }
    }
    
    

}
