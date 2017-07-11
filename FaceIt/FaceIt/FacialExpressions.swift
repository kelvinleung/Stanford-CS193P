//
//  FacialExpressions.swift
//  FaceIt
//
//  Created by Kelvin Leung on 11/07/2017.
//  Copyright © 2017 Kelvin Leung. All rights reserved.
//

import Foundation

struct FacialExpression {
    enum Eyes: Int {
        case open
        case closed
        case squinting
    }
    
    enum Mouth: Int {
        case frown
        case smirk
        case neutral
        case grin
        case smile
    }
    
    let eyes: Eyes
    let mouth: Mouth
}
