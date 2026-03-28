//
//  data.swift
//  StarterProjectMultipleViews
//
//  Created by Jessie on 28/3/2026.
//
import Foundation

struct dataPoint: Identifiable{
    var id = UUID().uuidString
    var day: String
    var hours : Int
}
