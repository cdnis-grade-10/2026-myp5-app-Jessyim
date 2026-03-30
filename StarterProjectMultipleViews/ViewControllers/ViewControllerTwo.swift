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
    // this is the view used seperately for the chart
    let data: [dataPoint]
    // accepts the chart data as an input of the data point
    
    var body: some View{
        // using the SwiftUI now :)
        // underneath is all the components/data needed for the chart
        Chart{
            ForEach (data){ d in
                // this is a loop. loop through every data point until each bar is created
                LineMark(x: .value("Day",d.day), y: .value("Hours",d.hours))
                // using linemark to make bar graphs.
                // linemark creates 1 point, so therefore we need to loop and connect teh points
                // the x axis shows teh day of the week so like the words MON TUE etc
                // y axis shows the hour
                    .foregroundStyle(Color(red: 0.0824, green: 0.0902, blue: 0.2392))
                // this is the color of the background so it is the same
            }
            
        }
        .chartYAxisLabel("Hours")
        // this is the y axis the number of hours
        .chartXAxisLabel("Day of Week")
        // x axis is the day of the week
        .frame(height: 250)
        .padding()
        // adds some space around the chart
        
    }
    
}




// this is now the 2nd view controller aLSO known as the dashboard
class ViewControllerTwo: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var ActivityName: UILabel!
    // this is the 2nd labal u see on the view controller, it says the acitivty that was pressed from the 1st page
    @IBOutlet weak var scrollingTableView: UITableView!
    // this is the table view at the bottom that shows the different cells
    @IBOutlet weak var chartContainerView: UIView!
    // this contains the chart in the middle
    
    
    
    // MARK: - Variables and Constants
    
    var displayedEntries: [aSingleLogEntry] = []
// this is a filtered array that only contains the logs belonging to a single activity

    // this allows the Weekly bar charts to be on the view controller 2
    // show SwiftUI chart on this UIKit screen
    private var hostingController: UIHostingController<WeeklyBarChart>?
    // hardcoded sample chart data
    private let sampleData = [
        dataPoint(day: "Mon", hours: 2),
        // datapoint is the identifiable data points defined in storage, giving each data an UUID and defining the day, and hours
        dataPoint(day: "Tue", hours: 3),
        dataPoint(day: "Wed", hours: 1),
        dataPoint(day: "Thur", hours: 3),
        dataPoint(day: "Fri", hours: 1),
        dataPoint(day: "Sat", hours: 2),
        dataPoint(day: "Sun", hours: 1)
    ]

    
    
    // MARK: - IBActions and Functions
    
    
    private func setUpChart(){
        //tghis sets up SwiftUI chart inside the UIKit container view
        let chartView = WeeklyBarChart(data:sampleData)
        hostingController = UIHostingController(rootView: chartView)
        
        guard let hostingView = hostingController?.view else {return}
        //unwraps teh chart view ensuring it doesnet crash
        
        hostingView.translatesAutoresizingMaskIntoConstraints = false
        chartContainerView.addSubview(hostingView)
        // this adds teh chart to the UI view controlker
        
        NSLayoutConstraint.activate([
                hostingView.topAnchor.constraint(equalTo: chartContainerView.topAnchor),
                hostingView.bottomAnchor.constraint(equalTo: chartContainerView.bottomAnchor),
                hostingView.leadingAnchor.constraint(equalTo: chartContainerView.leadingAnchor),
                hostingView.trailingAnchor.constraint(equalTo: chartContainerView.trailingAnchor)
                // this just streches teh graph to fit inside the view, and touch all 4 corners top bottom left and right
            ])
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
        // only selected activity is filtered and shown in the log
        displayedEntries.sort { $0.date > $1.date }
        //date > ensures the most recent date goes at teh top
    }
        
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedEntries.count
        // the number of rows that are shwoed (numberofrows insection) is the amount of entries that you cant count in teh displayed entries
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // dequeueReusableCell reuses cells
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
            timeString += "\(entry.hours) hour\(entry.hours == 1 ? "" : "")"
            // if hours is bigger than 0 you show num aomunt of hours
        }
        if entry.minutes > 0{
            timeString += "\(entry.minutes) minutes\(entry.minutes == 1 ? "" : "")"
            // if minutes is larger than 0 you show num amount of minutes
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
        //Navigate to DailyLog screen and pass the selected date
        performSegue(withIdentifier: "showDailyLog", sender: selectedEntry.date)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any?){
        // prepare for segue pasts the data to the next screen before any navigation
        if segue.identifier == "showDailyLog",
           let destination = segue.destination as? DailyLog,
           // sets the next page as daily log
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
        // refresh data display
    }

}
