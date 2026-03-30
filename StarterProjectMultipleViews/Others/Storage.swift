//
//  Storage.swift
//  StarterProjectMultipleViews
//
//  Created by Jessie on 4/3/2026.
//

import Foundation

import UIKit


struct previousData{
    //this structure stores the data that is needed to be used in view controller 2 and daily log where we need to see the minutes, hours, and name of activity, as well as the latest date together in a single cell
    static var nameOfActivity : String = ""
    //  stores the name of the activity namingly eitehr creativity, activity or service as a string
    static var hourtimeofDate : String = ""
    //stores the logged hours that is generated from teh timer function
    static var minutestimeofDate : String = ""
    // minutes also logged from the timer, but as a remainder from the hour
    static var latestDate : String = ""
    //stores the latest date which is usually the date of the logging of time usually "today"
}

struct dataPoint: Identifiable{
    // identifiable is a protocol that NEEDS an id as seen bellow, so each data point is seperately identified with a different ID
    var id = UUID().uuidString
    // a unique ID
    var day: String
    // the day of the week from Mon - SUn
    var hours : Int
    // as an integer how many hours logged in
}

struct aSingleLogEntry: Codable {
    // codable is a protocol taht allows the following code to be transformed into a JSON format or back into a struct, therefore u can use JSON below
    let activity: String
    // name of activity
    let date: Date
    // date of the logged hours
    let hours: Int
    let minutes: Int
    var reflection: String
    // from the text field, whatever they wrote there
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
        // raw data is retrived from using an unique key
        if let data = UserDefaults.standard.data(forKey: "logEntries"),
               // converts the JSON data back into a swift array
            let decoded = try? JSONDecoder().decode([aSingleLogEntry].self, from: data) {
                // assign the decoded array to our static property.
            entries = decoded
            }
        }
}

