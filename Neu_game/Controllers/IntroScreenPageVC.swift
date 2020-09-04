//
//  IntroScreenPageViewController.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 27/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import UIKit

protocol IntroScreenPageViewControllerDelegate: class {
    
    func didUpdatePageIndex(index: Int)
    
}

class IntroScreenPageVC: UIPageViewController {

    weak var introScreenPageDelegate: IntroScreenPageViewControllerDelegate?
    
   var header = ["WELCOME TO NEU GAME","NEVER LIMITS THE VIARTUAL EXPERIENCES","COLLECTING THE BEST GAME EVER"]
        
   var subHeader = ["This app will provide you bunch of current or old-school game list that you can have in play-list","Discover your best game by watch the reviews and videos","Collect and save the favourite one by add your own comments"]
        
   var imageFile =   ["steer-controller","old-controller","start-controller"]
        
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        dataSource = self
        delegate = self
        
        if let startingViewController = contentViewController(at: 0){
            setViewControllers([startingViewController], direction: .forward, animated: false, completion: nil)
        }
    }
    
}

extension IntroScreenPageVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! IntroScreenContentVC).index
        index -= 1
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! IntroScreenContentVC).index
        index += 1
        
        return contentViewController(at: index)
    }
    
    func contentViewController(at index: Int) -> IntroScreenContentVC? {
        if index < 0 || index >= header.count {
            return nil
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let introScreenContentController = storyboard.instantiateViewController(withIdentifier: "IntroScreenContentController") as? IntroScreenContentVC {
            introScreenContentController.header = header[index]
            introScreenContentController.subHeader = subHeader[index]
            introScreenContentController.imgFile = imageFile[index]
            introScreenContentController.index = index
            
            return introScreenContentController
        }
        return nil
    }
    
    func forwardPage(){
        currentIndex += 1
        
        print(currentIndex)
        if let next = contentViewController(at: currentIndex){
            setViewControllers([next], direction: .forward, animated: false, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed {
            if let contentViewController = pageViewController.viewControllers?.first as? IntroScreenContentVC {
                currentIndex = contentViewController.index
                
                introScreenPageDelegate?.didUpdatePageIndex(index: currentIndex)
            }
        }
    }
    
}
