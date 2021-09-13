//
//  ViewController.swift
//  RSPGameWithMLKitVision
//
//  Created by Антон Бобрышев on 01.09.2021.
//

import UIKit
import MLKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var aiSign: UILabel!
    
    var imageLabeler: ImageLabeler?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeModel()
        setupView()
    }
    
    // For tests
    @IBAction func testButton(_ sender: UIButton) {
        let aiSignChoice = AISign.shared.aiRandomChoice()
        aiSign.text = aiSignChoice.emojiSign
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
    
    func initializeModel() {
        
        guard let manifestPath = Bundle.main.path(forResource: "tflite_metadata", ofType: "json", inDirectory: "rspModel") else {
            print("Couldn't find file")
            return
        }
//        let localModel = AutoMLLocalModel(manifestPath: manifestPath)
        guard let localModel = LocalModel(manifestPath: manifestPath) else { return }
        print("2323")
//        let labelerOptions = VisionOnDeviceAutoMLImageLabelerOptions(localModel: localModel)
        let labelerOptions = CustomImageLabelerOptions(localModel: localModel)
        labelerOptions.confidenceThreshold = 0.5
//        imageLabeler = Vision.vision().onDeviceAutoMLImageLabeler(options: labelerOptions)
        imageLabeler = ImageLabeler.imageLabeler(options: labelerOptions)
        print(imageLabeler)
        print("test 23")
    }
    
    func performMLOn(_ visionImage: VisionImage) {
        print("TestOne")
        imageLabeler?.process(visionImage, completion: {[weak self] (labels, error) in
            print("Test2")
            if let error = error {
                print(error.localizedDescription)
                return
//        imageLabeler?.process(visionImage, completion: { [weak self] (labels, error) in
            
            }
            print("Test Two")
            if let labels = labels {
                if labels.count == 0 {
                    self?.resultLabel.text = "Nothing"
                    return
                }
                for visionLabel in labels {
                    let confidenceString = String(format: "%0.2f", "Test3")
                    let labelText = visionLabel.text.trimmingCharacters(in: .whitespacesAndNewlines)
                    let resultString = "\(visionLabel.text) -- \(confidenceString)% confident"
                    print(resultString)
                    self?.resultLabel.text = resultString
                }
            }
        })
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
        
        guard imageToSave != nil else {
            print("not Image")
            return
        }
        let visionImage = VisionImage(image: imageToSave!)
        performMLOn(visionImage)
        
    }
}
