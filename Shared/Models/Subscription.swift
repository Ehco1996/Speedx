//
//  Subscription.swift
//  SpeedX (iOS)
//
//  Created by ehco on 2021/4/18.
//


import CoreData
import Combine

//NOTE: Subscription is a model from Core Data
extension Subscription {

    var uid: UUID {
        get { uid_ ?? UUID() }
        set { uid_ = newValue }
    }

    var remark: String? {
        get { remark_ ?? "" }
        set { remark_ = newValue }
    }

    var url: String {
        get { url_ ?? "" }
        set { url_ = newValue }
    }

    static func listAll() -> NSFetchRequest<Subscription> {
        let request = NSFetchRequest<Subscription>(entityName: "Subscription")
        request.sortDescriptors = [NSSortDescriptor(key: "remark_", ascending: true)]
        return request
    }


    static func create(url: String, remark: String?, context: NSManagedObjectContext) -> Subscription? {
        let sub = Subscription(context: context)
        sub.remark = remark
        sub.url = url
        do {
            try context.save()
            return sub
        } catch {
            print("save failed")
            print(error)
        }
        return nil
    }
}
