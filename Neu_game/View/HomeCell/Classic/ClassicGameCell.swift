//
//  ClassicGameCell.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 12/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import UIKit

class ClassicGameCell: UITableViewCell {

    @IBOutlet var collectionView: UICollectionView!
    
    private var rawContents: [RawgContents]?
    
    var delegate: GameDetailDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupviews()
    }
    
    func configureClassicGame(data: [RawgContents]?){
        self.rawContents = data
        collectionView.reloadData()
    }
    
    private func setupviews(){
        collectionViewSetups()
    }
    

    
    private func collectionViewSetups(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.registerReusableItem(ClassicGameItem.self)
        collectionViewLayout()
    }
    
    
    private func configureGameItem(_ cell: ClassicGameItem, at indexPath: IndexPath){
        guard let classic = rawContents?[indexPath.item].backgroundImage else { return }
        guard let classicContent = rawContents?[indexPath.item] else { return }
        NWService.shared.downloadImage(classic, cell.imageClassic)
        
        cell.rating.text = "\(classicContent.rating!)"
        cell.releaseded.text = classicContent.released
        cell.nameClassic.text = classicContent.name?.uppercased()
    }
    
    private func collectionViewLayout(){
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
            flowLayout.minimumInteritemSpacing = 0
        }
    }
}


extension ClassicGameCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ClassicGameItem = collectionView.dequeueReusableItem(at: indexPath)
        configureGameItem(cell, at: indexPath)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let rawcontent = rawContents?[indexPath.item] {
            delegate?.gameDetail(items: rawcontent)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: frame.width, height: 140 )
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
      
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let selectedGame = rawContents?[indexPath.item] {
         delegate?.gameDetail(items: selectedGame)
        }
    }
    
}
