//
//  LoadingView.swift
//  LiveCapturingApp
//
//  Created by A on 2020/11/28.
//

import UIKit

class LoadingView: UIView {

    @IBOutlet weak var omgImageView: UIImageView!
     @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var labelImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initXIB()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initXIB()
    }
    
    func initXIB() {
        guard let view = Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)?.first as? UIView else {
            return
        }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func startAnimation() {
        let originalTransform = self.transform
        let translatedTransform = originalTransform.translatedBy(x: 30.0, y: 0.0)
        UIView.animate(withDuration: 0.8, delay: 0.2, options: [.repeat, .autoreverse], animations: {
            self.transform = translatedTransform
        })
    }
}
