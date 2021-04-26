//
//  Subscription+CoreDataProperties.swift
//  SpeedX
//
//  Created by ehco on 2021/4/24.
//
//

import Foundation
import CoreData


extension Subscription {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subscription> {
        return NSFetchRequest<Subscription>(entityName: "Subscription")
    }

    @NSManaged public var remark_: String?
    @NSManaged public var uid_: UUID?
    @NSManaged public var url_: String?
    @NSManaged public var nodes: NSSet?

}

// MARK: Generated accessors for nodes
extension Subscription {

    @objc(addNodesObject:)
    @NSManaged public func addToNodes(_ value: ProxyNode)

    @objc(removeNodesObject:)
    @NSManaged public func removeFromNodes(_ value: ProxyNode)

    @objc(addNodes:)
    @NSManaged public func addToNodes(_ values: NSSet)

    @objc(removeNodes:)
    @NSManaged public func removeFromNodes(_ values: NSSet)

}

extension Subscription : Identifiable {

}
