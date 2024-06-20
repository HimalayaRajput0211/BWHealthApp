//
//  HKDataItem.swift
//  BWHealthApp
//
//  Created by Himalaya Rajput on 19/06/24.
//

import Foundation


struct HKDataItem: Identifiable, Hashable {
    let id = UUID().uuidString
    let type: HKDataItemType
    let time: String
    let value: String
}
