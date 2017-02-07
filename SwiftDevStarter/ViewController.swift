//
//  ViewController.swift
//  SwiftDevStarter
//
//  Created by Cole Richards on 6/7/16.
//  Copyright © 2016 ROXIMITY. All rights reserved.
//

import UIKit

class ViewController: UIViewController, EventHistoryUpdateResponder, UITableViewDelegate, UITableViewDataSource, ROXBeaconRangeUpdateDelegate {

    @IBOutlet weak var roxEventsTable: UITableView!
    @IBOutlet weak var lastLocationAccLabel: UILabel!
    
    var roxEventManager :SDKObserver!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ROXIMITYEngine.setBeaconRangeDelegate(self, withUpdateInterval:kROXBeaconRangeUpdatesFastest)
        setROXEventManager()
        registerCustomTableCellComponents()
        startLocationLabelTimer()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    private func startLocationLabelTimer(){
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(setCurrentLocationLabel), userInfo: nil, repeats: true)
    }
    
    @objc private func setCurrentLocationLabel(){
        let mostRecentLocation = ROXIMITYEngine.getMostRecentLocation()
        self.lastLocationAccLabel.text = "Last Location Accuracy: \(mostRecentLocation.horizontalAccuracy) - meters"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didUpdateBeaconRanges(rangedBeacons: [AnyObject]!) {
        print(rangedBeacons)
    }
    
    func setROXEventManager(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        roxEventManager = appDelegate.roxEventListener
        roxEventManager.addNewEventHistoryResponder(self)
    }
    
    func registerCustomTableCellComponents(){
        self.roxEventsTable.registerClass(ROXEventTableViewCell.self, forCellReuseIdentifier: "EventTableCell")
        self.roxEventsTable.registerNib(UINib(nibName: "ROXEventTableViewCell", bundle: nil), forCellReuseIdentifier: "EventTableCell")
        self.roxEventsTable.separatorColor = UIColor.clearColor()
    }
    
    func didUpdateWithNewEvent() {
        roxEventsTable.reloadData()
    }
    
    //MARK: TableView Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return roxEventManager.eventHistory.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("EventTableCell", forIndexPath: indexPath) as! ROXEventTableViewCell
        
        let event = roxEventManager.eventHistory[indexPath.row]
        cell.setWithROXEventInfo(event)
        
        return cell
    }


}

