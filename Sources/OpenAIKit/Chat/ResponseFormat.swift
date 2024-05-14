//
//  File.swift
//  
//
//  Created by Collin Hundley on 2/13/24.
//

import Foundation

public enum ResponseFormat: String, Codable {
    enum CodingKeys: String, CodingKey {
        case type
    }
    case text = "text"
    case json = "json_object"
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(rawValue, forKey: .type)
    }
}
