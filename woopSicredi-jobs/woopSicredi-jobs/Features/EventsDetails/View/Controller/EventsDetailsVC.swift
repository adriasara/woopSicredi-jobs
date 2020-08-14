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
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "share"), style: .plain, target: self, action: #selector(share))
    }
    
    @objc private func share() {
     
        let activityViewController = UIActivityViewController(activityItems: [eventsDetailsView] , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
}

extension EventsDetailsVC: EventsDetailsViewDelegate {
    
    func loginAction() {
        self.dismiss(animated: true, completion: nil)

        self.presentAlertController(title: "welcome".localized(), message: "want_to_login".localized()) { (textFields) in
            
            DispatchQueue.main.async {
                
                guard let eventId = self.eventSelect.people?.first?.eventId else { return }
                guard let name = textFields?[0] else { return }
                guard let email = textFields?[1] else { return }
                
                self.eventDetailViewModel?.requestLogin(data: ["eventId" : eventId, "name" : name, "email" : email], completion: { (response) in
                    
//                    self.dismiss(animated: true) {
                        if response == .success {
                            self.presentAlertMessage(title: "success".localized(), message: "logged".localized())
                        } else {
                            self.presentAlertMessage(title: "fail".localized(), message: "error".localized())
                        }
//                    }
                })
            }
        }
    }
}
