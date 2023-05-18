//
//  FavoritesDataModel+CoreDataProperties.swift
//  
//
//  Created by Defne Çetiner on 18.05.2023.
//
//

import Foundation
import CoreData


extension FavoritesDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritesDataModel> {
        return NSFetchRequest<FavoritesDataModel>(entityName: "FavoritesDataModel")
    }

    @NSManaged public var author_fav: String?
    @NSManaged public var categories_fv: String?
    @NSManaged public var description_fav: String?
    @NSManaged public var id: UUID?
    @NSManaged public var image_fav: String?
    @NSManaged public var title_fav: String?
    @NSManaged public var url_fav: String?

}
extension FavoritesDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritesDataModel> {
        return NSFetchRequest<FavoritesDataModel>(entityName: "FavoritesDataModel")
    }

    @NSManaged public var url_fav: String?
   
}
