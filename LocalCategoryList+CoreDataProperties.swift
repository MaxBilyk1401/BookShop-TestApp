//
//  LocalCategoryList+CoreDataProperties.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/6/23.
//
//

import Foundation
import CoreData


extension LocalCategoryList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocalCategoryList> {
        return NSFetchRequest<LocalCategoryList>(entityName: "LocalCategoryList")
    }

    @NSManaged public var date: Date?
    @NSManaged public var categories: LocalCategoryModel?

}

extension LocalCategoryList : Identifiable {

}
