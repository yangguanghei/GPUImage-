//
//  ViewController.swift
//  其他滤镜
//
//  Created by 梁森 on 2020/6/10.
//  Copyright © 2020 梁森. All rights reserved.
//

import UIKit

import GPUImage

class ViewController: UIViewController {
    @IBOutlet weak var picture: UIImageView!
    
    fileprivate var image = UIImage(named: "杨幂.jpeg")
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func heshe(_ sender: Any) {
        let filter = GPUImageSepiaFilter()
        
        picture.image = processImage(filter: filter)
    }
    
    @IBAction func katong(_ sender: Any) {
        let filter = GPUImageToonFilter()
        picture.image = processImage(filter: filter)
    }
    @IBAction func sumiao(_ sender: Any) {
        let filter = GPUImageSketchFilter()
        picture.image = processImage(filter: filter)
    }
    @IBAction func fudiao(_ sender: Any) {
        let filter = GPUImageEmbossFilter()
        picture.image = processImage(filter: filter)
    }
    
    func processImage(filter:GPUImageFilter) -> UIImage {
        let picProcess = GPUImagePicture(image: image)
        picProcess?.addTarget(filter)
        filter.useNextFrameForImageCapture()
        picProcess?.processImage()
        return filter.imageFromCurrentFramebuffer()
    }
    
}

