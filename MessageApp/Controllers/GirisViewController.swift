//
//  GirisViewController.swift
//  MessageApp
//
//  Created by mac on 8.03.2022.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift

class GirisViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var sifreTextfield: UITextField!
    
    @IBAction func girisIslemi(_ sender: UIButton) {
        
        
        if let email = emailTextfield.text, let sifre = sifreTextfield.text {
            Auth.auth().signIn(withEmail: email, password: sifre) { authResult, error in
                if let e = error {
                    print(e)
                }else{
                    self.performSegue(withIdentifier: Z.girisSegue, sender: self  
)
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
    emailTextfield.layer.cornerRadius = emailTextfield.frame.size.height / 5
    sifreTextfield.layer.cornerRadius = sifreTextfield.frame.size.height / 5
}
    
    }


 

