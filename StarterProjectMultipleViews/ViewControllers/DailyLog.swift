//
//  DailyLog.swift
//  StarterProjectMultipleViews
//
//  Created by Jessie on 2/3/2026.
//

import Foundation
import UIKit

class DailyLog: UIViewController {
    
    // MARK: - IBOutlets
    
    
    @IBOutlet weak var DateToday: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    

    // MARK: - Variables and Constants
    var chosenDate:Date?
    var entriesForDate: [aSingleLogEntry] = []
    
    
    
    // MARK: - IBActions and Functions



    @IBAction func dayBefore(_ sender: UIButton) {
        guard let currentDate = chosenDate else {return}
        let newDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)
        // new date is teh new constant, and then u use the date ability to -1 to the original date
        chosenDate = newDate
        // u set teh date that will be displayed as the new date
        displayData()
        loadEntries()
            
    }
    
    
    @IBAction func dayAfter(_ sender: UIButton) {
        guard let currentDate = chosenDate else {return}
        let newDate = Calendar.current.date(byAdding: .day, value: +1, to: currentDate)
        // same thing the most improtant part is that u chose to add to day by -1, which means u are subtracting 1 for the current date
        chosenDate = newDate
        // same thing u set a new date
        displayData()
        loadEntries()
    }
    
    
    func setUpdatatable(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func displayData(){
        guard let date = chosenDate else {return}
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        DateToday.text = formatter.string(from: date)
    }
    
    func loadEntries(){
        guard let date = chosenDate else {return}
        let calendar = Calendar.current
        // calender is teh constant and there is a function that is called calendar that allows us to access the calendar date as of right now. current gives us the current date
        entriesForDate = storeData.entries.filter{entry in
            calendar.isDate(entry.date, inSameDayAs: date)}
        entriesForDate.sort { $0.date > $1.date }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpdatatable()
        displayData()
        loadEntries()
        // Do any additional setup after loading the view.
    }
    

}
extension DailyLog: UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return entriesForDate.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // dequeueReusableCell reuses cells idk how - pls check later
        let entry = entriesForDate[indexPath.row]
        
        let dateFormat = DateFormatter()
        // dateformatter is prebuilt way to call for dates
        dateFormat.dateStyle = .medium
        // .medium gives a format similar to month in simplified form like march->mar January-> jan and then the date and then the year like Mar 21,2026
        dateFormat.timeStyle = .none
        // we dont wnat the time stamp thereforem the time is ,none
        let dateString = dateFormat.string(from: entry.date)
        var timeString = ""
        if entry.hours > 0 {
            timeString += "\(entry.hours) hour\(entry.hours == 1 ? "" : "s")"
            // if hours is bigger than 0 you show x aomunt of hours
        }
        if entry.minutes > 0{
            timeString += "\(entry.minutes) minutes\(entry.minutes == 1 ? "" : "s")"
            // if minutes is larger than 0 you show x amount of minutes
        }
        if entry.hours == 0 && entry.minutes == 0 {
            timeString = "0 minutes"
            // if no hours nor miuntes u show 0, shouldnt show that but sure
        }
        cell.textLabel?.text = "\(dateString): \(timeString)"
        // the cell text will combine teh date in teh date string, with the time string which is how many minutes or hours to be placed in every cell.
        return cell
    }
}
extension DailyLog: UITableViewDelegate {
    // You can implement didSelectRowAt if needed
}
// learn how to use date picker

