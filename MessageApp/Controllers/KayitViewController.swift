//
//  KayitViewController.swift
//  MessageApp
//
//  Created by mac on 8.03.2022.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift

class KayitViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var sifreTextfield: UITextField!
    @IBOutlet weak var KayitIslemi: UIButton!
    
    @IBAction func KayitIslemi(_ sender: UIButton) {
    if let email = emailTextfield.text, let sifre = sifreTextfield.text {
        Auth.auth().createUser(withEmail: email, password: sifre) { authResult,error in
            if let e = error {
                print(e)
            }else{
                self.performSegue(withIdentifier: Z.kayitSegue, sender: self
)
            }
        }
    }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextfield.layer.cornerRadius = emailTextfield.frame.size.height / 5
        sifreTextfield.layer.cornerRadius = sifreTextfield.frame.size.height / 5
        KayitIslemi.layer.cornerRadius = KayitIslemi.frame.size.height / 5
    }
    
    
}




    
   


