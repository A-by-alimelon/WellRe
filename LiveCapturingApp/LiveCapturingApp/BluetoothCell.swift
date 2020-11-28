//
//  BluetoothCell.swift
//  LiveCapturingApp
//
//  Created by A on 2020/11/01.
//

import UIKit

class BluetoothCell: UITableViewCell {


    @IBOutlet weak var signalLabel: UILabel!
    @IBOutlet weak var UUIDLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
  
    }

}
