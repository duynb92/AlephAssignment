//
//  UIView+AnimationBounce.swift
//  AlephAssignment
//
//  Created by DuyN on 7/19/18.
//  Copyright © 2018 DuyN. All rights reserved.
//

import Foundation
import UIKit
import ViewAnimator

public extension UIView {
    
    /// Performs the animation.
    ///
    /// - Parameters:
    ///   - animations: Array of Animations to perform on the animation block.
    ///   - reversed: Initial state of the animation. Reversed will start from its original position.
    ///   - initialAlpha: Initial alpha of the view prior to the animation.
    ///   - finalAlpha: View's alpha after the animation.
    ///   - delay: Time Delay before the animation.
    ///   - duration: TimeInterval the animation takes to complete.
    ///   - completion: CompletionBlock after the animation finishes.
    public func animate(animations: [Animation],
                        reversed: Bool = false,
                        initialAlpha: CGFloat = 0.0,
                        finalAlpha: CGFloat = 1.0,
                        delay: Double = 0,
                        duration: TimeInterval = ViewAnimatorConfig.duration,
                        options: UIViewAnimationOptions = [],
                        usingSpringWithDamping: Double = 0.58, initialSpringVelocity: Double = 3,
                        completion: (() -> Void)? = nil) {
        
        let transformFrom = transform
        var transformTo = transform
        animations.forEach { transformTo = transformTo.concatenating($0.initialTransform) }
        if !reversed {
            transform = transformTo
        }
        
        alpha = initialAlpha
        
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: CGFloat(usingSpringWithDamping), initialSpringVelocity: CGFloat(initialSpringVelocity), options: options, animations: { [weak self] in
            self?.transform = reversed ? transformTo : transformFrom
            self?.alpha = finalAlpha
        }) { _ in
            completion?()
        }
    }
    
    /// Performs the animation.
    ///
    /// - Parameters:
    ///   - animations: Array of Animations to perform on the animation block.
    ///   - reversed: Initial state of the animation. Reversed will start from its original position.
    ///   - initialAlpha: Initial alpha of the view prior to the animation.
    ///   - finalAlpha: View's alpha after the animation.
    ///   - delay: Time Delay before the animation.
    ///   - animationInterval: Interval between the animations of each view.
    ///   - duration: TimeInterval the animation takes to complete.
    ///   - completion: CompletionBlock after the animation finishes.
    public static func animateBounce(views: [UIView],
                                     animations: [Animation],
                                     reversed: Bool = false,
                                     initialAlpha: CGFloat = 0.0,
                                     finalAlpha: CGFloat = 1.0,
                                     delay: Double = 0,
                                     animationInterval: TimeInterval = 0.05,
                                     duration: TimeInterval = ViewAnimatorConfig.duration,
                                     options: UIViewAnimationOptions = [],
                                     usingSpringWithDamping: Double = 0.58, initialSpringVelocity: Double = 3,
                                     completion: (() -> Void)? = nil) {
        
        guard views.count > 0 else {
            completion?()
            return
        }
        
        views.forEach { $0.alpha = initialAlpha }
        let dispatchGroup = DispatchGroup()
        for _ in 1...views.count { dispatchGroup.enter() }
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            for (index, view) in views.enumerated() {
                view.alpha = initialAlpha
                view.animate(animations: animations,
                             reversed: reversed,
                             initialAlpha: initialAlpha,
                             finalAlpha: finalAlpha,
                             delay: Double(index) * animationInterval,
                             duration: duration,
                             options: options,
                             usingSpringWithDamping: usingSpringWithDamping + (Double(index)/10.0)*3, initialSpringVelocity: initialSpringVelocity ,
                             completion: { dispatchGroup.leave() })
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion?()
        }
    }
}
