//
//  ROXEventTableViewCell.swift
//  SwiftDevStarter
//
//  Created by Cole Richards on 6/8/16.
//  Copyright © 2016 ROXIMITY. All rights reserved.
//

import UIKit

class ROXEventTableViewCell: UITableViewCell {

    @IBOutlet weak var topBannerView: UIView!
    @IBOutlet weak var bottomBannerView: UIView!
    @IBOutlet weak var topLevelTitle: UILabel!
    @IBOutlet weak var eventDetailLine1: UILabel!
    @IBOutlet weak var eventDetailLine2: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setWithROXEventInfo(_ event:ROXEventInfo){
        self.topLevelTitle.text = event.getEventDescription()
        self.eventDetailLine1.text = event.getEventDetailDescription1()
        self.eventDetailLine2.text = event.getEventDetailDescription2()
        self.dateLabel.text = event.getFormattedDateString()
        self.topBannerView.backgroundColor = event.getEventColor()
        self.bottomBannerView.backgroundColor = event.getEventColor()
    }
}
