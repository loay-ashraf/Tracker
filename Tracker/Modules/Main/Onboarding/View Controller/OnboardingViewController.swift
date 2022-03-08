//
//  OnboardingViewController.swift
//  Tracker
//
//  Created by Loay Ashraf on 07/03/2022.
//

import UIKit

class OnboardingViewController: UIPageViewController, OnboardingConclusionDelegate {

    // MARK: - Properties
    
    var isNotificationUnlocked = false
    var isConclusionUnlocked = false
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        let storyBoard = StoryboardConstants.main
        return [createIntroPage(),
                createLocationAccessPage(),
                createNotificationsAccessPage(),
                createConclusionPage()]
    }()
    
    let notificationManager = NotificationManager.standard
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        notificationManager.resetNotificationBadge()
        dataSource = self
        setupPageViewControllers()
    }
    
    // MARK: - View Helper Methods
    
    private func setupPageViewControllers() {
        if let introViewController = orderedViewControllers.first {
            setViewControllers([introViewController],
            direction: .forward,
            animated: true,
            completion: nil)
        }
    }
    
    func createIntroPage() -> UIViewController {
        let storyBoard = StoryboardConstants.main
        return storyBoard.instantiateViewController(withIdentifier: "IntroVC")
    }
    
    func createLocationAccessPage() -> UIViewController {
        let storyBoard = StoryboardConstants.main
        let vc = storyBoard.instantiateViewController(withIdentifier: "LocationAccessVC")
        (vc as? LocationAccessViewController)?.delegate = self
        return vc
    }
    
    func createNotificationsAccessPage() -> UIViewController {
        let storyBoard = StoryboardConstants.main
        let vc = storyBoard.instantiateViewController(withIdentifier: "NotificationAccessVC")
        (vc as? NotificationAccessViewController)?.delegate = self
        return vc
    }
    
    func createConclusionPage() -> UIViewController {
        let storyBoard = StoryboardConstants.main
        let vc = storyBoard.instantiateViewController(withIdentifier: "ConclusionVC")
        (vc as? ConclusionViewController)?.delegate = self
        return vc
    }

}

extension OnboardingViewController: UIPageViewControllerDataSource {
 
    // MARK: - Data Source
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }

        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else {
            return nil
        }

        guard orderedViewControllers.count > previousIndex else {
            return nil
        }

        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
                
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count

        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
                
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
                
        return orderedViewControllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        if let currentVC = self.viewControllers?.first {
            let currentIndex = orderedViewControllers.firstIndex(of: currentVC)
            return currentIndex!
        } else{
            return 0
        }
    }
    
}

extension OnboardingViewController: OnboardingLocationAccessDelegate {
    
    // MARK: - Location Access Delegate
    
    func didFinishLocationAccess() {
        goToNextPage()
        isNotificationUnlocked = true
    }
    
}

extension OnboardingViewController: OnboardingNotificationAccessDelegate {
    
    // MARK: - Notification Access Delegate
    
    func didFinishNotificationsAccess() {
        goToNextPage()
        isConclusionUnlocked = true
    }
    
}
