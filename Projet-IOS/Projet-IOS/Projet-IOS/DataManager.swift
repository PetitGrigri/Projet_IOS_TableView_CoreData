//
//  DataManager.swift
//  MyCoreDataApplication
//
//  Created by Fabien on 16/11/2016.
//  Copyright © 2016 PetitGrigri. All rights reserved.
//

import Foundation
import CoreData

class DataManager : NSObject {
    
    public static let shared = DataManager()
    public var objectContext: NSManagedObjectContext? = nil
    
    private override init(){
        if let modelUrl = Bundle.main.url(forResource: "Entities", withExtension: "momd") {
            
            print ("modelUrl : \(modelUrl.description)")
            
            if let model = NSManagedObjectModel(contentsOf: modelUrl){
                if let storageUrl = FileManager.documentURL(childPath: "MyDataBase.db"){
                    
                    print ("storageUrl : \(storageUrl.description)")
                    
                    let storeCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
                    _ = try? storeCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storageUrl, options: nil)
                    
                    let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
                    context.persistentStoreCoordinator = storeCoordinator
                    self.objectContext = context

                }
            }
        }
        
    
    }
    
}
