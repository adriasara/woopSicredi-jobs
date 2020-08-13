//
//  EventsListModel.swift
//  woopSicredi-jobs
//
//  Created by Ádria Cardoso on 13/08/20.
//  Copyright © 2020 Ádria Cardoso. All rights reserved.
//

import UIKit

struct Cupons: Codable {

    var id: String?
    var eventId: String?
    var discount: Decimal?
    
    private enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case eventId = "eventId"
        case discount = "discount"
    }
    
    init() {
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let value = try? container.decode(Int.self, forKey: .id) {
            id = String(value)
        } else {
            id = try? container.decode(String.self, forKey: .id)
        }
        
        if let value = try? container.decode(Int.self, forKey: .eventId) {
            eventId = String(value)
        } else {
            eventId = try? container.decode(String.self, forKey: .eventId)
        }
        
        discount = try? container.decode(Decimal.self, forKey: .discount)
    }
}

struct People: Codable {

    var id: String?
    var eventId: String?
    var name: String?
    var picture: String?
    
    private enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case eventId = "eventId"
        case name = "name"
        case picture = "picture"
    }
    
    init() {
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let value = try? container.decode(Int.self, forKey: .id) {
            id = String(value)
        } else {
            id = try? container.decode(String.self, forKey: .id)
        }
        
        if let value = try? container.decode(Int.self, forKey: .eventId) {
            eventId = String(value)
        } else {
            eventId = try? container.decode(String.self, forKey: .eventId)
        }
        
        name = try? container.decode(String.self, forKey: .name)
        picture = try? container.decode(String.self, forKey: .picture)
    }
}

class EventsListModel: Codable {
    
    var people: [People]?
    var date: Int?
    var description: String?
    var image: String?
    var longitude: Double?
    var latitude: Double?
    var price: Decimal?
    var title: String?
    var id: String?
    var cupons: [Cupons]?
    
    private enum CodingKeys: String, CodingKey {
        
        case people = "people"
        case date = "date"
        case description = "description"
        case image = "image"
        case longitude = "longitude"
        case latitude = "latitude"
        case price = "price"
        case title = "title"
        case id = "id"
        case cupons = "cupons"
    }
    
    init() {

    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        people = try? container.decode([People].self, forKey: .people)
        date = try? container.decode(Int.self, forKey: .date)
        description = try? container.decode(String.self, forKey: .description)
        image = try? container.decode(String.self, forKey: .image)
        longitude = try? container.decode(Double.self, forKey: .longitude)
        latitude = try? container.decode(Double.self, forKey: .latitude)
        price = try? container.decode(Decimal.self, forKey: .price)
        title = try? container.decode(String.self, forKey: .title)
        
        if let value = try? container.decode(Int.self, forKey: .id) {
            id = String(value)
        } else {
            id = try? container.decode(String.self, forKey: .id)
        }
        
        cupons = try? container.decode([Cupons].self, forKey: .cupons)
    }
}
