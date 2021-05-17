
//
//  ImageVC.swift
//  Gallery
//
//  Created by COMP47390 on 09/03/2021.
//  Copyright © 2021 COMP47390. All rights reserved.
//

import UIKit

class ImageVC: UIViewController, UIScrollViewDelegate {
    // MARK: - Outlets
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = imageView.frame.size
            scrollView.delegate = self
        }
    }
    // MARK: - Private properties
    private var imageView = UIImageView()
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            imageView.frame = CGRect(origin: CGPoint.zero, size: imageView.frame.size)
            scrollView?.contentSize = imageView.frame.size
            scrollView?.minimumZoomScale = min(0.2, scrollView.bounds.size.width / scrollView.contentSize.width)
            scrollView?.maximumZoomScale = 1.0
            scrollView?.zoomScale = scrollView.maximumZoomScale
            spinner?.stopAnimating()
        }
    }
    // MARK: - Data model
    open var imageURL: URL? {
        didSet {
            image = nil
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    // MARK: - Multithreaded pattern
    private func fetchImage() {
        if let url = imageURL {
            spinner?.startAnimating()
            DispatchQueue.global(qos: .background).async {
                Thread.sleep(forTimeInterval: 2)
                let imageData = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if imageData != nil  {
                        self.image = UIImage(data: imageData!)
                    } else {
                        self.image = nil
                    }
                }
            }
        }
    }
    
    // MARK: - UIScrollViewDelegate
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    // MARK: - VC lifecylcle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.addSubview(imageView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {
            fetchImage()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


