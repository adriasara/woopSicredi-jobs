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
        
        view.backgroundColor = .white
                
        requestEventList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "events".localized()
    }
    
    func requestEventList() {
        
        eventsListViewModel = EventsListViewModel(eventsListModel: .init())
        
        eventsListViewModel?.requestEventsList(completion: { (response, result)  in
            
            if response == .success {                
                if let eventList = result {
                    self.eventsListView.setEventsList(result: eventList)
                    self.view.sv(self.eventsListView)
                    self.eventsListView.delegate = self
                    self.eventsListView.fillContainer()
                }
            } else {
                self.presentAlertMessage(title: "fail".localized(), message: "error".localized())
            }
        })
    }
}

extension EventsListVC: EventListViewDelegate {
    
    func selectEvent(event: EventsListModel) {
        
        let detailsVC = EventsDetailsVC()
        
        detailsVC.eventSelect = event

        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
