//
//  ProfessorProfileViewController.swift
//  SMC App
//
//  Created by Harrison Balogh on 5/13/15.
//  Copyright (c) 2015 CPC iOS. All rights reserved.
//

import UIKit
import CoreData

class ProfessorProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{
    
    var selectedProfessor: Professor!
    var selectedCourse: Course?
    var courses: [Course]!
    var profContainer: ProfessorContainerViewController!
    
    @IBOutlet weak var professorCourses: UITableView!
    @IBOutlet weak var scrollFadeRight: UIImageView!
    @IBOutlet weak var scrollFadeLeft: UIImageView!
    @IBOutlet weak var attributesHorizontalScrollView: UIScrollView!
    @IBOutlet weak var baseScrollView: UIScrollView!
    @IBOutlet weak var profileContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Rate", style: UIBarButtonItemStyle.Plain, target: self, action: "segueToRatingScreen")
        
        
        baseScrollView.delegate = self
        //professorCourses.delegate = self
        //professorCourses.dataSource = self
        var professorLastName: String = ""
        for char in selectedProfessor.name {
            if char != " " {
                professorLastName.append(char)
            } else {
                break
            }
        }
        self.navigationItem.title = professorLastName
        
        // Retreive the managedObjectContext from AppDelegate
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let fetchRequestCourses = NSFetchRequest(entityName: "Course")
        let predicate = NSPredicate(format: "professor == %@", selectedProfessor)
        fetchRequestCourses.predicate = predicate
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequestCourses, error: nil) as? [Course] {
            courses = fetchResults
            courses = courses.sorted({$0.title < $1.title})
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Scroll View Delegates
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView == baseScrollView {
            let fadeRegionRight = scrollView.contentSize.height - scrollView.frame.height
            println("scrollView.contentSize.height: \(scrollView.contentSize.height)")
            println("scrollView.frame.height: \(scrollView.frame.height)")
            println("scrollView.contentOffset.y: \(scrollView.contentOffset.y)")
            if scrollView.contentOffset.y > 49 {
                navigationController?.setNavigationBarHidden(true, animated: true)
                let alpha: CGFloat = (124 - CGFloat(scrollView.contentOffset.y))/31
                if alpha <= 1 {
                    profContainer.ratingCircle.alpha = alpha
                    profContainer.ratingNumberLabel.alpha = alpha
                } else {
                    profContainer.ratingCircle.alpha = 1
                    profContainer.ratingNumberLabel.alpha = 1
                }
                
            } else {
                navigationController?.setNavigationBarHidden(false, animated: true)
            }
        }
        
//        let fadeRegionRight = scrollView.contentSize.width - scrollView.frame.width - 50
//        let scrollViewPos = scrollView.contentOffset.x
//        if scrollViewPos >= fadeRegionRight {
//            scrollFadeRight.alpha = 1 - (scrollViewPos - fadeRegionRight)/50
//            scrollFadeLeft.alpha = 1
//        } else if scrollViewPos <= 50 {
//            scrollFadeLeft.alpha = scrollViewPos/50
//            scrollFadeRight.alpha = 1
//        } else {
//            scrollFadeRight.alpha = 1
//            scrollFadeLeft.alpha = 1
//        }
    }
    
    @IBAction func leftScrollButton(sender: UIButton) {
        println("left scroll button down")
        attributesHorizontalScrollView.contentOffset.x -= 1
    }
    
    @IBAction func rightScrollButton(sender: UIButton) {
        println("right scroll button down")
        attributesHorizontalScrollView.contentOffset.x += 1
    }
    
    // MARK: - Table View for Professor's Courses
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PrototypeCell", forIndexPath: indexPath) as! UITableViewCell
        let row = indexPath.row
        cell.textLabel?.text = courses[row].title + "- \(courses[row].section)"
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    // MARK - Segue
    
    func segueToRatingScreen(){
        performSegueWithIdentifier("ProfessorToRating", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ProfessorToRating" {
            var destinationView = segue.destinationViewController as! RatingViewController
            destinationView.selectedProfessor = selectedProfessor
            if selectedCourse != nil {
                destinationView.selectedCourse = selectedCourse
            }
        } else if segue.identifier == "professorContainer" {
            var destinationView = segue.destinationViewController as! ProfessorContainerViewController
            profContainer = destinationView
            if selectedCourse != nil {
                destinationView.selectedCourse = selectedCourse
            }
        }
    }
}
