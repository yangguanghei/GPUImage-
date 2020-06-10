//
//  ViewController.swift
//  GPUImage的使用
//
//  Created by 梁森 on 2020/6/7.
//  Copyright © 2020 梁森. All rights reserved.
//

import UIKit

import GPUImage

class ViewController: UIViewController {

   
    @IBOutlet weak var picture: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func mohuAction(_ sender: Any) {
        
        let sourceImage = UIImage(named: "杨幂.jpeg")
        let picProcess = GPUImagePicture(image: sourceImage)
        let blurFilter = GPUImageGaussianBlurFilter()
        blurFilter.texelSpacingMultiplier = 5
        blurFilter.blurRadiusInPixels = 5
        picProcess?.addTarget(blurFilter)
        blurFilter.useNextFrameForImageCapture()
        picProcess?.processImage()
        picture.image = blurFilter.imageFromCurrentFramebuffer()
        
    }
}

