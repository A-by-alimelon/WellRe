//
//  MainViewController.swift
//  LiveCapturingApp
//
//  Created by A on 2020/10/17.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var mainImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        mainImage.addGestureRecognizer(tapGestureRecognizer)

    }
    
    @objc private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        if let videoViewController = storyboard?.instantiateViewController(identifier: "VideoViewController") {
            videoViewController.modalTransitionStyle = .coverVertical
            present(videoViewController, animated: true, completion: nil)
        }
        print("touched")
        
    }

    

}
