//
//  GenreGameCell.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 12/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import UIKit
import UIKit

class GenreGameCell: UITableViewCell {
    
    
  
    @IBOutlet var collectionview: UICollectionView!
    @IBOutlet var containerCell: UIView!
    
    private var genreCollection = [String: (image: String, model: RawgModelGames)]()
    private var imageGenres = [String]()
    private var titleGenres = [String]()
    
    var delegate: GenreListDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupviews()
    }
    
    private func setupviews(){
        collectionViewSetups()
     
    }
    
    func configureGenreGames(data: [String: (image: String, model: RawgModelGames)]){
        self.genreCollection = data
        collectionview.reloadData()
     
    }
    
    func configureGenreGames(_ imageGenres: [String], _ titleGenres: [String] ){
        self.imageGenres = imageGenres
        self.titleGenres = titleGenres
        collectionview.reloadData()
    }
    
    
    
    private func containerView(){
        containerCell.clipsToBounds = false
        containerCell.layer.masksToBounds = false
        containerCell.layer.shadowColor = UIColor.black.cgColor
        containerCell.layer.shadowOpacity = 1.0
        containerCell.layer.shadowOffset = CGSize(width: 1, height: 1.5)
        containerCell.roundCorners(corners: [.topLeft,.topRight], radius: 10)
    }
    
    
    private func configure(_ cell: GenreGameItem, at indexPath: IndexPath){
  
        
        cell.nameGenre.text = titleGenres[indexPath.item].uppercased()
        
        let image = imageGenres[indexPath.item]
        
        NWService.shared.downloadImage(image, cell.imageGenre)
        

    }

    
    private func collectionViewSetups(){
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.isPagingEnabled = true
        collectionview.registerReusableItem(GenreGameItem.self)
        collectionViewLayout()
    }
    
    private func collectionViewLayout(){
        if let flowLayout = collectionview.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
             flowLayout.minimumInteritemSpacing = 0
        }
    }
}


extension GenreGameCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageGenres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:GenreGameItem = collectionView.dequeueReusableItem(at: indexPath)
        configure(cell, at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 120, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let string = titleGenres[indexPath.item]
        
        if let items = genreCollection[string]?.model {
            delegate?.genreList(items: items)
        }
    
        
    }
 
}

