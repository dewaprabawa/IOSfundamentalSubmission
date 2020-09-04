//
//  GameProfileEditVC.swift
//  Neu_game
//
//  Created by Dewa Prabawa on 16/08/20.
//  Copyright © 2020 Dewa Prabawa. All rights reserved.
//

import UIKit

class GameProfileEditVC: UIViewController {
    
    var profileName:String?
    var profileImage:UIImage?
    var profileEmail:String?
    
    
    var update: (()-> Void)?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.text = profileName
        emailTextField.text = profileEmail
        imageProfile.image = profileImage
        
}
    
    
    @IBAction func changeImageButton(_ sender: Any) {
         showImagePicking()
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        
        if let username = nameTextField.text, !username.isEmpty{
            UserDefaults.standard.set(username, forKey: "username")
        }
        
        if let email = emailTextField.text, !email.isEmpty {
            UserDefaults.standard.set(email, forKey: "email")
        }
        
        update?()
        
        dismiss(animated: true, completion: nil)
    }
    
    
}


extension GameProfileEditVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func showImagePicking(){
        let imageViewController = UIImagePickerController()
        imageViewController.delegate = self
        imageViewController.allowsEditing = true
        imageViewController.sourceType = .photoLibrary
        present(imageViewController, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageProfile.image = editImage
            UserDefaults.standard.set(editImage.pngData(), forKey: "profile")
        }else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageProfile.image = originalImage
        }
        
        dismiss(animated: true, completion: nil)
    }
}
