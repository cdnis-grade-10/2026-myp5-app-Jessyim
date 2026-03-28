//
//  LogData.swift
//  StarterProjectMultipleViews
//
//  Created by Jessie on 28/3/2026.
//

import Foundation

struct logEntry{
    var iD = UUID().uuidString
    let activity: String
    let date: Date
    let duration: TimeInterval
// this is the same concept as storage folder but used for the faked data groupi to show how the graphs work
}

struct logStore{
    static var entries: [logEntry] = []
    // this calls for all log entries ever logged in
    static func addEntry(activity:String, duration:TimeInterval){
        // this is to add new entry in format of the activity and duration
        let newEntry = logEntry(activity: activity, date: Date(), duration: duration)
        entries.append(newEntry)
        // saving the data
    }
    
    static func loadFakeData (){
        //this set of data being loaded is just to display the functions of the graphs and how it would look like with sufficient data, as the data updates everytime the app is rebuilt.
        let calendar = Calendar.current
        // same thing call for the date as calander format from today
        let today = Date()
        // ask for the date of today
        let formatter = DateFormatter()
        // date is reformated
        formatter.dateFormat = "yyyy-MM-dd"
        // this is tehfromat of the new date
        
        let fakeActivities = ["Creativity", "Activity", "Service"]
        // they are in one of the 3 categories as mentioned below
        for daysAgo in 0...6{
            let date = calendar.date(byAdding: .day, value: -daysAgo, to: today)!
            // Each day add 1–3 random entries with no reflection tho, so the data wont show well on daily log page
            let entryCount = Int.random(in: 1...3)
            for _ in 0..<entryCount{
                let activity = fakeActivities.randomElement()!
                // its a random activity from the list of 3 different choices above
                let duration = Double.random(in: 1800...7200)
                // a number between 18000 - 72000 which is eithter 30 minutes to 2 hours
                entries.append(logEntry(activity: activity, date: date, duration: duration))
                // tell them the each entry is the date, activity and then duration
            }
        }
        entries.sort { $0.date < $1.date }
        // sorts date from latest to the oldest one
    }
    
    static func weeklyTotals() -> [Double] {
        let calendar = Calendar.current
        // same again...
        let today = calendar.startOfDay(for: Date())
        // this asks for the date to be the dateof today
        var weekDays: [Date] = []
        for i in 0...6 {
            if let date = calendar.date(byAdding: .day, value: -i, to: today) {
                weekDays.append(date)
            }
            // Get total hours per day adding all the differnt times for the last 7 days, including latest date today
        }
        weekDays.reverse()
        
        var total:[Double] = []
        for day in weekDays {
            let dayStart = calendar.startOfDay(for: day)
            let dayEnd = calendar.date(byAdding: .day,value: 1, to: dayStart)!
            let entriesForDay = entries.filter { $0.date >= dayStart && $0.date < dayEnd }
            let totalSeconds = entriesForDay.reduce(0) { $0 + $1.duration }
                        let totalHours = totalSeconds / 3600.0
                        total.append(totalHours)
            
        }
        return total
    
    }
    


}

    
