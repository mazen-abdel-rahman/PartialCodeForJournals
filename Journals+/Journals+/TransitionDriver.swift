//
//  TransitionDriver.swift
//  Journals+
//
//  Created by Mazen M. Abdel-Rahman on 2/9/17.
//  Copyright © 2017 Mazen M. Abdel-Rahman. All rights reserved.
//

import UIKit

class TransitionDriver: NSObject {

    var navOperation:UINavigationController.Operation
    var transitionContext:UIViewControllerContextTransitioning
    
    init(operation:UINavigationController.Operation, context: UIViewControllerContextTransitioning) {
        
        self.navOperation = operation
        self.transitionContext = context;
        
        super.init()
        
        
        let fromVC = self.transitionContext.viewController(forKey: .from) as! MainShelfViewController
        
        let toVC = self.transitionContext.viewController(forKey: .to)
        
        let containerView = context.containerView
        
        toVC?.view.alpha = 0.0
        containerView.addSubview(toVC!.view)
        
        
        let selectedCell = fromVC.tableView(fromVC.tableView, cellForRowAt: fromVC.selectedCellIndexPath!) as! MZNMainPageCompactTableViewCell
        
        selectedCell.journalCoverImage.alpha = 0.0
        
        let coverImageURL = fromVC.journals[(fromVC.selectedCellIndexPath?.row)!].folderName
        
        
//        let coverImageForAnimation = UIImage(named: coverImageURL!)
        let frame = selectedCell.journalCoverImage.frame
        let adjustedFrame = selectedCell.convert(frame, to: context.containerView)
        let imageView = UIImageView(frame: adjustedFrame)
//        imageView.image = coverImageForAnimation
        applyMaskToCoverImageView(coverImageView: imageView)
        
        context.containerView.addSubview(imageView);
        
        
//        let coverImage2ForAnimation = UIImage(named: coverImageURL!)
        let imageView2 = UIImageView(frame: adjustedFrame)
//        imageView2.image = coverImage2ForAnimation
        imageView2.alpha = 0.0
        
        
        
        
              
        let velocity = CGVector(dx: 0.5, dy: 0.5)
        let timingParameters = UISpringTimingParameters(mass: 4.5, stiffness: 1300, damping: 95, initialVelocity: velocity)
        
        let propertyAnimated = UIViewPropertyAnimator(duration: 0.8, timingParameters: timingParameters)
        
        propertyAnimated.addAnimations {
            //
            let finalFrame = context.finalFrame(for: toVC!)
            
            

            let boundingRect = toVC?.view.convert((toVC?.view?.bounds)!, to: nil)

            
            
            imageView.layer.mask?.frame = boundingRect! // CGRect(x:100, y:100, width:320, height:600)
            
            
            imageView.frame = boundingRect! // CGRect(x:100, y:100, width:320, height:600) // finalFrame
            imageView2.frame = boundingRect!
            
            
            
//           imageView2.alpha = 1.0
//            imageView.alpha = 0.0
            
        }
        
        propertyAnimated.addCompletion { (position) in
            
            toVC?.view.alpha = 1.0;
            
//            imageView.removeFromSuperview()
//            imageView2.removeFromSuperview()
        }
        
        
             
        propertyAnimated.startAnimation()
        
        
        
    }
    
    
    func applyMaskToCoverImageView(coverImageView:UIImageView) {
        
        let maskLayer = CALayer()
        let maskImage = UIImage(named: "mask")
        maskLayer.contents = maskImage?.cgImage
        maskLayer.frame = CGRect(x: 0.0, y: 0.0, width: (maskImage?.size.width)!, height: (maskImage?.size.height)!)
        coverImageView.layer.mask = maskLayer
        coverImageView.layer.masksToBounds = true
        coverImageView.contentMode = .scaleAspectFill
        
        
        
        
    }

}
