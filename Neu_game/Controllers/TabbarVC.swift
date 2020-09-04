//
//  TabbarVC.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 19/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents
import MaterialComponents.MaterialBottomNavigation

class TabbarVC: UITabBarController{
    
    let bottomNavBar = MDCBottomNavigationBar()
    

    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupviews()
    }
    
   
    private func setupviews(){
       navigationSetups()
    }
    
    private func introScreen(){
        let introScreen = IntroScreenVC()
        
        navigationController?.pushViewController(introScreen, animated: true)
    }
    
    
    
    private func navigationSetups(){
        bottomNavBar.titleVisibility = MDCBottomNavigationBarTitleVisibility.selected
        bottomNavBar.alignment = MDCBottomNavigationBarAlignment.justifiedAdjacentTitles
        bottomNavBar.elevation = .modalBottomSheet
        view.addSubview(bottomNavBar)
        bottomNavBar.delegate = self
        navigationIconSetups()
    }
    

    private func navigationIconSetups(){
        
        let homeItem = UITabBarItem(
            title: "Games",
            image: UIImage(named: "icons8-game-controller-24"),
            tag: 0)
        
        let searchItem = UITabBarItem(
            title: "Search",
            image: UIImage(named: "icons8-search-bar-24"),
            tag: 1)
        
        let favItem = UITabBarItem(
                 title: "Save",
                 image: UIImage(named: "icons8-visual-game-boy-50"),
                 tag: 2)
        
        let colItem = UITabBarItem(
                        title: "Collection",
                        image: UIImage(named: "icons8-add-to-collection-50"),
                        tag: 3)
    
        
           
        bottomNavBar.items = [homeItem, searchItem, favItem, colItem]
        bottomNavBar.selectedItem = homeItem
        
        favItem.badgeColor = .systemBlue
        favItem.badgeValue = "1"
        bottomNavBar.unselectedItemTintColor = .darkGray
        bottomNavBar.selectedItemTintColor = #colorLiteral(red: 0.0345714353, green: 0.1464241445, blue: 0.1970108449, alpha: 1)
        
      
    
        let homebar = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameHomeVC")
        let searchbar = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameSearchVC")
        let favbar = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameFavVC")
        let collectionbar = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "GameCollectionReviewVC")
        
        let gameHomeVC = UINavigationController(rootViewController: homebar)
        let gameSearchVC = UINavigationController(rootViewController: searchbar)
        let gameFavVC = UINavigationController(rootViewController: favbar)
        let gameCollectionVC = UINavigationController(rootViewController: collectionbar)
        
        self.viewControllers = [gameHomeVC, gameSearchVC, gameFavVC, gameCollectionVC]
    }
    
    
    
    private func layoutBottomNavBar() {
      let size = bottomNavBar.sizeThatFits(view.bounds.size)
      var bottomNavBarFrame = CGRect(x: 0,
                                     y: view.bounds.height - size.height,
                                     width: size.width,
                                     height: size.height)
      // Extend the Bottom Navigation to the bottom of the screen.
      if #available(iOS 11.0, *) {
        bottomNavBarFrame.size.height += view.safeAreaInsets.bottom
        bottomNavBarFrame.origin.y -= view.safeAreaInsets.bottom
      }
      bottomNavBar.frame = bottomNavBarFrame
    }
    
    override func viewWillLayoutSubviews() {
       layoutBottomNavBar()
    }
    
}


extension TabbarVC: MDCBottomNavigationBarDelegate {
    func bottomNavigationBar(_ bottomNavigationBar: MDCBottomNavigationBar, didSelect item: UITabBarItem) {
        self.selectedIndex = 2
        self.selectedViewController = self.viewControllers![item.tag]

    }
}



