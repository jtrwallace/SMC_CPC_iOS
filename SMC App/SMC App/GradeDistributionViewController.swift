//
//  GradeDistributionViewController.swift
//  CPC iOS Wallace
//
//  Created by Harrison Balogh on 4/6/15.
//  Copyright (c) 2015 SMC Computer Programming Club. All rights reserved.
//

import UIKit

class GradeDistributionViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var yearPicker: UIPickerView!
    
    @IBOutlet weak var summerSwitch: UISwitch!
    @IBOutlet weak var fallSwitch: UISwitch!
    @IBOutlet weak var winterSwitch: UISwitch!
    @IBOutlet weak var springSwitch: UISwitch!
    
    let availableYears = ["2014", "2013", "2012", "2011", "2010", "2009", "2008"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchField.delegate = self
        yearPicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField!) {    //delegate method
    }
    
    @IBAction func searchStarted(sender: UITextField) {
        if sender.text.isEmpty {
            searchButton.enabled = false
        } else if summerSwitch.on == true || fallSwitch.on == true || winterSwitch.on == true || springSwitch.on == true {
            searchButton.enabled = true
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return availableYears.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return availableYears[row]
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier! == "SearchWithName"{
            
        }
    }

}
