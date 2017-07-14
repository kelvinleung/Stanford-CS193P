//
//  ImageViewController.swift
//  Cassini
//
//  Created by Kelvin Leung on 14/07/2017.
//  Copyright © 2017 Kelvin Leung. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    var imageURL: URL? {
        didSet {
            image = nil
            //  fetch only when window is nil, aka not yet on screen
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    private func fetchImage() {
        if let url = imageURL {
            //  Data() will throw error, need to 'try'
            //  init(contentsOf: URL, options: Data.ReadingOptions)
            //  Creates a data buffer with the contents of a URL.
            let urlContents = try? Data(contentsOf: url)
            if let imageData = urlContents {
                image = UIImage(data: imageData)
            }
        }
    }
    
    private var imageView = UIImageView()
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        imageURL = DemoURL.stanford
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //  fetch only when image is nil
        if image == nil {
            fetchImage()
        }
    }

}
