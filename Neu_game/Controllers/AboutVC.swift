//
//  AboutVC.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 02/08/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameProfile: UILabel!
    
    @IBOutlet weak var emailProfile: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameProfile.text = "I Dewa Gede Agus Prabawa"
        emailProfile.text = "balipastika@gmail.com"
        profileImage.image = UIImage(named: "prabawa")
        
        guard let imageData = profileImage.image?.pngData() else { return }
        
        if !UserDefaults.standard.bool(forKey: "setup"){
            UserDefaults.standard.set(true, forKey: "setup")
            UserDefaults.standard.set(nameProfile.text, forKey: "username")
            UserDefaults.standard.set(emailProfile.text, forKey: "email")
            UserDefaults.standard.set(imageData, forKey: "profile")
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateNewProfile()
    }
    
    func updateNewProfile(){
        
        guard let username = UserDefaults.standard.value(forKey: "username") as? String else {return}
        
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else { return }
        
        guard let newProfileImage = UserDefaults.standard.value(forKey: "profile") as? Data else { return }
        
        nameProfile.text = username
        emailProfile.text = email
        
        profileImage.image = UIImage(data: newProfileImage)
    }
    
    
    @IBAction func editProfile(){
        if let vc = storyboard?.instantiateViewController(identifier: "GameProfileEditVC") as? GameProfileEditVC {
            vc.profileName = nameProfile.text
            vc.profileEmail = emailProfile.text
            vc.profileImage = profileImage.image
            
            
            vc.update = {
                self.updateNewProfile()
            }
            
            present(vc, animated: true, completion: nil)
        }
        
        
    }
}
