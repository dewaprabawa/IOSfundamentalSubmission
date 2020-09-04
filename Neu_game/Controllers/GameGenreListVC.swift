//
//  GameGenreListVC.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 01/08/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import UIKit
import Nuke


class GameGenreListVC: UIViewController {
    
    var contents: RawgModelGames?
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        setupviews()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.0345714353, green: 0.1464241445, blue: 0.1970108449, alpha: 1)

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
        self.collectionView.registerReusableItem(GenresListCell.self)
        collectionView?.backgroundColor = .clear
        collectionView?.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
    }
    
    
    private func configureImageInGenreList(_ cell: GenresListCell, at indexPath: IndexPath){
        
        guard let genreImage = contents?.results?[indexPath.item].backgroundImage else { return }
        guard let genreLabel = contents?.results?[indexPath.item].name else {
            return
        }
        guard let genreLabelRating = contents?.results?[indexPath.item].rating else {
            return
        }
        guard let genreLabelRelease = contents?.results?[indexPath.item].released else {
            return
        }
        
        
        cell.labelGenreTitle.text = genreLabel
        cell.ratingGenreTitle.text = "\(genreLabelRating)"
        cell.dateReleaseTitle.text = genreLabelRelease
        NWService.shared.downloadImage(genreImage, cell.imageGenreView)
        cell.backgroundColor = .white
    }
}



extension GameGenreListVC:UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
        
    }
    
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:GenresListCell = collectionView.dequeueReusableItem(at: indexPath)
        configureImageInGenreList(cell, at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
      return CGSize(width: itemSize, height: itemSize)
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          
        if let vc = storyboard?.instantiateViewController(withIdentifier: "GameDetailScrollView") as? GameDetailScrollView {
            let selectedgame = contents?.results?[indexPath.item]
            vc.gameTemporaryStore = selectedgame
          navigationController?.pushViewController(vc, animated: true)
        }
    }
}


