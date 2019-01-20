//
//  System.swift
//  PalmList
//
//  Created by Timothy Waters on 1/19/19.
//  Copyright © 2019 Timmy Waters Software. All rights reserved.
//

import Foundation
import UIKit

struct System {
    static func clearNavigationBar(forBar navBar: UINavigationBar) {
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = true
    }
}
