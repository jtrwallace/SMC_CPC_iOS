//
//  UIViewExtensions.swift
//  SMC App
//
//  Created by Harrison Balogh on 4/19/15.
//  Copyright (c) 2015 CPC iOS. All rights reserved.
//

import UIKit

extension UIView {
    // Name this function in a way that makes sense to you...
    // slideFromLeft, slideRight, slideLeftToRight, etc. are great alternative names
    func slideFromLeft(duration: NSTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideFromLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideFromLeftTransition.delegate = delegate
        }
        
        // Customize the animation's properties
        slideFromLeftTransition.type = kCATransitionPush
        slideFromLeftTransition.subtype = kCATransitionFromRight
        slideFromLeftTransition.duration = duration
        slideFromLeftTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        slideFromLeftTransition.fillMode = kCAFillModeRemoved
        
        // Add the animation to the View's layer
        self.layer.addAnimation(slideFromLeftTransition, forKey: "slideFromLeftTransition")
    }
    
    func slideFromRight(duration: NSTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideFromLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideFromLeftTransition.delegate = delegate
        }
        
        // Customize the animation's properties
        slideFromLeftTransition.type = kCATransitionPush
        slideFromLeftTransition.subtype = kCATransitionFromLeft
        slideFromLeftTransition.duration = duration
        slideFromLeftTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        slideFromLeftTransition.fillMode = kCAFillModeRemoved
        
        // Add the animation to the View's layer
        self.layer.addAnimation(slideFromLeftTransition, forKey: "slideFromLeftTransition")
    }
}