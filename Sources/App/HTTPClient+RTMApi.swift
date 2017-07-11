//
//  HTTPClient+RTMApi.swift
//  slackbot
//
//  Created by Johann Kerr on 7/10/17.
//
//

import Foundation
import HTTP
import Vapor



extension Bool {
    fileprivate var queryInt: Int {
        // slack uses 1 / 0 in their demo
        return self ? 1 : 0
    }
}
