//
//  LoaderViewController.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 18/08/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


class LoaderViewController: UIViewController {
      
      private var upcomingGameModel:[RawgContents]?
      private var classicGameModel:[RawgContents]?
      private var platformGameModel:[Platforms]?
        
        
      private var genreCollection = [String: (image: String, model: RawgModelGames)]()
      private var genreCollectionTitles = [String]()
      private var genreCollectionImages = [String]()
        
        
      private var platformCollection = [String: (image: String, model: RawgModelGames)]()
      private var platformCollectionTitles = [String]()
      private var platformCollectionImages = [String]()
    
    
    var activityLoaderView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 50), type: .ballPulse, color: .white, padding: CGFloat(0))
    
    var titleLabel:UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "NEU GAME"
        lb.font = UIFont.boldSystemFont(ofSize: 30)
        lb.textColor = .white
        return lb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.0345714353, green: 0.1464241445, blue: 0.1970108449, alpha: 1)
        self.navigationController?.isNavigationBarHidden = true
        activityLoaderView.translatesAutoresizingMaskIntoConstraints = false
        let stackview = UIStackView(arrangedSubviews: [titleLabel, activityLoaderView])
        stackview.alignment = .center
        stackview.distribution = .fillEqually
        stackview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackview)
        stackview.axis = .vertical
        stackview.heightAnchor.constraint(equalToConstant: 100).isActive = true
        stackview.widthAnchor.constraint(equalToConstant: 300).isActive = true
        stackview.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
  
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        majorloadData()
    }
    

    
    func majorloadData(){
        activityLoaderView.startAnimating()
        let group = DispatchGroup()
        let queueLoader = DispatchQueue(label: "com.Loader")
          
        group.enter()
        queueLoader.async(group: group) {
            NWService.shared.getGameList(.latest) { (upcomin, _) in
                guard let upcomin = upcomin?.results else { return }
                self.upcomingGameModel = upcomin
                
                 group.leave()
            }
        }
        
    
        group.enter()
        queueLoader.async(group: group) {
        NWService.shared.getGameList(.classic) { (classic, _) in
                    guard let classic = classic?.results else { return }
                    self.classicGameModel = classic
                  group.leave()
                }
        }
        
        group.enter()
        queueLoader.async(group: group) {
                  
        NWService.shared.getGameList(.classic) { (classic, _) in
                   guard let classic = classic?.results else { return }
                   self.classicGameModel = classic
                group.leave()
            }
                
        }
        
        group.enter()
        queueLoader.async(group: group) {
            let genreAPi = ApiCollectionsData.shared.collectionGenreListApi()
                   
                   NWService.shared.loaderAPiCollection(genreAPi) { (dictionary) in
                       self.genreCollection = dictionary
                       for i in dictionary {
                           self.genreCollectionTitles.append(i.key)
                           self.genreCollectionImages.append(i.value.image)
                           
                       }
                    group.leave()
                   }
        }

        group.enter()
        queueLoader.async(group: group) {
        let platfromAPi = ApiCollectionsData.shared.collectionPlatformListApi()
        
        NWService.shared.loaderAPiCollection(platfromAPi) { (dictionary) in
            self.platformCollection = dictionary
            for i in dictionary {
                self.platformCollectionTitles.append(i.key)
                self.platformCollectionImages.append(i.value.image)
                }
            group.leave()
            }
        }

       
       group.enter()
        queueLoader.async(group: group) {
            
            NWService.shared.getGamePlatform { (platfotm, _) in
                guard let platform = platfotm?.results else { return }
                self.platformGameModel = platform
            }
            group.leave()
        }

        
        group.notify(queue: .main){
            self.activityLoaderView.stopAnimating()
            print("success load")
            self.navigationToHome()
        }
           
    }
    
    
     func navigationToHome() {
         var tabbarVC: UITabBarController
         tabbarVC = TabbarVC()
         if let tabbarViewcontrollers = tabbarVC.viewControllers {
             if let homeHomeVC = tabbarViewcontrollers[0].children[0] as? GameHomeVC {
         
                     homeHomeVC.upcomingGameModel = self.upcomingGameModel
                     homeHomeVC.classicGameModel = self.classicGameModel
                     homeHomeVC.platformGameModel = self.platformGameModel
                     homeHomeVC.genreCollectionTitles = self.genreCollectionTitles
                     homeHomeVC.genreCollectionImages = self.genreCollectionImages
                     homeHomeVC.genreCollection = self.genreCollection
                     homeHomeVC.platformCollectionTitles = self.platformCollectionTitles
                     homeHomeVC.platformCollectionImages = platformCollectionImages
                     homeHomeVC.platformCollection = self.platformCollection
              
                _ = navigationController?.pushViewController(tabbarVC, animated: true)
             }
         }
     }

     
}
