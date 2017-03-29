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
    
    var roxEventManager :SDKObserver!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ROXIMITYEngine.setBeaconRangeDelegate(self, with:kROXBeaconRangeUpdatesFastest)
        setROXEventManager()
        registerCustomTableCellComponents()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didUpdateBeaconRanges(_ rangedBeacons: [Any]!) {
        print(rangedBeacons)
    }
    
    func setROXEventManager(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        roxEventManager = appDelegate.roxEventListener
        roxEventManager.addNewEventHistoryResponder(self)
    }
    
    func registerCustomTableCellComponents(){
        self.roxEventsTable.register(ROXEventTableViewCell.self, forCellReuseIdentifier: "EventTableCell")
        self.roxEventsTable.register(UINib(nibName: "ROXEventTableViewCell", bundle: nil), forCellReuseIdentifier: "EventTableCell")
        self.roxEventsTable.separatorColor = UIColor.clear
    }
    
    func didUpdateWithNewEvent() {
        roxEventsTable.reloadData()
    }
    
    //MARK: TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return roxEventManager.eventHistory.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableCell", for: indexPath) as! ROXEventTableViewCell
        
        let event = roxEventManager.eventHistory[indexPath.row]
        cell.setWithROXEventInfo(event)
        
        return cell
    }


}

