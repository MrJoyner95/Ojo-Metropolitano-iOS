//
//  CustomCell.swift
//  Ojo-Metropolitano-1.0
//
//  Created by Jesus Reynaga Rodriguez on 05/09/17.
//  Copyright © 2017 Silicon Bear. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var parentesco: UILabel!
    @IBOutlet weak var usuario: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imagen.layer.cornerRadius = imagen.frame.size.width/2
        imagen.clipsToBounds = true
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
