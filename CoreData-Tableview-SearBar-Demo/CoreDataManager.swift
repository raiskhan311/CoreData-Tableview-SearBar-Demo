//
//  CoreDataManager.swift
//  CoreData-Tableview-SearBar-Demo
//
//  Created by mac on 01/07/17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit
import CoreData

struct imageItem {
    var imageName:String?
    var imageBy:String?
    var imageYear:String?
    
    init(){
        imageName = ""
        imageBy = ""
        imageYear = ""
    }
    init(Name:String,By:String,Year:String) {
        self.imageName = Name
        self.imageBy = By
        self.imageYear = Year
    }
}

class CoreDataManager: NSObject {
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    ///store obj into core data
    class func storeObj(name:String,by:String,year:String) {
        let context = getContext()
        
        let entity = NSEntityDescription.entity(forEntityName: "ImageEntity", in: context)
        
        let managedObj = NSManagedObject(entity: entity!, insertInto: context)
        
        managedObj.setValue(name, forKey: "name")
        managedObj.setValue(by, forKey: "by")
        managedObj.setValue(year, forKey: "year")
        
        do {
            try context.save()
            print("saved!")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    ///fetch all the objects from core data
    
    class func fetchObj(selectedScopeIdx:Int?=nil, targetText:String?=nil) -> [imageItem]{
        var aray = [imageItem]()
        
        let fetchRequest:NSFetchRequest<ImageEntity> = ImageEntity.fetchRequest()
        
        if selectedScopeIdx != nil && targetText != nil {
            
            var filterKeyword = ""
            
            switch selectedScopeIdx! {
            case 0:
                filterKeyword = "name"
            case 1:
                filterKeyword = "by"
            default:
                filterKeyword = "year"
            }
            
            let predicate = NSPredicate(format: "\(filterKeyword) contains[c] %@", targetText!)
            //predicate = NSPredicate(format: "by == %@" , "wang")
            //predicate = NSPredicate(format: "year > %@", "2015")
            
            fetchRequest.predicate = predicate
        }
        
        do {
            let fetchResult = try getContext().fetch(fetchRequest)
            
            for item in fetchResult {
                let img = imageItem(Name: item.name!, By: item.by!, Year: item.year!)
                aray.append(img)
                print("image name:"+img.imageName!+"\nimage year:"+img.imageYear!+"\nimage by:"+img.imageBy!+"\n")
            }
        }catch {
            print(error.localizedDescription)
        }
        
        return aray
    }
    
    ///delete all the data in core data
    class func cleanCoreData() {
        
        let fetchRequest:NSFetchRequest<ImageEntity> = ImageEntity.fetchRequest()
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            print("deleting all contents")
            try getContext().execute(deleteRequest)
        }catch {
            print(error.localizedDescription)
        }
        
    }
    
    //
    //    class func deleteCoreDataItemWithIndex() {
    //
    //        var predicate = NSPredicate(format: "name contains[c] %@", "001")
    //
    //        let fetchRequest:NSFetchRequest<ImageEntity> = ImageEntity.fetchRequest()
    //        fetchRequest.predicate = predicate
    //
    //        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
    //
    //        do {
    //            print("deleting all contents")
    //            try getContext().execute(deleteRequest)
    //        }catch {
    //            print(error.localizedDescription)
    //        }
    //        
    //        
    //    }
}
