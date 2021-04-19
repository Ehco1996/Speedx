//
//  Subscription.swift
//  SpeedX (iOS)
//
//  Created by ehco on 2021/4/18.
//

import Foundation

struct Subscription: Identifiable, Codable {
    let id: Int
    var remark: String
    var url: String
    var createdAt: Date
    var updatedAt: Date
}
