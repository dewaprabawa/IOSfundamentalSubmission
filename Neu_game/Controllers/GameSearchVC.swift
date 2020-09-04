//
//  GameSearchVC.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 18/07/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import Foundation
import UIKit


class GameSearchVC: UIViewController {
    
    @IBOutlet var tableView:UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var activityView: UIActivityIndicatorView!
    @IBOutlet var messageLable: UILabel!
    private var currentSearchTask: URLSessionDataTask?
    private var selectedIndex = 0
    
    private var games = [RawgContents]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupviews()
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.0345714353, green: 0.1464241445, blue: 0.1970108449, alpha: 1)

    }
    
    private func setupviews(){
        
        navigationSetups()
        tableViewSetups()
        messageLabel()
        activityView.isHidden = true
        messageLable.isHidden = false
        tableView.isHidden = true
        searchBar.delegate = self
    }
    
    private func navigationSetups(){
        self.title = "Search"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.backgroundColor = .white
    
    }
    
    private func tableViewSetups(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerReusableCell(SearchGameCell.self)
    }
    
    private func messageLabel(){
        messageLable.text = "You don't have any searches yet."
    }
    
    
    private func loadActivity(_ isLoad:Bool){
        if isLoad {
             activityView.isHidden = false
             activityView.startAnimating()
        }else {
            activityView.stopAnimating()
            activityView.isHidden = true
            tableView.isHidden = false
            messageLable.isHidden = false
        }
    }
    
    private enum Segue {
         static var DetailGameController = "GameDetailScrollView"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          guard let identifier = segue.identifier else { return }
          
          if Segue.DetailGameController == identifier {
              let destination = segue.destination as? GameDetailScrollView
            destination?.gameTemporaryStore = sender as? RawgContents
          }
      }
      
    
}

extension GameSearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 70
        let cell:SearchGameCell = tableView.dequeueReusableCell(at: indexPath)
        cell.titleSearch.text = games[indexPath.item].name?.uppercased()
        if let imageBackhground = games[indexPath.item].backgroundImage {
            NWService.shared.downloadImage(imageBackhground, cell.imageSearch)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         let item = games[indexPath.item]
         performSegue(withIdentifier: Segue.DetailGameController, sender: item)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let lastIndexPath = tableView.indexPathsForVisibleRows?.last{
            if lastIndexPath.row <= indexPath.row{
                cell.center.y = cell.center.y + cell.frame.height / 2
                cell.alpha = 0
                UIView.animate(withDuration: 0.5, delay: 0.05*Double(indexPath.row), options: [.curveEaseInOut], animations: {
                    cell.center.y = cell.center.y - cell.frame.height / 2
                    cell.alpha = 1
                }, completion: nil)
            }
        }
    }
    
}

extension GameSearchVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           currentSearchTask?.cancel()
            self.loadActivity(true)
           currentSearchTask =  NWService.shared.getSearchGetList(searchText, completion: { (games, _) in
         
            if let games = games?.results, !games.isEmpty {
                self.games = games
                self.loadActivity(false)
            }else{
                self.messageLable.isHidden = false
                self.messageLable.text = "No searches matched."
                
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
      
        })
        
       }
       
       func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
           searchBar.showsCancelButton = true
       }
       
       func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
           searchBar.showsCancelButton = false
       }
       
       func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
           searchBar.endEditing(true)
       }
    
    
}
