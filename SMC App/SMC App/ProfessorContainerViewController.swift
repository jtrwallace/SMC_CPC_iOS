//
//  ProfessorContainerViewController.swift
//  SMC App
//
//  Created by Harrison Balogh on 6/19/15.
//  Copyright (c) 2015 CPC iOS. All rights reserved.
//

import UIKit

class ProfessorContainerViewController: UIViewController, GradeDistributionBarDelegate{

    @IBOutlet weak var gradeBar_base: UIImageView!
    @IBOutlet var gradeBarView: GradeDistributionBarView!
    @IBOutlet weak var ratingNumberLabel: UILabel!
    @IBOutlet weak var ratingCircle: UIImageView!
    
    var selectedCourse: Course?

    override func viewDidLoad() {
        super.viewDidLoad()
        gradeBarView.delegate = self
        
        if selectedCourse != nil {
            ratingNumberLabel.text = "\(Int(Double(selectedCourse!.grade_distribution.avgGPA)/4.0 * 100.0))"
            println("Grades for selected course:\n    A: \(selectedCourse!.grade_distribution.a)\n    B: \(selectedCourse!.grade_distribution.b)\n    C: \(selectedCourse!.grade_distribution.c)\n    D: \(selectedCourse!.grade_distribution.d)\n    F: \(selectedCourse!.grade_distribution.f)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Grade Distribution Bar Delegate Functions
    func getA_w() -> Int {
        let base_w = Int(gradeBar_base.frame.width)
        return 1 + Int(Double(selectedCourse!.grade_distribution.a)/Double(selectedCourse!.grade_distribution.total) * Double(base_w))
    }
    func getB_x() -> Int {
        return getA_w()
    }
    func getB_w() -> Int {
        let base_w = Int(gradeBar_base.frame.width)
        return 1 + Int(Double(selectedCourse!.grade_distribution.b)/Double(selectedCourse!.grade_distribution.total) * Double(base_w))
    }
    func getC_x() -> Int {
        return getB_w() + getB_x()
    }
    func getC_w() -> Int {
        let base_w = Int(gradeBar_base.frame.width)
        return 1 + Int(Double(selectedCourse!.grade_distribution.c)/Double(selectedCourse!.grade_distribution.total) * Double(base_w))
    }
    func getD_x() -> Int {
        return getC_w() + getC_x()
    }
    func getD_w() -> Int {
        let base_w = Int(gradeBar_base.frame.width)
        return 1 + Int(Double(selectedCourse!.grade_distribution.d)/Double(selectedCourse!.grade_distribution.total) * Double(base_w))
    }
    func getF_x() -> Int {
        return getD_w() + getD_x()
    }
    func getF_w() -> Int {
        let base_w = Int(gradeBar_base.frame.width)
        return 1 + Int(Double(selectedCourse!.grade_distribution.f)/Double(selectedCourse!.grade_distribution.total) * Double(base_w))
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
