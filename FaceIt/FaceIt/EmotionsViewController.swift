//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by Kelvin Leung on 13/07/2017.
//  Copyright © 2017 Kelvin Leung. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {
    
    //  helper dic
    private let emotionalFaces: Dictionary<String, FacialExpression> = [
        "sad": FacialExpression(eyes: .closed, mouth: .frown),
        "happy": FacialExpression(eyes: .open, mouth: .smile),
        "worried": FacialExpression(eyes: .open, mouth: .smirk)
    ]

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination
        //  cast the destination vc to the "real" dest vc
        if let faceViewController = destinationViewController as? FaceViewController {
            //  figure out what segue it is
            if let identifier = segue.identifier {
                if let expression = emotionalFaces[identifier] {
                    faceViewController.expression = expression
                }
            }
        }
    }

}
