//
//  ShelfToTableOfContentsAnimationController.swift
//  Journals+
//
//  Created by Mazen M. Abdel-Rahman on 2/4/17.
//  Copyright © 2017 Mazen M. Abdel-Rahman. All rights reserved.
//

import UIKit

class ShelfToTableOfContentsAnimationController:NSObject, UIViewControllerAnimatedTransitioning {
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.5
    }

    
/*
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // 1
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
                return
        }
        
        let containerView = transitionContext.containerView
    
        let initialFrameCoverImageThumb = originFrame
        let finalFrameOfTableOfContents = transitionContext.finalFrame(for: toVC)
        
        let snapshotOfTableOfContents = toVC.view.snapshotView(afterScreenUpdates: true)
        snapshotOfTableOfContents?.frame = initialFrameCoverImageThumb

        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshotOfTableOfContents!)
        toVC.view.isHidden = true
        
        let duration = transitionDuration(using: transitionContext)
        
        //Get Selected Cover Image Thumb
        let mainShelfVC:MainShelfViewController = fromVC as! MainShelfViewController
        
        let tableView = mainShelfVC.tableView
        
        let selectedCell:MZNMainPageCompactTableViewCell = tableView?.cellForRow(at: (tableView?.indexPathForSelectedRow)!) as! MZNMainPageCompactTableViewCell
        
        let coverImageThumbView = selectedCell.journalCoverImage
   
        let snapShotImageThumbView = coverImageThumbView?.snapshotView(afterScreenUpdates: false)
        
        snapShotImageThumbView?.frame = initialFrameCoverImageThumb
        
//        containerView.addSubview(snapShotImageThumbView!)
        
        
//        snapshotOfTableOfContents?.alpha = 0.0
        
        
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options:.calculationModeCubic, animations: { 
            
//            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0, animations: { 
//                snapShotImageThumbView?.frame = finalFrameOfTableOfContents
//            })
//            
//            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0, animations: {
//                snapShotImageThumbView?.alpha = 0.0
//            })

            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0, animations: {
                snapshotOfTableOfContents?.frame = finalFrameOfTableOfContents
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0, animations: {
                snapshotOfTableOfContents?.alpha = 1.0
                fromVC.view.alpha = 0.0;
            })

            
            
        }) { (_ completed) in
            toVC.view.isHidden = false
            snapshotOfTableOfContents?.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)

        }
        
        
        
        
//        UIView.animateKeyframes(
//            withDuration: duration,
//            delay: 0,
//            options: .calculationModeCubic,
//            animations: {
//                // 2
//                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3 * 2, animations: {
//                    
//                    let mainShelfVC:MainShelfViewController = fromVC.childViewControllers[0] as! MainShelfViewController
//                    
//                    let tableView = mainShelfVC.tableView
//                    
//                    let selectedCell:MZNMainPageCompactTableViewCell = tableView?.cellForRow(at: (tableView?.indexPathForSelectedRow)!) as! MZNMainPageCompactTableViewCell
//                    
//                    let imageView = selectedCell.journalCoverImage
//                    
//                    imageView?.layer.transform = AnimationHelper.yRotation(angle: -M_PI_2)
//                })
//                
////                // 3
////                UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3, animations: {
////                    snapshot!.layer.transform = AnimationHelper.yRotation(angle: 0.0)
////                })
////                
//                // 4
//                UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3, animations: {
//                    snapshot?.frame = finalFrame
//                })
//        },
//            completion: { _ in
//                // 5
//                toVC.view.isHidden = false
//                fromVC.view.layer.transform = AnimationHelper.yRotation(angle: 0.0)
//                snapshot?.removeFromSuperview()
//                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//        })
    }
    
    
*/
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toView = toViewController.view
        let fromView = fromViewController.view
        let direction: CGFloat =  1
        let const: CGFloat = -0.005
        
        if direction == 1 {
            toView?.layer.anchorPoint = CGPoint (x:0, y:0.5)
            fromView?.layer.anchorPoint = CGPoint( x:1  , y:0.5)
        } else {
            toView?.layer.anchorPoint = CGPoint (x:1, y:0.5)
            fromView?.layer.anchorPoint = CGPoint( x:0  , y:0.5)

        }
        
        var viewFromTransform: CATransform3D = CATransform3DMakeRotation(direction * CGFloat(M_PI_2), 1.0, 0.0, 0.0)
        var viewToTransform: CATransform3D = CATransform3DMakeRotation(-direction * CGFloat(M_PI_2), 1.0, 0.0, 0.0)
        viewFromTransform.m34 = const
        viewToTransform.m34 = const
        
        
               containerView.transform = CGAffineTransform(translationX: 0, y: direction * containerView.frame.size.width / 2.0)
        toView?.layer.transform = viewToTransform
        containerView.addSubview(toView!)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {           containerView.transform = CGAffineTransform(translationX: 0, y: -direction * containerView.frame.size.width / 2.0)
           // fromView?.layer.transform = viewFromTransform
           // toView?.layer.transform = CATransform3DIdentity
        }, completion: {
            finished in
            containerView.transform = CGAffineTransform.identity
            fromView?.layer.transform = CATransform3DIdentity
            toView?.layer.transform = CATransform3DIdentity
            fromView?.layer.anchorPoint = CGPoint(x:0.5, y:0.5)
            toView?.layer.anchorPoint = CGPoint(x:0.5, y:0.5)
            
            if (transitionContext.transitionWasCancelled) {
                toView?.removeFromSuperview()
            } else {
                fromView?.removeFromSuperview()
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })        
    }
}
