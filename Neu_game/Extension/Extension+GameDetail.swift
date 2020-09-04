//
//  Extension+GameDetail.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 26/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Nuke

extension GameDetailScrollView{

    func prepareForReuse() {
    
        guard let videoURL = game?.gameVideoLink,
         let URL = URL(string: videoURL) else { return }
    
         TemporaryVideoStorage.shared.removeData(for: URL)
         playerLayer?.removeFromSuperlayer()
         playerLayer = nil
         player = nil
     }
     
     func setVideo(with url: URL){
         let pipeline = ImagePipeline.shared
         let request = ImageRequest(url: url)

         if let image = pipeline.cachedImage(for: request) {
             return display(image)
         }

         task = pipeline.loadImage(with: request) { [weak self] result in
             if case let .success(response) = result {
                 self?.display(response.container)
             }
         }
     }

     private func display(_ container: ImageContainer) {
         guard let data = container.data else {
             return
         }

         assert(container.userInfo["mime-type"] as? String == "video/mp4")

         self.requestId += 1
         let requestId = self.requestId

         TemporaryVideoStorage.shared.storeData(data) { [weak self] url in
             guard self?.requestId == requestId else { return }
             self?._playVideoAtURL(url)
            self?.ActivityIndicator.stopAnimating()
            self?.ActivityIndicator.isHidden = true
         }
     }

     private func _playVideoAtURL(_ url: URL) {
        let playerItem = AVPlayerItem(url: url)
         let player = AVQueuePlayer(playerItem: playerItem)
         let playerLayer = AVPlayerLayer(player: player)
         self.playerLooper = AVPlayerLooper(player: player, templateItem: playerItem)
         self.player = player
         self.playerLayer = playerLayer

        
         let playerViewController = AVPlayerViewController()
         prepareForReuse()
         playerViewController.player = player
         self.present(playerViewController, animated: true) {
            player.play()
         }
     }
    
    
}
