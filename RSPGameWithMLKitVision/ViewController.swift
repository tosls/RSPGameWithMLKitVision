//
//  ViewController.swift
//  RSPGameWithMLKitVision
//
//  Created by Антон Бобрышев on 01.09.2021.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    
    @IBAction func fetchFromCamera(_ sender: UIButton) {
    }
    
    @IBAction func fetchFromGallery(_ sender: UIButton) {
    }
    
    @IBAction func fetchFromLiveRecording(_ sender: UIButton) {
    }
    
    private func setupView() {
        
        imageView.layer.cornerRadius = 5
        resultLabel.layer.masksToBounds = true
        resultLabel.layer.cornerRadius = 5
    }
    

}

