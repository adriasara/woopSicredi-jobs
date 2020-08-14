//
//  EventsDetailsViewModel.swift
//  woopSicredi-jobs
//
//  Created by Ádria Cardoso on 14/08/20.
//  Copyright © 2020 Ádria Cardoso. All rights reserved.
//

import UIKit
import Alamofire

final class EventsDetailsViewModel: NSObject {
    
    func requestCheckIn(data: [String : Any], completion: @escaping (_ response: ResponseType?) -> Void) {
        
        guard let url = URL(string: "http://5b840ba5db24a100142dcd8c.mockapi.io/api/checkin") else { return }
        var request = URLRequest(url: url)
        guard let data = try? JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions.prettyPrinted) else { return }
        let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        
        if let json = json {
            request.httpBody = json.data(using: String.Encoding.utf8.rawValue)
        }
        
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        AF.request(request).responseJSON { (response) in
            
            switch response.result {
            case .success(_):
                completion(.success); break
            case .failure(_):
                completion(.error); break
            }
        }
    }
}
