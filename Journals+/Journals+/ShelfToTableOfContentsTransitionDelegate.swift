//
//  ShelfToTableOfContentsTransitionDelegate.swift
//  Journals+
//
//  Created by Mazen M. Abdel-Rahman on 2/4/17.
//  Copyright © 2017 Mazen M. Abdel-Rahman. All rights reserved.
//

import UIKit

class ShelfToTableOfContentsTransitionDelegate:NSObject,  UIViewControllerTransitioningDelegate {
    private let flipPresentAnimationController = ShelfToTableOfContentsAnimationController()
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return flipPresentAnimationController;
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return flipPresentAnimationController;
    }
}
