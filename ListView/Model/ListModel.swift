//
//  ListModel.swift
//  ListView
//
//  Created by Vinoth Varatharajan on 10/02/2020.
//  Copyright © 2020 Vin. All rights reserved.
//

import UIKit

// MARK: - ListData
struct listData : Codable {
    var data    : [listObj]
}

// MARK: - ListData
struct listObj : Codable {
    var id      : String
    var name    : String
}
