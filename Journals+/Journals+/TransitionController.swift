//
//  TransitionController.swift
//  Journals+
//
//  Created by Mazen M. Abdel-Rahman on 2/9/17.
//  Copyright © 2017 Mazen M. Abdel-Rahman. All rights reserved.
//

import UIKit

class TransitionController: NSObject {

    var transitionDriver:TransitionDriver?
    var navOperation: UINavigationController.Operation = .none
}


extension TransitionController:UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        //Save the direction of the transition
        self.navOperation = operation;
        
        return self;
    }
    
}

extension TransitionController:UIViewControllerAnimatedTransitioning {
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        transitionDriver = TransitionDriver(operation: self.navOperation, context: transitionContext)
        
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 1.5;
    }
}
