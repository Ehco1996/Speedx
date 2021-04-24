//
//  SubRowView.swift
//  SpeedX
//
//  Created by ehco on 2021/4/22.
//

import SwiftUI

struct SubRowView: View {
    let sub: Subscription

    var body: some View {

        VStack {
            HStack {
                Button(action: {
                    print("left button clicked")
                    // TODO 展开节点
                }, label: {
                    Image(systemName: "server.rack").imageScale(.large)
                })

                VStack(alignment: .leading) {
                    Text(sub.remark!).font(.title3)
                    Text(sub.url).font(.footnote).foregroundColor(.gray)
                }
                Spacer()
                Button(action: {
                    print("right button clicked")
                    // TODO 进入详情页
                }, label: {
                    Image(systemName: "pencil").imageScale(.large)
                })
            }

            List {
                ForEach(sub.nodesArray, id: \.id) { node in
                    Text(node.name)
                }
            }

        }
    }

}

struct SubRowView_Previews: PreviewProvider {

    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext

        let node = ProxyNode(context: context)
        node.id = 1
        node.name = "测试节点"

        let sub = Subscription.init(context: context)
        sub.remark = "1991.01.01"
        sub.url = "test.com"
        sub.addToNodes(node)

        return SubRowView(sub: sub)
    }
}
