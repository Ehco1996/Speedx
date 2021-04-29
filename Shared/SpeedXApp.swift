//
//  SpeedXApp.swift
//  Shared
//
//  Created by ehco on 2021/4/18.
//

import SwiftUI
import CoreData

@main
struct SpeedXApp: App {
    let persistenceController = PersistenceController.shared

    init() {
        // NOTE 构造一些初始数据
        let context = persistenceController.container.viewContext
        let req = Subscription.listAll()
        do {
            let subs = try context.fetch(req)
            let sub: Subscription
            if subs.count == 0 {
                sub = Subscription(context: context)
                sub.url = "url"
                sub.remark = "remark"
            } else {
                sub = subs.first!
            }
            print(sub.remark!, sub.nodesArray.count)
            if sub.nodesArray.count <= 1 {
                let node = ProxyNode(context: context)
                node.name = "节点2"
                sub.addToNodes(node)
                try context.save()
                print(sub.nodesArray)
            } else {
                let node = sub.nodesArray.first!
                print(node.id_, node.name)
            }
        } catch {
            fatalError("Failed to fetch entity: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            return ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
