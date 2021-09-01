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
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    @IBAction func fetchFromGallery(_ sender: UIButton) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    private func setupView() {
        
        imageView.layer.cornerRadius = 5
        resultLabel.layer.masksToBounds = true
        resultLabel.layer.cornerRadius = 5
    }
}

extension ViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var imageToSave: UIImage?
        
        if let editedImage = info[.editedImage] as? UIImage {
            imageToSave  = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            imageToSave = originalImage
        }
        imageView.image = imageToSave
        resultLabel.text = "test"
        dismiss(animated: true)
    }
}
