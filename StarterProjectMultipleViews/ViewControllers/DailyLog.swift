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


