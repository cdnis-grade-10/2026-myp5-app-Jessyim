//
//  Storage.swift
//  StarterProjectMultipleViews
//
//  Created by Jessie on 4/3/2026.
//

import Foundation

import UIKit


struct previousData{
    static var nameOfActivity : String = ""
    static var hourtimeofDate : String = ""
    static var minutestimeofDate : String = ""
    static var latestDate : String = ""
}

struct aSingleLogEntry: Codable {
    // codable is a protocol taht allows the following code to be transformed into a JSON format or back into a struct, therefore u can use JSON below
    let activity: String
    let date: Date
    let hours: Int
    let minutes: Int
    var reflection: String 
    //purely used to stored the data in a good structure to call for the table format easier
}

struct storeData{
    static var entries: [aSingleLogEntry] = []
    // stored data variable with all the enteries of the data inclyding teh stuff above
    static func saveData(){
        // each set of the data will be stored within a JSON data array???
        if let encoded = try? JSONEncoder().encode(entries) {
            // JSONEncoder is like converting the data into raw bytes
            // the abvoe tries to change the array to a Data object
            // try? ensures that worse case scenario it outputs nil and not error messages
            UserDefaults.standard.set(encoded, forKey: "logEntries")
            //encoded is a data object withe the data from teh array already stored in logEntries
        }
    }
    static func loadEntries() {
        // 1. Attempt to fetch data for the key "logEntries".
        if let data = UserDefaults.standard.data(forKey: "logEntries"),
               // 2. Decode the data back into an array of LogEntry.
            let decoded = try? JSONDecoder().decode([aSingleLogEntry].self, from: data) {
                // 3. Assign the decoded array to our static property.
            entries = decoded
            }
        }
}

