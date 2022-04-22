//
//  MesajCell.swift
//  MessageApp
//
//  Created by Aleyna on 9.03.2022.
//

import UIKit

class MesajCell: UITableViewCell {

    @IBOutlet weak var iletiBalonu: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var sagIcon: UIImageView!
    @IBOutlet weak var solIcon: UIImageView!

    
    
    override func awakeFromNib(){
        super.awakeFromNib()
        // radius //
        iletiBalonu.layer.cornerRadius = iletiBalonu.frame.size.height / 5
        label.layer.cornerRadius = label.frame.size.height / 5
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
