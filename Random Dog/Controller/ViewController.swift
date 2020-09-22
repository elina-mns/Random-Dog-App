//
//  ViewController.swift
//  Random Dog
//
//  Created by Elina Mansurova on 2020-09-21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reload(self)
    }
    
    @IBAction func reload(_ sender: Any) {
        DogAPI.requestRandomImage(completionHandler: { (dogImage, error) in
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
}


