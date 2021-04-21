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


    static func create(context: NSManagedObjectContext, url: String, remark: String?) -> Subscription? {
        if url != "" {
            let sub = Subscription(context: context)
            sub.url = url
            if remark == "" {
                sub.remark = url
            } else {
                sub.remark = remark
            }
            do {
                try context.save()
                return sub
            } catch {
                print("save failed")
                print(error)
            }
        }
        return nil
    }

    func delete(context: NSManagedObjectContext) -> Void {
        context.delete(self)
        try? context.save()
    }
}
