//
//  EventsDetailsVC.swift
//  woopSicredi-jobs
//
//  Created by Ádria Cardoso on 13/08/20.
//  Copyright © 2020 Ádria Cardoso. All rights reserved.
//

import UIKit

class EventsDetailsVC: UIViewController {
    
    let eventsDetailsView: EventsDetailsView = EventsDetailsView(frame: .zero)
    
    var eventSelect = EventsListModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.sv([eventsDetailsView])
        
        eventsDetailsView.fillContainer()
        eventsDetailsView.setupComponents(item: eventSelect)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "event_detail".localized()
    }
}
