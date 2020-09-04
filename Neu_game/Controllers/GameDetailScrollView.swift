//
//  GameDetailScrollView.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 13/08/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Nuke
import CoreData
import MaterialComponents.MaterialActionSheet
import MaterialComponents.MaterialDialogs


class GameDetailScrollView: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    

    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
 
    
  
    var requestId: Int = 0
    var player: AVPlayer? = nil
    var task: ImageTask?
    var playerLayer: AVPlayerLayer? = nil
    var playerLooper: AnyObject?
    
    
    var gameTemporaryStore: RawgContents?
    
    var game: StoreGameModels?

    private var networking = NWService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        
        setupviews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
        self.createGameModelOfURL()
            
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func setupviews(){
     
    
        videoStorageSetups()
        tableviewSetups()
    }
    
    
    private func tableviewSetups(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerReusableCell(GameImageCell.self)
        tableView.registerReusableCell(GameDescriptionCell.self)
        tableView.registerReusableCell(GameGalleryCell.self)
    }
    
    private func videoStorageSetups(){
        TemporaryVideoStorage.shared.removeAll()
        ImageDecoders.MP4.register()
    }
 
    private func createGameModelOfURL(){
        
        guard let gameId = gameTemporaryStore?.id,
              let gameTitle = gameTemporaryStore?.name,
            let gameImageLink = gameTemporaryStore?.backgroundImage else { return }
        
        
        
        
      guard let gameReleased = gameTemporaryStore?.released, let gameRating = gameTemporaryStore?.rating,
        let gameScreenshotsURL = gameTemporaryStore?.screenshots else { return }
        
       
        var gameDescription:String?
        var gameScreenshotsLinks = [String]()
        var gameGenre = [String?]()
           
        if let genre = gameTemporaryStore?.genreGames{
                   for index in 0..<genre.count{
                       gameGenre.append(genre[index].name ?? "")
                   }
        }
        
        NWService.shared.getGameDescription(gameId) { (description, _) in
            DispatchQueue.main.async {
                gameDescription = description?.descriptionRaw
                
                let testgame = StoreGameModels(gameId: "\(gameId)", gameTitle: gameTitle, gameReleased: gameReleased, gameRating: "\(gameRating)", gameImageLink: gameImageLink, gameDescription: gameDescription, gameScreenshotsLinks: gameScreenshotsLinks, gameGenre: gameGenre, gameVideoPreviewImageLink: "", gameVideoLink: "")
               
              
                self.game = testgame
                self.tableView.reloadData()
            }
        }
  
        
        guard let gameVideoPreviewImageLink = gameTemporaryStore?.clip?.preview, let
            gameVideoLink = gameTemporaryStore?.clip?.clips?.full else { return }

        
        if let genre = gameTemporaryStore?.genreGames{
            if !genre.isEmpty {
                for index in 0..<genre.count{
                    gameGenre.append(genre[index].name ?? "")
                }
            }
        }
        
        print("checking: \(gameGenre)")
        
        if !gameScreenshotsURL.isEmpty {
            for i in gameScreenshotsURL {
                gameScreenshotsLinks.append(i.image ?? "")
            }
        }
        
    
        DispatchQueue.global(qos: .background).async { [weak self] in
              guard let strongSelf = self else { return }
            strongSelf.networking.getGameDescription(gameId) { (description, _) in
               gameDescription = description?.descriptionRaw ?? ""
                
                let newgame = StoreGameModels(gameId: "\(gameId)", gameTitle: gameTitle, gameReleased: gameReleased, gameRating: "\(gameRating)", gameImageLink: gameImageLink, gameDescription: gameDescription, gameScreenshotsLinks: gameScreenshotsLinks, gameGenre: gameGenre, gameVideoPreviewImageLink: gameVideoPreviewImageLink, gameVideoLink: gameVideoLink)
                 
                 

                self?.game = newgame
               
            }
              
        }
            
    }
    
      
    
    private func saveToCoreData(){
        
        if let game = game {
            if CoreDataManager.stack.isAlreadyRecord(game){
                    self.alertshowExisted()
                }else{
                  CoreDataManager.stack.saveGameWithCore(game)
            }
        }
    
    }
    
    private func configureImageCell(_ cell:GameImageCell){
        
        NWService.shared.downloadImage(game?.gameImageLink ?? "", cell.DetailGameImage)
        NWService.shared.downloadImage(game?.gameImageLink ?? "", cell.DetailGameImageBackdrop)
        cell.DetailTitle.text = game?.gameTitle ?? "Not Available"
        cell.DetailRating.text = game?.gameRating ?? "Not Available"
        
    }
    
    private func configureDescriptionCell(_ cell:GameDescriptionCell){
        
        cell.GameDetailDescription.text = game?.gameDescription
        cell.GameReleaseDate.text = game?.gameReleased
        
        if let genres = game?.gameGenre {
                if (genres.count - 1) >= 2{
                        cell.GameGenre.text =  "\(genres[0]!), \(genres[1]!), \(genres[2]!)"
                    }else if (genres.count - 1) >= 1 {
                        cell.GameGenre.text = "\(genres[0]!)"
                    }else if (genres.count - 1) <= 0 {
                        cell.GameGenre.text = "Not Available"
            }
        }
        
        cell.watchTrailer = {
            self.watchTrailer()
        }
        
        cell.visitStore = {
            self.showStore()
        }
        
        cell.readMore = {
            self.ReadMore()
        }
    }
    
    private func configureGalleryCell(_ cell:GameGalleryCell){
        
        
        cell.moreGallery = {
            self.ShowMore()
        }
        
        var screenshots = [String]()
        var screenshotURL = [String]()
                            
        if let screenshot = self.game?.gameScreenshotsLinks{
            for i in screenshot{
                guard let image = i else { return }
                screenshots.append(image)
            }
        }
                
        if let screenshotFromURL = self.gameTemporaryStore?.screenshots{
            if !screenshotFromURL.isEmpty{
                for i in screenshotFromURL {
                screenshotURL.append(i.image ?? "")
                    }
                }
        }
        
       
        
        if self.game == nil {
            if (screenshotURL.count - 1) >= 3{
                
                NWService.shared.downloadImage(screenshotURL[0], cell.GameImage0)
                NWService.shared.downloadImage(screenshotURL[1], cell.GameImage1)
                NWService.shared.downloadImage(screenshotURL[2], cell.GameImage2)
                NWService.shared.downloadImage(screenshotURL[3], cell.GameImage3)
               
            }
              else if (screenshotURL.count - 1) <= 2{
                cell.GameImage0.image = UIImage(named: "icons8-no-image-16")
                cell.GameImage1.image = UIImage(named: "icons8-no-image-16")
                cell.GameImage2.image = UIImage(named: "icons8-no-image-16")
                cell.GameImage3.image = UIImage(named: "icons8-no-image-16")
                
            }else{
                NWService.shared.downloadImage(screenshotURL[0], cell.GameImage0)
                NWService.shared.downloadImage(screenshotURL[1], cell.GameImage1)
            }
        }else {
            if (screenshots.count - 1) >= 2 {
                NWService.shared.downloadImage(screenshots[0], cell.GameImage0)
                NWService.shared.downloadImage(screenshots[1], cell.GameImage1)
                NWService.shared.downloadImage(screenshots[2], cell.GameImage2)
                NWService.shared.downloadImage(screenshots[3], cell.GameImage3)
            }else if (screenshots.count - 1) <= 0 {
                
                cell.GameImage0.image = UIImage(named: "icons8-no-image-16")
                cell.GameImage1.image = UIImage(named: "icons8-no-image-16")
                cell.GameImage2.image = UIImage(named: "icons8-no-image-16")
                cell.GameImage3.image = UIImage(named: "icons8-no-image-16")
            }else if (screenshots.count - 1) >= 1{
                NWService.shared.downloadImage(screenshots[0],  cell.GameImage0)
                NWService.shared.downloadImage(screenshots[1], cell.GameImage1)
            }
        }
         
    }
    
 
    func watchTrailer() {
        
        self.ActivityIndicator.isHidden = false
        self.ActivityIndicator.startAnimating()
        
        
       guard let videoURL = game?.gameVideoLink,
             let URL = URL(string: videoURL) else { return }
             self.setVideo(with: URL)

    }
    
    func showStore() {
       if let url = URL(string: "https://store.playstation.com/en-us/home/games"), !url.absoluteString.isEmpty {
                  UIApplication.shared.open(url, options: [:], completionHandler: nil)
              }
    }
    
    @IBAction func SaveGame(_ sender:UIButton) {
        
        SaveFav()
        
    }
    
    
    func ReadMore() {
        
        let item = game?.gameDescription
        
        performSegue(withIdentifier: "ReadMoreVC", sender: item)
        
      }
    
    func ShowMore() {
        
        let items = game?.gameScreenshotsLinks
        performSegue(withIdentifier: "GameScreenshotVC", sender:items )
        
    }
      
    
    private func SaveFav(){
        
          let actionSheet = MDCActionSheetController()
          actionSheet.alwaysAlignTitleLeadingEdges.toggle()
          actionSheet.actionTintColor = .black
          actionSheet.actionTextColor = .black
          actionSheet.messageTextColor = .black
          actionSheet.messageFont.withSize(30)
          
          
          let actionOne = MDCActionSheetAction(title: "Favourite",
                                               image: UIImage(named: "icons8-favorites-shield-30")){(_) in
                                               
                                    
                                                  self.alertshowSuccess("favourite")
                                                  self.saveToCoreData()
                                                 }
          

          let actionTwo = MDCActionSheetAction(title: "Add Collections",
                                                           image: UIImage(named: "icons8-add-to-collection-50")){(_) in
                                                          
                                                            self.performSegue(withIdentifier: "AddCollectionsVC", sender: self.game)
                                                          
          }
           
          actionSheet.addAction(actionOne)
        
          actionSheet.addAction(actionTwo)

          present(actionSheet, animated: true, completion: nil)
      }
    
}


extension GameDetailScrollView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            tableView.rowHeight = 270
            let cell: GameImageCell = tableView.dequeueReusableCell(at: indexPath)
            configureImageCell(cell)
            return cell
        case 1:
            tableView.rowHeight = 250
            let cell: GameDescriptionCell = tableView.dequeueReusableCell(at: indexPath)
            configureDescriptionCell(cell)
            return cell
        case 2:
            tableView.rowHeight = 200
            let cell: GameGalleryCell = tableView.dequeueReusableCell(at: indexPath)
            configureGalleryCell(cell)
            return cell
         default:
            return UITableViewCell()
            }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

extension GameDetailScrollView {
    
    private func alertshowSuccess(_ saveAt: String){
         
     let alerController = MDCAlertController(title: "", message: "this will be saved to \(saveAt) list")
         alerController.titleIcon = UIImage(named: "icons8-checked-30")
     let action = MDCAlertAction(title:"Exit") { (action) in print("Exit") }
         
         alerController.addAction(action)
         present(alerController, animated: true, completion: nil)
     }
     
      func alertshowExisted(){
            
        let alerController = MDCAlertController(title: "The item already added", message: "please add other items")
         alerController.titleIcon = UIImage(named: "icons8-warning-shield-40")
         let action = MDCAlertAction(title:"Exit") { (action) in print("Exit") }
            
            alerController.addAction(action)
            present(alerController, animated: true, completion: nil)
     }
     
}


extension GameDetailScrollView {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }

        if "GameScreenshotVC" == identifier {
            let destination = segue.destination as? GameScreenshotVC
            destination?.screenshot = sender as? [String] ?? [String]()
        }
        
        if "ReadMoreVC" == identifier {
            let destination = segue.destination as? ReadMoreVC
            destination?.descriptionGame = sender as? String ?? ""
        }
        
        if "AddCollectionsVC" == identifier {
            let destination = segue.destination as? AddCollectionsVC
            destination?.selectedGame = sender as? StoreGameModels
        }
    }

}

