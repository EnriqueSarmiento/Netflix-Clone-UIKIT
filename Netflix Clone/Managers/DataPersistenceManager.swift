//
//  DataPersistenceManager.swift
//  Netflix Clone
//
//  Created by Enrique Sarmiento on 6/7/24.
//

import Foundation
import CoreData
import UIKit

class DataPersistenceManager {
   
   enum DatabaseError: Error {
      case failedToSaveData
      case failedToFetchData
   }
   
   static let shared = DataPersistenceManager()
   
   func downloadTitleWith(model: Title, completion: @escaping (Result<Void, Error>) -> Void){
      
      guard let appDelagte = UIApplication.shared.delegate as? AppDelegate else {return}
      
      let context = appDelagte.persistentContainer.viewContext
      
      let item = TitleItem(context: context)
      let mirror = Mirror(reflecting: model)
      
      /**assigning data for key because both model and antity has same keys**/
      for case let (label?, value) in
         mirror.children {
            if let entityProperty = item.entity.propertiesByName[label] {
               if let intValue = value as? Int {
                  item.setValue(Int64(intValue), forKey: label)
               }else {
                  item.setValue(value, forKey: label)
               }
            }
         }
      
      
      
//      item.id = Int64(model.id)
//      item.media_type = model.media_type
//      item.original_title = model.original_title
//      item.original_name = model.original_name
//      item.overview = model.overview
//      item.poster_path = model.poster_path
//      item.vote_average = model.vote_average
//      item.vote_count = Int64(model.vote_count)
//      item.release_date = model.release_date
      
      do {
         try context.save()
         completion(.success(()))
      } catch let error as NSError {
         print("DBEUG: error on data into core data", error.localizedDescription)
         completion(.failure(DatabaseError.failedToSaveData))
      }
   }
   
   func fetchingTitlesfromDataBase(completion: @escaping (Result<[TitleItem], Error>) -> Void){
      guard let appDelagte = UIApplication.shared.delegate as? AppDelegate else {return}
      
      let context = appDelagte.persistentContainer.viewContext
      
      let request: NSFetchRequest<TitleItem>
      request = TitleItem.fetchRequest()
      
      do {
         let titles = try context.fetch(request)
         completion(.success(titles))
         
      } catch let error as NSError {
         print("DEBUG: error during fetch core data ", error.localizedDescription)
         completion(.failure(DatabaseError.failedToFetchData))
      }
      
      
      
   }
   
}
