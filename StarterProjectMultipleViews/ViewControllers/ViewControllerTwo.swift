/*
 
 ViewControllerTwo.swift
 
 This file will contain the code for the second viewcontroller.
 Please ensure that your code is organised and is easy to read.
 This means that you will need to both structure your code correctly,
 in addition to using the correct syntax for Swift.
 
 Unless you are told otherwise, ensure that you are using the
 camelCase syntax. For example, outputLabel and firstName are good
 examples of using the camelCase syntax.
 
 Within each class, you can see clearly identified sections denoted by
 MARK statements. These MARK statements allow you to structure and organise
 your code.
 
 - @IBOutlets should be listed under the MARK section on IBOutlets
 - Variables and constants listed under the MARK section Variables and Constants
 - Functions (including @IBActions) listed under the section on IBActions and Functions.
 
 As you develop each view controller class with Swift code, please include
 detailed comments to both demonstrate understanding, and which serve you as
 a reminder as to what your code actually does.
 
 */

import UIKit
import Charts
import SwiftUI

struct WeeklyBarChart: View{
    let data: [dataPoint]
    
    // this is teh sample data
    
    var body: some View{
        Chart{
            ForEach (data){ d in
                BarMark(x: .value("Day",d.day), y: .value("Hours",d.hours))
                // using barmark to make bar graphs.
                .foregroundStyle(Color.blue.gradient)
            }
            
        }
        .chartYAxisLabel("Hours")
        // this is the y axis the number of hours
        .chartXAxisLabel("Day of Week")
        // x axis is the day of the week
        .frame(height: 300)
        
        .padding()
        
    }
    
}





class ViewControllerTwo: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var ActivityName: UILabel!
    
    @IBOutlet weak var scrollingTableView: UITableView!
    
    @IBOutlet weak var chartContainerView: UIView!
    
    
    
    // MARK: - Variables and Constants
    
    var displayedEntries: [aSingleLogEntry] = []
// this is a filtered array that only contains the logs belonging to a single activity

    private var hostingController: UIHostingController<WeeklyBarChart>?
    private let sampleData = [
        dataPoint(day: "Mon", hours: 2),
        dataPoint(day: "Tue", hours: 3),
        dataPoint(day: "Wed", hours: 1),
        dataPoint(day: "Thur", hours: 3),
        dataPoint(day: "Fri", hours: 1),
        dataPoint(day: "Sat", hours: 2),
        dataPoint(day: "Sun", hours: 1)
    ]

    
    
    // MARK: - IBActions and Functions
    
    
    private func setUpChart(){
        let chartView = WeeklyBarChart(data:sampleData)
        hostingController = UIHostingController(rootView: chartView)
        guard let hostingView = hostingController?.view else {return}
        hostingView.translatesAutoresizingMaskIntoConstraints = false
            chartContainerView.addSubview(hostingView)
        
        NSLayoutConstraint.activate([
                hostingView.topAnchor.constraint(equalTo: chartContainerView.topAnchor),
                hostingView.bottomAnchor.constraint(equalTo: chartContainerView.bottomAnchor),
                hostingView.leadingAnchor.constraint(equalTo: chartContainerView.leadingAnchor),
                hostingView.trailingAnchor.constraint(equalTo: chartContainerView.trailingAnchor)
            ])
    }
    private func updateChart() {
        hostingController?.rootView = WeeklyBarChart(data: sampleData)
    }

    
    func activityLabel(){
        let selectedActivityName = previousData.nameOfActivity
        // very easy to understand its calling teh data from storage file
        ActivityName.text = selectedActivityName
        // the data is printed out to the text
    }
    
    func refreshData(){
        let selectedActivityName = previousData.nameOfActivity
        // repeating ab ove so the data can be seen in thsi function
        displayedEntries = storeData.entries.filter { $0.activity == selectedActivityName }
        //storeData.entries ensures only related data is actually stroed
        displayedEntries.sort { $0.date > $1.date }
        //date > ensures the most recent date goes at teh top
    }
        
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedEntries.count
        // the number of rows that are shwoed (numberofrows insection) is the amount of entries that you cant count in teh displayed entries
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // dequeueReusableCell reuses cells idk how - pls check later
        let entry = displayedEntries[indexPath.row]
        
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
    
    func tableView(_ tableView:UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedEntry = displayedEntries[indexPath.row]
        performSegue(withIdentifier: "showDailyLog", sender: selectedEntry.date)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any?){
        if segue.identifier == "showDailyLog",
           let destination = segue.destination as? DailyLog,
           let date = sender as? Date{
            destination.chosenDate = date
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityLabel()
        // when the screen loads the acitivity label will load first
        
        scrollingTableView.dataSource = self
        scrollingTableView.delegate = self
        scrollingTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        setUpChart()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()
        // all data is refreshed :) 
        scrollingTableView.reloadData()
    }

}
