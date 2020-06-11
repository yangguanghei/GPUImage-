//
//  ViewController.swift
//  美颜相机-GPUImage
//
//  Created by 中创 on 2020/6/11.
//  Copyright © 2020 梁森. All rights reserved.
//

import UIKit

import GPUImage

class ViewController: UIViewController {

    lazy var camera:GPUImageStillCamera = {
        let camera = GPUImageStillCamera(sessionPreset: AVCaptureSession.Preset.high.rawValue, cameraPosition: .front)
        camera?.outputImageOrientation = .portrait
        return camera!
    }()
    lazy var filter:GPUImageBrightnessFilter = {
        let filter = GPUImageBrightnessFilter()
//        filter.brightness = 0.4
        return filter
    }()
    lazy var showView:GPUImageView = {[weak self] in
        let showView = GPUImageView(frame: self!.view.bounds)
        return showView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .green
        
        let btn  = UIButton(frame: CGRect(x: 100, y: 100, width: 50, height: 50))
        btn.setTitle("拍照", for: .normal)
        btn.addTarget(self, action: #selector(takePhoto), for: .touchUpInside)
        self.view.addSubview(btn)
        
        camera.addTarget(filter)
        filter.addTarget(showView)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.insertSubview(showView, at: 0)
        camera.startCapture()
    }
    
    @objc func takePhoto(){
        camera.capturePhotoAsImageProcessedUp(toFilter: filter) { (img, error) in
            UIImageWriteToSavedPhotosAlbum(img!, nil, nil, nil)
            self.camera.stopCapture()
            self.showView.removeFromSuperview()
        }
    }

}

