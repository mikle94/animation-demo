//
//  Utils.swift
//  Umzugscoach
//
//  Created by Mikle Kusmenko on 10/23/17.
//  Copyright © 2017 mk. All rights reserved.
//

import Foundation

func delay(_ seconds: Double, completion: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        completion()
    }
}
