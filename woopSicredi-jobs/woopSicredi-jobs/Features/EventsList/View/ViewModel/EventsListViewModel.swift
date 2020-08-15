//
//  EventsListViewModel.swift
//  woopSicredi-jobs
//
//  Created by Ádria Cardoso on 13/08/20.
//  Copyright © 2020 Ádria Cardoso. All rights reserved.
//

import UIKit
import Alamofire

final class EventsListViewModel: NSObject {
    
    var eventsListModel: EventsListModel
    
    init(eventsListModel: EventsListModel) {
        self.eventsListModel = eventsListModel
    }
    
    func requestEventsList(completion: @escaping (_ response: ResponseType?, _ result: [EventsListModel]?) -> Void) {
        
        let request = AF.request("http://5b840ba5db24a100142dcd8c.mockapi.io/api/events")
        
        request.responseJSON { (response) in
            
            if let data = response.data {

                if let jResult = try? JSONDecoder().decode([EventsListModel].self, from: data) {
                    
                    completion(.success, jResult)
                } else {
                    completion(.warning, nil)
                }
            } else {
                completion(.error, nil)
            }
        }
    }
}
