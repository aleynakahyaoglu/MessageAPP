//
//  MesajViewController.swift
//  MessageApp
//
//  Created by mac on 8.03.2022.
//

import UIKit
import Firebase

class MesajViewController: UIViewController {
  
    
    @IBOutlet weak var mesajTableView: UITableView!
    @IBOutlet weak var mesajTextfield: UITextField!
    
    let db = Firestore.firestore()
    var mesajlar: [Mesajlar] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
  
        title = Z.projeAdi
        navigationItem.hidesBackButton = true
        
        
       mesajTableView.register(UINib(nibName: Z.hücreNibAdi, bundle: nil), forCellReuseIdentifier: Z.hücreAdi)
       mesajTableView.dataSource = self
       mesajTableView.delegate = self
        
        loadMesajlar()
        
        
       
        // Do any additional setup after loading the view.
    }
    
    func loadMesajlar() {
        db.collection(Z.Firestore.genelAd).order(by: Z.Firestore.gun).addSnapshotListener{ (QuerySnapshot, error) in
            
            self.mesajlar = []
            
            if let e = error {
                print("There wa an issue retrieving data from Firestore.\(e)")
                
            }else{
                if let snapshotDocuments = QuerySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let mesajSender = data[Z.Firestore.sender] as? String, let mesaJBody = data[Z.Firestore.body] as? String {
                            let yeniMesaj = Mesajlar (sender: mesajSender, body: mesaJBody)
                            self.mesajlar.append(yeniMesaj)
                          
                            DispatchQueue.main.async {
                                self.mesajTableView.register(UINib(nibName: Z.hücreNibAdi, bundle: nil), forCellReuseIdentifier: Z.hücreAdi)
                                self.mesajTableView.dataSource = self
                                self.mesajTableView.delegate = self
                                self.mesajTableView.reloadData()
                                let indexPath = IndexPath (row: self.mesajlar.count - 1, section: 0)
                                self.mesajTableView.scrollToRow(at: indexPath, at: .top, animated: false)
                                
                            }
                        }
                    }
                }
           
            }
        }
        
    }
                  
        
           

        @IBAction func gonderButonu2(_ sender: UIButton) {
        
        if let MesajlarBody = self.mesajTextfield.text, let MesajlarSender = Auth.auth().currentUser?.email {
            db.collection(Z.Firestore.genelAd).addDocument(data: [Z.Firestore.sender: MesajlarSender, Z.Firestore.body:MesajlarBody, Z.Firestore.gun: Date().timeIntervalSince1970 ] )
            { (error) in
                if let e=error {
                    print("There was an issue saving data to firestore,\(e)")
                }else{
                    print("Successfully saved data.")
                    
                    DispatchQueue.main.async {
                        self.mesajTextfield.text = ""
                    }
                }
                
            }
            
        }
    }
    @IBAction func cikisButonu2(_ sender: UIBarButtonItem) {
        do{
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
            
        }catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        
    }
        
    }
        extension MesajViewController: UITableViewDataSource, UITableViewDelegate {
                
                func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                    print(mesajlar.count)
                       return mesajlar.count
                   }

                func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                    let mesaj = mesajlar[indexPath.row]
                    let hücre = tableView.dequeueReusableCell(withIdentifier: Z.hücreAdi, for: indexPath) as! MesajCell
                  
                    hücre.label.text = mesaj.body
                    
                    if mesaj.sender == Auth.auth().currentUser?.email {
                        hücre.solIcon.isHidden = true
                        hücre.sagIcon.isHidden = false
                        hücre.iletiBalonu.backgroundColor = UIColor(named: Z.mesajColors.lightPurple)
                        hücre.label.textColor = UIColor(named: Z.mesajColors.purple)
                    }
                    //This is a message from another sender.
                    else {
                        hücre.solIcon.isHidden = false
                        hücre.sagIcon.isHidden = true
                        hücre.iletiBalonu.backgroundColor = UIColor(named: Z.mesajColors.purple)
                        hücre.label.textColor = UIColor(named:Z.mesajColors.lightPurple)
                    }
                    
                  
                  
                    return hücre
                }
        }


            
            
    
     

