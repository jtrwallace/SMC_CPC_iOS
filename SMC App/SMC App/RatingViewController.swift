//
//  RatingViewController.swift
//  SMC App
//
//  Created by Harrison Balogh on 5/25/15.
//  Copyright (c) 2015 CPC iOS. All rights reserved.
//

import UIKit
import CoreData

class RatingViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var professorNameLabel: UILabel!
    @IBOutlet weak var courseDeptLabel: UILabel!
    @IBOutlet weak var courseTitleLabel: UILabel!
    @IBOutlet weak var yourNameField: UITextField!
    @IBOutlet weak var yourGradeField: UITextField!
    @IBOutlet weak var yourCommentField: UITextField!
    
    
    var courses: [Course]!
    var selectedProfessor: Professor!
    var selectedCourse: Course?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        professorNameLabel.text = selectedProfessor.name
        if selectedCourse != nil {
            courseDeptLabel.text = selectedCourse!.title
            courseTitleLabel.text = selectedCourse!.department.title
        } else {
            courseDeptLabel.hidden = true
            courseTitleLabel.hidden = true
            yourGradeField.hidden = true
        }

        yourNameField.delegate = self
        yourGradeField.delegate = self
        yourCommentField.delegate = self
        
        // Retreive the managedObjectContext from AppDelegate
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let fetchRequestCourses = NSFetchRequest(entityName: "Course")
        let predicate = NSPredicate(format: "professor.name == %@", selectedProfessor)
        fetchRequestCourses.predicate = predicate
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequestCourses, error: nil) as? [Course] {
            courses = fetchResults
            courses = courses.sorted({$0.title < $1.title})
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Text Field Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - View Buttons
    
    @IBAction func cancelRating(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
}
