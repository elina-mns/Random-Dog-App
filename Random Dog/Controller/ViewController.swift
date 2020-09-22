//
//  ViewController.swift
//  Random Dog
//
//  Created by Elina Mansurova on 2020-09-21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var breeds: [String] = []
    
    var selectedRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        pickerView.dataSource = self
        pickerView.delegate = self
        
        DogAPI.requestBreedsList(completionHandler: handleBreedsListResponse(breeds:error:))
    }
    
    @IBAction func reload(_ sender: Any) {
        guard let selectedRow = selectedRow else {
            return
        }
        reload(row: selectedRow)
    }
    
    private func reload(row: Int) {
        DogAPI.requestRandomImage(breed: breeds[row], completionHandler: { (dogImage, error) in
            guard let dogImage = dogImage else {
                return
            }
            let objectURL = URL(string: dogImage.message)!
            DogAPI.requestImageFile(url: objectURL, completionHandler: self.handleImageFileResponse(image:error:))
        })
    }
    
    func handleImageFileResponse(image: UIImage?, error: Error?) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    
    func handleBreedsListResponse(breeds: [String], error: Error?) {
        self.breeds = breeds
        DispatchQueue.main.async {
            self.pickerView.reloadAllComponents()
        }
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        reload(row: row)
        selectedRow = row
    }
}


