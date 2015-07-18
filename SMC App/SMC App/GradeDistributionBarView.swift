//
//  gradeDistributionBarView.swift
//  SMC App
//
//  Created by Harrison Balogh on 6/19/15.
//  Copyright (c) 2015 CPC iOS. All rights reserved.
//

import UIKit

protocol GradeDistributionBarDelegate : class {
    func getA_w() -> Int
    func getB_x() -> Int
    func getB_w() -> Int
    func getC_x() -> Int
    func getC_w() -> Int
    func getD_x() -> Int
    func getD_w() -> Int
    func getF_x() -> Int
    func getF_w() -> Int
}

class GradeDistributionBarView: UIView {
    
    weak var delegate:GradeDistributionBarDelegate!

    override func drawRect(rect: CGRect)
    {
        let context = UIGraphicsGetCurrentContext()
        
        //a
    var rectangle = CGRectMake(0,0,CGFloat(delegate!.getA_w()),14)
        CGContextAddRect(context, rectangle)
        CGContextSetFillColorWithColor(context, UIColor.greenColor().CGColor)
        CGContextFillRect(context, rectangle)
        
        //b
        rectangle = CGRectMake(CGFloat(delegate!.getB_x()),0,CGFloat(delegate!.getB_w()),14)
        CGContextAddRect(context, rectangle)
        CGContextSetFillColorWithColor(context, UIColor.grayColor().CGColor)
        CGContextFillRect(context, rectangle)
        
        //c
        rectangle = CGRectMake(CGFloat(delegate!.getC_x()),0,CGFloat(delegate!.getC_w()),14)
        CGContextAddRect(context, rectangle)
        CGContextSetFillColorWithColor(context, UIColor.darkGrayColor().CGColor)
        CGContextFillRect(context, rectangle)
        
        //d
        rectangle = CGRectMake(CGFloat(delegate!.getD_x()),0,CGFloat(delegate!.getD_w()),14)
        CGContextAddRect(context, rectangle)
        CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor)
        CGContextFillRect(context, rectangle)
        
        //f
        rectangle = CGRectMake(CGFloat(delegate!.getF_x()),0,CGFloat(delegate!.getF_w()),14)
        CGContextAddRect(context, rectangle)
        CGContextSetFillColorWithColor(context, UIColor.redColor().CGColor)
        CGContextFillRect(context, rectangle)
    }

}
