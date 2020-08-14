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
    var eventDetailViewModel: EventsDetailsViewModel? = nil
    
    var eventSelect = EventsListModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.sv([eventsDetailsView])
        
        eventDetailViewModel = EventsDetailsViewModel()

        eventsDetailsView.delegate = self
        eventsDetailsView.fillContainer()
        eventsDetailsView.setupComponents(item: eventSelect)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "event_detail".localized()
        shareImage()
    }
}

extension EventsDetailsVC: EventsDetailsViewDelegate {
    
    func checkInAction() {

        self.presentAlertController(title: "welcome".localized(), message: "want_to_checkin".localized()) { (textFields) in
            
            DispatchQueue.main.async {
                
                guard let eventId = self.eventSelect.people?.first?.eventId else { return }
                guard let name = textFields?[0] else { return }
                guard let email = textFields?[1] else { return }
                
                if email.isValidEmail() {
                    self.eventDetailViewModel?.requestCheckIn(data: ["eventId" : eventId, "name" : name, "email" : email], completion: { (response) in
                        
                        if response == .success {
                            self.presentAlertMessage(title: "success".localized(), message: "logged".localized())
                        } else {
                            self.presentAlertMessage(title: "fail".localized(), message: "error".localized())
                        }
                    })
                } else {
                    self.presentAlertMessage(title: "fail".localized(), message: "type_valid_email".localized())
                }
            }
        }
    }
}
