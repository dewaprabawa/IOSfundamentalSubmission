//
//  ViewController.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 07/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import UIKit
import Foundation

class GameHomeVC: UIViewController, GameDetailDelegate, GenreListDelegate, GameListDelegate {

    @IBOutlet var tableView: UITableView!

    var upcomingGameModel: [RawgContents]?
    var classicGameModel: [RawgContents]?
    var genreGameModel: [GameGenre]?
    var platformGameModel: [Platforms]?
    
    
    var genreCollection = [String: (image: String, model: RawgModelGames)]()
    var genreCollectionTitles = [String]()
    var genreCollectionImages = [String]()
    
    
    var platformCollection = [String: (image: String, model: RawgModelGames)]()
    var platformCollectionTitles = [String]()
    var platformCollectionImages = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupviews()
    }
    
    private func setupviews(){
        tableViewSetup()
        navigationSetups()
        
    }
    
    private func navigationSetups(){
        
        self.title = "Neu Game"
        self.navigationController?.navigationBar.prefersLargeTitles = true
         navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.0345714353, green: 0.1464241445, blue: 0.1970108449, alpha: 1)

        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    
    }
    
    private func tableViewSetup(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerReusableCell(UpComingGameCell.self)
        tableView.registerReusableCell(GenreGameCell.self)
        tableView.registerReusableCell(ClassicGameCell.self)
        tableView.registerReusableCell(GamePlatformCell.self)
        tableView.separatorStyle = .none
    }
    
    
    private func configureUpcomingCell(_ cell:UpComingGameCell){
        cell.configureUpComingGames(data: upcomingGameModel)
    }
    
    
    private func configureGenreCell(_ cell:GenreGameCell){
        cell.configureGenreGames(genreCollectionImages, genreCollectionTitles)
        cell.configureGenreGames(data: genreCollection)
    }
    
    private func configureClassicCell(_ cell:ClassicGameCell){
        cell.configureClassicGame(data: classicGameModel)
    }

    private func configurePlatformCell(_ cell:GamePlatformCell){
        cell.configurePlatformForItem(platformCollection)
        cell.configurePlatformForItem(platformCollectionImages,platformCollectionTitles)
    }
}
    
    
    

extension GameHomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            
        case 0:
            
            let cell: UpComingGameCell = tableView.dequeueReusableCell(at: indexPath)
            tableView.rowHeight = 180
            cell.delegate = self
            configureUpcomingCell(cell)
            return cell
        
        case 1:
           
            tableView.rowHeight = 200
            let cell:GenreGameCell = tableView.dequeueReusableCell(at: indexPath)
            cell.delegate = self
            configureGenreCell(cell)
            return cell
            
        case 2:
            
            tableView.rowHeight = 200
            let cell: ClassicGameCell = tableView.dequeueReusableCell(at: indexPath)
            cell.delegate = self
           configureClassicCell(cell)
            return cell
            
        case 3:
            
            tableView.rowHeight = 230
            let cell: GamePlatformCell = tableView.dequeueReusableCell(at: indexPath)
            cell.delegate = self
            configurePlatformCell(cell)
            return cell
             
            
        default:
            return UITableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


extension GameHomeVC {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }

        if "GameDetailScrollView" == identifier {
            let destination = segue.destination as? GameDetailScrollView
            destination?.gameTemporaryStore = sender as? RawgContents
        }
        
        
        if "GameGenreListVC" == identifier {
            let destination = segue.destination as? GameGenreListVC
            destination?.contents = sender as? RawgModelGames
        }
    }

    func gameDetail(items: RawgContents) {
        performSegue(withIdentifier: "GameDetailScrollView", sender: items)
    }
    
    func genreList(items: RawgModelGames) {
        performSegue(withIdentifier: "GameGenreListVC", sender: items)
    }
    
    func gameList(items: RawgModelGames) {
        performSegue(withIdentifier: "GameGenreListVC", sender: items)
    }
    
    
}




