//
//  News.swift
//  
//
//  Created by Defne Çetiner on 11.05.2023.
//

import Foundation

public struct NewsResult: Decodable {
    public let status, copyright, section: String?
    public let lastUpdated: String?
    public let numResults: Int?
    public let results: [News]?
    
    enum CodingKeys: String, CodingKey {
        case status, copyright, section
        case lastUpdated = "last_updated"
        case numResults = "num_results"
        case results
    }
}

public struct News: Decodable {
    public let section, subsection, title, abstract, byline: String?
    public let url: String?
    public let updatedDate, createdDate, publishedDate: String?
    public let materialTypeFacet: String?
    public let desFacet, orgFacet, perFacet, geoFacet: [String]?
    public let multimedia: [Multimedia]?
    public let shortURL: String?
    
    enum CodingKeys: String, CodingKey {
        case section, subsection, title, abstract, url, byline
        case updatedDate = "updated_date"
        case createdDate = "created_date"
        case publishedDate = "published_date"
        case materialTypeFacet = "material_type_facet"
        case desFacet = "des_facet"
        case orgFacet = "org_facet"
        case perFacet = "per_facet"
        case geoFacet = "geo_facet"
        case shortURL = "short_url"
        case multimedia
    }
}

public struct Multimedia: Decodable {
    public let url: String?
}
