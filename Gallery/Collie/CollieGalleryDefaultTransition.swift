

import UIKit

internal class CollieGalleryDefaultTransition: CollieGalleryTransitionProtocol {
    
    // MARK: - Private properties
    fileprivate let minorScale = CGAffineTransform(scaleX: 0.1, y: 0.1)
    fileprivate let offStage: CGFloat = 100.0
    
    
    // MARK: - CollieGalleryTransitionProtocol
    internal func animatePresentationWithTransitionContext(_ transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval) {
        let presentedController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! CollieGallery
        let presentedControllerView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        let containerView = transitionContext.containerView
        
        presentedControllerView.alpha = 0.0
        
        presentedController.pagingScrollView.transform = self.minorScale
        presentedController.closeButton.center.x -= self.offStage
       // presentedController.actionButton?.center.x += self.offStage
        presentedController.stack?.center.x += self.offStage
        presentedController.progressTrackView?.center.y += self.offStage
        presentedController.captionView.center.y += self.offStage
        
        
        containerView.addSubview(presentedControllerView)
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .allowUserInteraction, animations: {
            
            presentedControllerView.alpha = 1.0
            presentedController.closeButton.center.x += self.offStage
            //presentedController.actionButton?.center.x -= self.offStage
            presentedController.stack?.center.x -= self.offStage
            presentedController.progressTrackView?.center.y -= self.offStage
            presentedController.captionView.center.y -= self.offStage
            presentedController.pagingScrollView.transform = CGAffineTransform.identity
            
            }, completion: {(completed: Bool) -> Void in
                transitionContext.completeTransition(completed)
        })
    }
    
    internal func animateDismissalWithTransitionContext(_ transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval) {
        let presentingController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! CollieGallery
        let presentingControllerView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        let containerView = transitionContext.containerView
        
        containerView.addSubview(presentingControllerView)
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .allowUserInteraction, animations: {
            
            presentingControllerView.alpha = 0.0
            presentingController.closeButton.center.x -= self.offStage
//            presentingController.actionButton?.center.x += self.offStage
             presentingController.stack?.center.x += self.offStage
            presentingController.progressTrackView?.center.y += self.offStage
            presentingController.captionView.center.y += self.offStage
            presentingController.pagingScrollView.transform = self.minorScale
            
            }, completion: {(completed: Bool) -> Void in
                if(transitionContext.transitionWasCancelled){
                    transitionContext.completeTransition(false)
                    
                }
                else {
                    transitionContext.completeTransition(true)
                    
                }
        })
    }
}
