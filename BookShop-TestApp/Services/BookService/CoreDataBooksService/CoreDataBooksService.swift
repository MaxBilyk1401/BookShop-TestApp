//
//  CoreDataBooksService.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/6/23.
//

import UIKit
import CoreData

final class CoreDataBooksService: BooksService {
    
    static let expirationTime: TimeInterval = 60 * 60 * 24 // 1 day
    
    private enum BooksServiceError: Error {
        case emptyStorage
        case expiredData
    }
    
    private var context: NSManagedObjectContext {
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func loadData(categoryName: String, completion: @escaping (Result<[BooksModel], Error>) -> Void) {
        do {
            guard let localBooksData = try find(byCategoryName: categoryName, in: context) else {
                completion(.failure(BooksServiceError.emptyStorage))
                return
            }
            
            let now = Date()
            
            if let localBooksDate = localBooksData.date, now.timeIntervalSince1970 - localBooksDate.timeIntervalSince1970 < Self.expirationTime {
                let localBooks = (localBooksData.books ?? NSOrderedSet(array: [])).array as? [LocalBookModel]
                let buisnessModels = (localBooks ?? []).map { BooksModel(from: $0) }.compactMap { $0 }
                
                completion(.success(buisnessModels))
            } else  {
                completion(.failure(BooksServiceError.expiredData))
            }
        } catch {
            completion(.failure(error))
        }
    }
}

protocol SaveBooksService {
    func save(_ books: [BooksModel], with categoryName: String, completion: @escaping (Result<Void, Error>) -> Void)
}

extension CoreDataBooksService: SaveBooksService {
    
    func save(_ books: [BooksModel], with categoryName: String, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            
            let localBooksList = try newUniqueInstance(byCategoryName: categoryName, in: context)
            
            let localBooks: [LocalBookModel] = books.map { model in
                let localModel = LocalBookModel(context: context)
                localModel.author = model.author
                localModel.bookDescription = model.description
                localModel.bookImage = model.bookImage
                localModel.buyURl = model.buyURl
                localModel.publisher = model.publisher
                localModel.rank = Int64(model.rank)
                localModel.title = model.title
                return localModel
            }
            
            let now = Date()
            localBooksList.date = now
            localBooksList.books = NSOrderedSet(array: localBooks)
            localBooksList.categoryName = categoryName
            
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
    private func find(byCategoryName categoryName: String, in context: NSManagedObjectContext) throws -> LocalBooksList? {
        let fetchRequest: NSFetchRequest<LocalBooksList> = LocalBooksList.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "categoryName == %@", categoryName)
        return try context.fetch(fetchRequest).first
    }
    
    private func newUniqueInstance(byCategoryName categoryName: String, in context: NSManagedObjectContext) throws -> LocalBooksList {
        try find(byCategoryName: categoryName, in: context).map(context.delete)
        return LocalBooksList(context: context)
    }
}

private extension BooksModel {
    
    init?(from localModel: LocalBookModel) {
        guard let title = localModel.title,
              let description = localModel.bookDescription,
              let author = localModel.author,
              let publisher = localModel.publisher,
              let buyURl = localModel.buyURl,
              let bookImage = localModel.bookImage else { return nil }
        
        self.title = title
        self.description = description
        self.author = author
        self.publisher = publisher
        self.bookImage = bookImage
        self.buyURl = buyURl
        self.rank = Int(localModel.rank)
    }
}
