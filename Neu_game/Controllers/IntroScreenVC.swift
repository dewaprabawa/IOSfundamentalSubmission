//
//  IntroScreenController.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 27/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import UIKit

class IntroScreenVC: UIViewController, IntroScreenPageViewControllerDelegate{
    
    
    @IBOutlet weak var largeActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var nextButton: UIButton? {
        didSet{
            nextButton?.layer.cornerRadius = 25.0
            nextButton?.layer.masksToBounds = true
        }
    }
     
    @IBOutlet weak var skipButton: UIButton!
    
    var introScreenPageViewController: IntroScreenPageVC?
    
    
    @IBAction func skipButtonTapped(sender: UIButton){
        navigationToHome()
    }
    
    @IBAction func nextButtonTapper(sender: UIButton){
   
        if let index = introScreenPageViewController?.currentIndex {
            switch index {
            case 0...1:
                introScreenPageViewController?.forwardPage()
            case 2:
                navigationToHome()
            default:
                break
            }
        }
        updateUI()
    }
    
    func updateUI(){
        if let index = introScreenPageViewController?.currentIndex {
            switch index {
            case 0...1:
                nextButton?.setTitle("NEXT", for: .normal)
                skipButton.isHidden = false
            case 2:
                nextButton?.setTitle("GET STARTED", for: .normal)
                skipButton.isHidden = true
            default:
                break
            }
            
            pageControl.currentPage = index
        }
    }
    
    func didUpdatePageIndex(index: Int) {
        updateUI()
    }
    
    func navigationToHome(){
        let loaderVC = LoaderViewController()
        _ = navigationController?.pushViewController(loaderVC, animated: true)
        UserDefaults.standard.set(true, forKey: "savescreen")
    }
       
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let pageViewController = destination as? IntroScreenPageVC {
            introScreenPageViewController = pageViewController
            introScreenPageViewController?.introScreenPageDelegate = self
        }
    }
    
    
}


extension DispatchQueue {

    static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }

}
