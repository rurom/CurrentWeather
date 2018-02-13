//
//  SetupViewConstraints.swift
//  CurrentWeather
//
//  Created by Roman on 2/9/18.
//  Copyright © 2018 Roman Rudavskiy. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

//Use this generic function for Autolayout to setup all constraints programmatically using NSLayoutAnchor
func setupViewConstraints(item:UIView, leadingTo:NSLayoutXAxisAnchor, leadingCon:CGFloat, trailingTo:NSLayoutXAxisAnchor, trailingCon:CGFloat, topTo:NSLayoutYAxisAnchor, topCon:CGFloat, bottomTo:NSLayoutYAxisAnchor, bottomCon:CGFloat) {
    
        item.translatesAutoresizingMaskIntoConstraints = false
        item.leadingAnchor.constraint(equalTo: leadingTo, constant: leadingCon).isActive = true
        item.trailingAnchor.constraint(equalTo: trailingTo, constant: trailingCon).isActive = true
        item.topAnchor.constraint(equalTo: topTo, constant:topCon).isActive = true
        item.bottomAnchor.constraint(equalTo: bottomTo, constant:bottomCon).isActive = true
    }

//Use this generic function for Autolayout if you need to setup width and height of the view and align it to center vertically and horizontally
    func setupViewWidthHeightCenter (item:UIView, toView:UIView, widthMp:CGFloat, heightMp:CGFloat) {
    
    item.translatesAutoresizingMaskIntoConstraints = false
    item.centerXAnchor.constraint(equalTo: toView.centerXAnchor).isActive = true
    item.centerYAnchor.constraint(equalTo: toView.centerYAnchor).isActive = true
    item.widthAnchor.constraint(equalToConstant: (toView.frame.width)*widthMp).isActive = true
    item.heightAnchor.constraint(equalToConstant: (toView.frame.height)*heightMp).isActive = true
}
    

    //Center the item inside the view
    func setupCenterPosition(item:UIView, toView:UIView) {
        item.translatesAutoresizingMaskIntoConstraints = false
        item.centerXAnchor.constraint(equalTo: toView.centerXAnchor).isActive = true
        item.centerYAnchor.constraint(equalTo: toView.centerYAnchor).isActive = true
    }

//A Very convenient generic function for shortening the code
    func heightTo(toView:UIView, mp:CGFloat) -> CGFloat {
        let res = (toView.frame.height)*mp
        return res
    }
    
   
}//extension
    
    



