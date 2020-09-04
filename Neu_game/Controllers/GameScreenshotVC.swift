//
//  GameScreenshotVC.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 15/08/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import UIKit


class GameScreenshotVC: UIViewController {
    
    var screenshot = [String]()
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         collectionView.backgroundColor = .white
        setupviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.tabBarController?.tabBar.isHidden = true
         self.navigationController?.isToolbarHidden = true
     }

     override func loadView() {
         super.loadView()
         let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
         collectionView.translatesAutoresizingMaskIntoConstraints = false
         self.view.addSubview(collectionView)
         
         NSLayoutConstraint.activate([
             self.view.topAnchor.constraint(equalTo: collectionView.topAnchor),
             self.view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
             self.view.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
             self.view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor)
         ])
         
         self.collectionView = collectionView

     }
    
    private func setupviews(){
         
           colllectionViewsSetup()
       }
       
       
       private func colllectionViewsSetup(){
           self.collectionView.alwaysBounceVertical = true
           self.collectionView.backgroundColor = .white
           collectionView.dataSource = self
           collectionView.delegate = self
           self.collectionView.registerReusableItem(ScreenshotCell.self)
           collectionView?.backgroundColor = .clear
           collectionView?.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
       }
       
}


extension GameScreenshotVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screenshot.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ScreenshotCell = collectionView.dequeueReusableItem(at: indexPath)
        cell.screenshotItemImage.layer.cornerRadius = 5
        cell.screenshotItemImage.clipsToBounds = true
        NWService.shared.downloadImage(screenshot[indexPath.item], cell.screenshotItemImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 200)
    }
    
}



