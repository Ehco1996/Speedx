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

    public var uid: UUID {
        get { uid_ ?? UUID() }
        set { uid_ = newValue }
    }

    public var remark: String? {
        get { remark_ ?? "" }
        set { remark_ = newValue }
    }

    public var url: String {
        get { url_ ?? "" }
        set { url_ = newValue }
    }


    public var nodesArray: [ProxyNode] {
        // NOTE coredata 生成的东西是oc的类型，swiftui不认，所以需要我们手动转一下
        let set = nodes as? Set<ProxyNode> ?? []
        return set.sorted { $0.id_ < $1.id_ }
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
