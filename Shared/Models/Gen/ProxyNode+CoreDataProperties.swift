//
//  ProxyNode+CoreDataProperties.swift
//  SpeedX
//
//  Created by ehco on 2021/4/24.
//
//

import Foundation
import CoreData


extension ProxyNode {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProxyNode> {
        return NSFetchRequest<ProxyNode>(entityName: "ProxyNode")
    }

    @NSManaged public var id_: Int64
    @NSManaged public var name_: String?
    @NSManaged public var sub: Subscription?

}

extension ProxyNode : Identifiable {

}
