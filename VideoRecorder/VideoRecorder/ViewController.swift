//
//  ViewController.swift
//  VideoRecorder
//
//  Created by Paul Solt on 10/2/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		// TODO: get permission
		requestPermissionAndShowCamera()
	}
    
    private func requestPermissionAndShowCamera() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            // request permission
            requestVideoPermission()
        case .restricted:
            // recording video was disabled via restrictions
            preconditionFailure("Video is diasbled please review video restrictions")
        case .denied:
            //user denied permission
            preconditionFailure("Cannot use app without giving permission via settings > privacy > video")
        case .authorized:
            showCamera()
        @unknown default:
            preconditionFailure("A new status code was added that we need to handle")
        }
    }
	
    private func requestVideoPermission() {
        AVCaptureDevice.requestAccess(for: .video) { (isGranted) in
            guard isGranted else {
                preconditionFailure("Tell user to enable permissions for video/camera")
            }
            
            DispatchQueue.main.async {
                self.showCamera()
            }
            
        }
    }
    
	private func showCamera() {
		performSegue(withIdentifier: "ShowCamera", sender: self)
	}
}
