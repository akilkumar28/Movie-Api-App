//
//  MoviePresentationController.swift
//  Movie Api App
//
//  Created by AKIL KUMAR THOTA on 6/22/17.
//  Copyright © 2017 Akil Kumar Thota. All rights reserved.
//

import UIKit

class MoviePresentationController: UIPresentationController,UIAdaptivePresentationControllerDelegate {
    
    
    var dimmingEffect = UIView()
    
    override var shouldPresentInFullscreen: Bool {
        return true
    }
    
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        
        
    super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        dimmingEffect.backgroundColor = UIColor(white: 0, alpha: 0.8)
        dimmingEffect.alpha = 0
    }
    
    
    override func presentationTransitionWillBegin() {
        dimmingEffect.frame = self.containerView!.bounds
        dimmingEffect.alpha = 0
        
        
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { (context:UIViewControllerTransitionCoordinatorContext) in
                self.dimmingEffect.alpha = 1
            }, completion: nil)
        }else{
            dimmingEffect.alpha = 1
        }
    }
    
    override func dismissalTransitionWillBegin() {
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { (context:UIViewControllerTransitionCoordinatorContext) in
                self.dimmingEffect.alpha = 0
            }, completion: nil)
        }else{
            dimmingEffect.alpha = 0
        }
    }
    
    
    override func containerViewWillLayoutSubviews() {
        if let containerBounds = containerView?.bounds {
            dimmingEffect.frame = containerBounds
            presentedView?.frame = containerBounds
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .overFullScreen
    }
    
    
    
    

}
