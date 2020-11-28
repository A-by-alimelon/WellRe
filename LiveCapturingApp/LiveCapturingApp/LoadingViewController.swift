//
//  LoadingViewController.swift
//  LiveCapturingApp
//
//  Created by A on 2020/11/28.
//

import UIKit
import Firebase

class LoadingViewController: UIViewController {
  
    private var loadingView: LoadingView?
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLoadingView()
        checkServer()
        
    }
    
    func setLoadingView() {
        let loadingViewFrame = CGRect(x: 0, y: 0, width: 280, height: 380)
        loadingView = LoadingView(frame: loadingViewFrame)
        guard let loading = loadingView else {
            return
        }
        loading.center = self.view.center
        loading.startAnimation()
        self.view.addSubview(loading)
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
