//
//  CoreDataManager.swift
//  Inception
//
//  Created by Jineeee on 2022/07/20.
//

import UIKit
import CoreData

class AlarmDataManger {
  static let shared: AlarmDataManger = AlarmDataManger()
  
  let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
  lazy var context = appDelegate?.persistentContainer.viewContext
  
  let modelName: String = "AlarmItem"
  
  func fetchAlarmItem() -> [AlarmItem] {
    var models: [AlarmItem] = [AlarmItem]()
    
    if let context = context {
      let sortItem: NSSortDescriptor = NSSortDescriptor(key: "wakeupTime", ascending: false)
      let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest<NSManagedObject>(entityName: modelName)
      fetchRequest.sortDescriptors = [sortItem]
      
      do {
        if let fetchResult: [AlarmItem] = try context.fetch(fetchRequest) as? [AlarmItem] {
          models = fetchResult
        }
      } catch let error as NSError {
        print("Fetch 실패..: \(error), \(error.userInfo)")
      }
    }
    return models
  }
  
  func createAlarmItem(bedTime: Date, wakeupTime: Date, onSuccess: @escaping ((Bool) -> Void)) {
    if let _ = fetchPresentAlarm() {
      offPresentAlarm() { onSuccess in
        
      }
    }
    if let context = context,
       let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: modelName, in: context) {
      if let item: AlarmItem = NSManagedObject(entity: entity, insertInto: context) as? AlarmItem {
        item.isOn = true
        item.bedTime = bedTime
        item.wakeupTime = wakeupTime
        
        contextSave { success in
          onSuccess(success)
        }
      }
    }
  }
  
  func deleteAlarm(_ alarm: AlarmItem, onSuccess: @escaping ((Bool) -> Void)) {
    context?.delete(alarm)
    contextSave { success in
      onSuccess(success)
    }
  }
  
  func deleteAllAlarm() {
    let allItems = fetchAlarmItem()
    for item in allItems {
      context?.delete(item)
    }
  }
  
  func fetchPresentAlarm() -> AlarmItem? {
    let fetchRequest: NSFetchRequest<AlarmItem> = AlarmItem.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "isOn == YES")
    
    return try? context?.fetch(fetchRequest).first
  }
  
  func fetchSavedAlarm() -> [AlarmItem]? {
    let fetchRequest: NSFetchRequest<AlarmItem> = AlarmItem.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "isOn == NO")
    
    return try? context?.fetch(fetchRequest)
  }
  
  func updatePresentAlarm(newPresentAlarm: AlarmItem, onSuccess: @escaping ((Bool) -> Void)) {
    if let nowPresentAlarm = fetchPresentAlarm() {
      nowPresentAlarm.isOn = false
      contextSave { success in
        onSuccess(success)
      }
    }
    else {
      newPresentAlarm.isOn = true
      contextSave { success in
        onSuccess(success)
      }
    }
  }
  
  func offPresentAlarm(onSuccess: @escaping ((Bool) -> Void)) {
    if let nowPresentAlarm = fetchPresentAlarm() {
      nowPresentAlarm.isOn = false
      contextSave { success in
        onSuccess(success)
      }
    }
  }
}

extension AlarmDataManger {
    fileprivate func filteredRequest(id: Int64) -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>
            = NSFetchRequest<NSFetchRequestResult>(entityName: modelName)
        fetchRequest.predicate = NSPredicate(format: "id = %@", NSNumber(value: id))
        return fetchRequest
    }
    
    fileprivate func contextSave(onSuccess: ((Bool) -> Void)) {
        do {
            try context?.save()
            onSuccess(true)
        } catch let error as NSError {
            print("Could not save🥶: \(error), \(error.userInfo)")
            onSuccess(false)
        }
    }
}

