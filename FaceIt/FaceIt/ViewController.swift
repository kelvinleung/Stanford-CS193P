//
//  ViewController.swift
//  FaceIt
//
//  Created by Kelvin Leung on 10/07/2017.
//  Copyright © 2017 Kelvin Leung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            updateUI()
        }
    }
    
    //  might be excuted before faceView wired up
    var expression = FacialExpression(eyes: .open, mouth: .grin) {
        didSet {
            updateUI()
        }
    }
    
    private let mouthCurvatures = [
        FacialExpression.Mouth.frown: -1.0,
        .smirk: -0.5,
        .neutral: 0.0,
        .grin: 0.5,
        .smile: 1.0
    ]
    
    private func updateUI() {
        
        switch expression.eyes {
        case .open:
            //  just in case updateUI() excutes before faceView initialized
            faceView?.eyesOpen = true
        case .closed:
            faceView?.eyesOpen = false
        case .squinting:
            faceView?.eyesOpen = false
        }
        
        faceView?.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
    }
    
}
