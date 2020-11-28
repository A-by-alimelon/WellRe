//
//  BluetoothViewController.swift
//  LiveCapturingApp
//
//  Created by A on 2020/10/25.
//

import UIKit
import Firebase
import FirebaseDatabase


class BluetoothViewController: UIViewController {
    var hasLabel = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = Database.database().reference()
        let post : [String: String] = ["hasLabel": hasLabel]
        ref.child("pet").setValue(post)
 
    }
    
  
}


    

