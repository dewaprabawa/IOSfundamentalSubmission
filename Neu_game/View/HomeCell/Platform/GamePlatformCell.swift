//
//  GamePlatformCell.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 15/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import UIKit

class GamePlatformCell: UITableViewCell {

    @IBOutlet weak var collectionview: UICollectionView!
    
    private var rawContents: [Platforms]?
    
    private var platformCollection = [String: (image: String, model: RawgModelGames)]()
    private var imagePlatform = [String]()
    private var titlePlatform = [String]()
    
    
    var delegate: GameListDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupviews()
    }
    
  
    func configurePlatformForItem(_ data:[String: (image: String, model: RawgModelGames)]){
           self.platformCollection = data
           collectionview.reloadData()
    }
    
    func configurePlatformForItem(_ imagePlatform: [String], _ titlePlatform: [String]){
        self.imagePlatform = imagePlatform
        self.titlePlatform = titlePlatform
        collectionview.reloadData()
    }
    
    
    
    
   private func setupviews(){
        collectionViewSetups()
    }
    
    
   private func collectionViewSetups(){
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.isPagingEnabled = true
        collectionview.registerReusableItem(GamePlatformItem.self)
        collectionViewLayout()
    }
    
    private func collectionViewLayout(){
        if let flowLayout = collectionview.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumInteritemSpacing = 0
        }
    }
    
   
    
    private func configurePlatformGameCell(_ cell: GamePlatformItem, at indexPath: IndexPath){
   
        let imagePlatformURL = imagePlatform[indexPath.item]
        let imagePlatformTitle = titlePlatform[indexPath.item]
        
        NWService.shared.downloadImage(imagePlatformURL, cell.imagePlatform)
        cell.titlePlatform.text = imagePlatformTitle.uppercased()
    }
    
}


extension GamePlatformCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titlePlatform.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:GamePlatformItem = collectionView.dequeueReusableItem(at: indexPath)
      configurePlatformGameCell(cell, at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 250, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 0, right: 5)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let string = titlePlatform[indexPath.item]
        
        if let items = platformCollection[string]?.model {
            delegate?.gameList(items: items)
        }
        
    }
    
}


