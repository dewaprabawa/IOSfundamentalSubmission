//
//  UpComingGameCell.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 08/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import UIKit
import Nuke

class UpComingGameCell: UITableViewCell {
    
    @IBOutlet var collectionView: UICollectionView!

    private var upcoming: [RawgContents]?
    
    var delegate: GameDetailDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupviews()
    }
    
    private func setupviews(){
        collectionViewSetups()
    }
    

    func configureUpComingGames(data: [RawgContents]?){
        self.upcoming = data
        collectionView.reloadData()
    }


    private func collectionViewSetups(){
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.registerReusableItem(UpComingItem.self)
              

        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
            flowLayout.minimumInteritemSpacing = 0
        }
    }
    
    

    private func configureUCItems(_ cell: UpComingItem, at indexPath:IndexPath){
       
        let latestGameList = upcoming?[indexPath.item]
        
        guard let imageURL = upcoming?[indexPath.item].backgroundImage else { return }
        
        NWService.shared.downloadImage(imageURL, cell.itemImage)
        
        if let rating = latestGameList?.rating {
            cell.rating.text = "\(rating)"
        }
        cell.released.text = latestGameList?.released
        cell.name.text = latestGameList?.name
    }
    
    
  
}

extension UpComingGameCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UpComingItem = collectionView.dequeueReusableItem(at: indexPath)
        configureUCItems(cell, at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: frame.width , height: 140 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedGame = upcoming?[indexPath.item] {
            delegate?.gameDetail(items: selectedGame)
        }
    }

    
}

