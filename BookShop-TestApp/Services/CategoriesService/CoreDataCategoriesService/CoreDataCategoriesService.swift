//
//  CoreDataCategoriesService.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/6/23.
//

import UIKit
import CoreData

final class CoreDataCategoriesService: CategoriesService {
    
    static let expirationTime: TimeInterval = 60 * 60 * 24 * 30 // 30 days
    
    private enum CategoriesServiceError: Error {
        case emptyStorage
        case expiredData
    }
    
    private var context: NSManagedObjectContext {
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func loadData(completion: @escaping (Result<[CategoryModel], Error>) -> Void) {
        do {
            guard let localCategoryData = try find(in: context) else {
                completion(.failure(CategoriesServiceError.emptyStorage))
                return
            }
            
            let now = Date()
            
            if let localCategoryDate = localCategoryData.date, now.timeIntervalSince1970 - localCategoryDate.timeIntervalSince1970 < Self.expirationTime {
                let localCategories = (localCategoryData.categories ?? NSOrderedSet(array: [])).array as? [LocalCategoryModel]
                let buisnessModels = (localCategories ?? []).map { CategoryModel(from: $0) }.compactMap { $0 }
                
                completion(.success(buisnessModels))
            } else  {
                completion(.failure(CategoriesServiceError.expiredData))
            }
        } catch {
            completion(.failure(error))
        }
    }
}

protocol SaveCategorisService {
    func save(_ categories: [CategoryModel], completion: @escaping (Result<Void, Error>) -> Void)
}

extension CoreDataCategoriesService: SaveCategorisService {
    
    func save(_ categories: [CategoryModel], completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            let now = Date()
            let localCategoriesList = try newUniqueInstance(in: context)
            localCategoriesList.date = now
            
            let localCategories: [LocalCategoryModel] = categories.map { model in
                let localModel = LocalCategoryModel(context: context)
                localModel.displayName = model.displayName
                localModel.listName = model.listName
                localModel.oldestPublishedDate = model.oldestPublishedDate
                localModel.newestPublishedDate = model.newestPublishedDate
                return localModel
            }
            
            localCategoriesList.categories = NSOrderedSet(array: localCategories)
            
            try context.save()
            print(context)
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
    private func find(in context: NSManagedObjectContext) throws -> LocalCategoryList? {
        let fetchRequest: NSFetchRequest<LocalCategoryList> = LocalCategoryList.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        return try context.fetch(fetchRequest).first
    }
    
    private func newUniqueInstance(in context: NSManagedObjectContext) throws -> LocalCategoryList {
        try find(in: context).map(context.delete)
        return LocalCategoryList(context: context)
    }
}

private extension CategoryModel {
    
    init?(from localModel: LocalCategoryModel) {
        guard let displayName = localModel.displayName,
              let listName = localModel.listName,
              let oldestPublishedDate = localModel.oldestPublishedDate,
              let newestPublishedDate = localModel.newestPublishedDate else { return nil }
        
        self.displayName = displayName
        self.listName = listName
        self.oldestPublishedDate = oldestPublishedDate
        self.newestPublishedDate = newestPublishedDate
    }
}
