//
//  SubRowView.swift
//  SpeedX
//
//  Created by ehco on 2021/4/22.
//

import SwiftUI

struct SubRowView: View {
    let sub: Subscription
    @State private var showNodeList = false
    @State var isLinkToEditActive = false
    @State private var showEditAlert = false

    @Environment(\.defaultMinListRowHeight) var minRowHeight
    func nodeCell(node: ProxyNode) -> some View {
        VStack {
            Divider()
            HStack {
                Image(systemName: "flag")
                Text(node.name)
                Spacer()
                Text("45ms")
                    .foregroundColor(.green)
            }
            Divider()
        }
    }

    var body: some View {

        VStack {
            HStack {
                Button(action: {
                    print("left button clicked", sub.nodesArray.count)
                    withAnimation {
                        self.showNodeList.toggle()
                    }
                }, label: {
                        Image(systemName: "server.rack").imageScale(.large)
                    })

                VStack(alignment: .leading) {
                    Text(sub.remark!).font(.title3)
                    Text(sub.url).font(.footnote).foregroundColor(.gray)
                }

                Spacer()

                // 点击进入详情界面的按钮
                Button(
                    action: { self.isLinkToEditActive.toggle() },
                    label: { Image(systemName: "pencil").imageScale(.large) })
                // NOTE: 把NavigationLink的area隐藏，只通过按钮进入详情界面
                NavigationLink(destination: SubEditView(sub: sub, showAlert: self.$showEditAlert), isActive: $isLinkToEditActive) { EmptyView() }
                    .frame(width: 0, height: 0).hidden().disabled(true)

            }
            if self.showNodeList {
                ForEach(sub.nodesArray, id: \.id) { node in
                    nodeCell(node: node) }
            }
        }
            .buttonStyle(BorderlessButtonStyle())
            .alert(isPresented: self.$showEditAlert, content: {
            Alert(title: Text("保存成功"))
        })
    }

}

struct SubRowView_Previews: PreviewProvider {

    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext

        let node1 = ProxyNode(context: context)
        node1.id = 1
        node1.name = "测试节点1"

        let node2 = ProxyNode(context: context)
        node2.id = 2
        node2.name = "测试节点2"

        let sub = Subscription.init(context: context)
        sub.remark = "1991.01.01"
        sub.url = "test.com"
        sub.addToNodes(node1)
        sub.addToNodes(node2)

        return SubRowView(sub: sub)
    }
}
