//
//  NavigationRouter.swift
//  GitIt
//
//  Created by Loay Ashraf on 06/02/2022.
//

import UIKit

class NavigationRouter {
    
    // MARK: - Properties
    
    static var rootTabBarController: UITabBarController? { return UIApplication.currentTabBarController() }
    static var currentNavigationController: UINavigationController? { return UIApplication.currentNavigationController() }
    static var currentViewController: UIViewController? { return UIApplication.currentViewController() }
    
    // MARK: - Initialization
    
    private init() { }
    
    // MARK: - Tab Bar Methods
    
    class func showTab(withIndex index: Int) {
        guard let viewControllers = rootTabBarController?.viewControllers, index < viewControllers.count else {
            return
        }
        rootTabBarController?.selectedIndex = index
    }
    
    // MARK: - Navigation Presentation Methods
    
    class func push(viewController: UIViewController) {
        currentNavigationController?.pushViewController(viewController, animated: true)
    }
    
    class func pop() {
        currentNavigationController?.popViewController(animated: true)
    }
    
    // MARK: - Modal Presentation Methods
    
    class func present(viewController: UIViewController) {
        currentViewController?.present(viewController, animated: true, completion: nil)
    }
    
    class func dismiss() {
        currentViewController?.dismiss(animated: true, completion: nil)
    }
    
}
