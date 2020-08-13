//
//  EventsListVC.swift
//  woopSicredi-jobs
//
//  Created by Ádria Cardoso on 13/08/20.
//  Copyright © 2020 Ádria Cardoso. All rights reserved.
//

import UIKit
import Stevia

class EventsListVC: UIViewController {
    
    let eventsListView: EventsListView = EventsListView(frame: .zero)
    var eventsListViewModel: EventsListViewModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.sv([eventsListView])
        view.backgroundColor = .white
        
        eventsListView.fillContainer()
        
        requestEventList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "events".localized()
    }
    
    func requestEventList() {
        
        eventsListViewModel = EventsListViewModel(eventsListModel: .init())
        
        eventsListViewModel?.requestEventsList(completion: { (response) in
            
            if response == .success {
                print("success")
            } else {
                print("error")
            }
        })
    }
}
