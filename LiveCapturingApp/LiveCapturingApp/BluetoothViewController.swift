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
    let ref = Database.database().reference()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let post : [String: String] = ["hasLabel": hasLabel]
        
        ref.child("pet").setValue(post)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if hasLabel == "label" {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "LoadingViewController")
            self.present(VC!, animated: true, completion: nil)
        }
        checkServer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        hasLabel = "none"
        let post2 = ["hasLabel": hasLabel]
        ref.child("pet").setValue(post2)
        print("done")
    }
    
    func checkServer() {
        ref.child("end").observe(DataEventType.value) { (snapshot) in
            let value = snapshot.value
            print(value as! String)
            if value as! String == "finish" {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
  
}


    

