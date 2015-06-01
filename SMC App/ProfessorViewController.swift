//
//  ProfessorViewController.swift
//  SMC App
//
//  Created by Harrison Balogh on 5/13/15.
//  Copyright (c) 2015 CPC iOS. All rights reserved.
//

import UIKit

class ProfessorViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBOutlet var backSwipe: UIScreenEdgePanGestureRecognizer!
    
    @IBAction func backFromSwipe(sender: UIScreenEdgePanGestureRecognizer){
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
