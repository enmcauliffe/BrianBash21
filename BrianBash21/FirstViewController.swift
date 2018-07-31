//
//  FirstViewController.swift
//  BrianBash21
//
//  Created by Erin McAuliffe on 7/14/18.
//  Copyright © 2018 Erin McAuliffe. All rights reserved.
//

import UIKit
import EventKit

class FirstViewController: UIViewController {

    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    
    var timer = Timer()
    var isTimerRunning = false
    var seconds = 60
    let calendar = Calendar.current
    
    var bBday:Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // here we set the current date
        
//        let date = NSDate()
//
//        let components = calendar.dateComponents([.hour, .minute, .month, .year, .day], from: date as Date)
//
//        let currentDate = calendar.date(from: components)
        
        let userCalendar = Calendar.current
        
        // here we set the due date. When the timer is supposed to finish
        let competitionDate = NSDateComponents()
        competitionDate.year = 2019
        competitionDate.month = 2
        competitionDate.day = 18
        competitionDate.hour = 00
        competitionDate.minute = 00
        bBday = userCalendar.date(from: competitionDate as DateComponents)!
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(FirstViewController.updateTimer)), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func updateTimer() {
        let date = NSDate()
        
        let components = calendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: date as Date)
        
        let currentDate = calendar.date(from: components)
        let sevenDaysAgo = Calendar.current.date(byAdding: .second, value: -1, to: bBday!)
        
        let CompetitionDayDifference = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate!, to: sevenDaysAgo!)
        
        //finally, here we set the variable to our remaining time
        let daysLeft = CompetitionDayDifference.day!
        let hoursLeft = CompetitionDayDifference.hour!
        let minutesLeft = CompetitionDayDifference.minute!
        let secondsLeft = CompetitionDayDifference.second!
        
        daysLabel.text = "\(String(describing: daysLeft)) DAYS"
        hoursLabel.text = "\(String(describing: hoursLeft)) HOURS"
        minutesLabel.text = "\(String(describing: minutesLeft)) MINUTES"
        secondsLabel.text = "\(String(describing: secondsLeft)) SECONDS"
        
    }
    
    @IBAction func addToCalendarPressed(_ sender: Any) {
        //let eventStore = EKEventStore();
        
        let competitionDate = NSDateComponents()
        competitionDate.year = 2019
        competitionDate.month = 2
        competitionDate.day = 18
        competitionDate.hour = 23
        competitionDate.minute = 59
        let endBday  = Calendar.current.date(from: competitionDate as DateComponents)!
        
        
        // Use Event Store to create a new calendar instance
        let eventStore: EKEventStore = EKEventStore()
        
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            print("authorized")
        case .restricted, .denied:
            print("not given")
        case .notDetermined:
            eventStore.requestAccess(to: .event, completion: {(isAllowed, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    if isAllowed {
                        print("poop")
                    }
                }
            })
            
        }
        
        eventStore.requestAccess(to: .event, completion: { (granted, error) in
            if (granted) && (error == nil){
                print("granted \(granted)")
                print("error \(String(describing: error))")
                DispatchQueue.main.async {
                    let event:EKEvent = EKEvent(eventStore: eventStore)
                    event.title = "Brians 21st!"
                    event.startDate = self.bBday
                    event.endDate = endBday
                    event.calendar = eventStore.defaultCalendarForNewEvents
                    
                    do{
                        try eventStore.save(event, span: .thisEvent)
                        self.navigationController?.popViewController(animated: true)
                        self.dismiss(animated: true, completion: nil)
                        
                    }catch{
                        let alert = UIAlertController(title: "Event could not save", message: (error as NSError).localizedDescription, preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(OKAction)
                        
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            } else {
                print("No access")
            }
        })
    }
    
}

