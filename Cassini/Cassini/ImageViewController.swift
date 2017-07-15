//
//  ImageViewController.swift
//  Cassini
//
//  Created by Kelvin Leung on 14/07/2017.
//  Copyright © 2017 Kelvin Leung. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            //  set the delegate to the current view controller
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.01
            scrollView.maximumZoomScale = 3.0
            scrollView.contentSize = imageView.frame.size
            scrollView.addSubview(imageView)
        }
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //  will be set by segue
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
            //  start spinning when fetching
            spinner.startAnimating()
            //  Data() will throw error, need to "try"
            //  init(contentsOf: URL, options: Data.ReadingOptions)
            //  Creates a data buffer with the contents of a URL.
            //  self is captured by the closure, tag "weak" to release it
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                //  if multiple fetch happens, check if url is the current one
                if let imageData = urlContents, url == self?.imageURL {
                    //  all UI operation should happen in the main Q
                    DispatchQueue.main.async {
                        self?.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
    
    //  make it accessible within the "file"
    fileprivate var imageView = UIImageView()
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            //  whenever imageView.image is set, rescale the contentSize
            //  use optional chaining, scrollView may not be available yet
            scrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //  fetch only when image is nil
        if image == nil {
            fetchImage()
        }
    }
}

//  use extension to conform to UIScrollViewDelegate
extension ImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
