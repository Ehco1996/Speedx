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
                    .border(Color.red)

                VStack(alignment: .leading) {
                    Text(sub.remark!).font(.title3)
                    Text(sub.url).font(.footnote).foregroundColor(.gray)
                }
                    .border(Color.red)

                Spacer()


                ZStack {
                    Button(action: {
                        print("right button clicked")
                        self.isLinkToEditActive.toggle()
                        // TODO 进入详情页
                    }, label: {
                            Image(systemName: "pencil").imageScale(.large)
                        })
                        .border(Color.red)
                    NavigationLink(destination: SubEditView(sub: sub), isActive: $isLinkToEditActive) { }.frame(width: 0).opacity(0)
                }
            }

            if self.showNodeList {
                ForEach(sub.nodesArray, id: \.id) { node in

                    HStack {
                        Text(String(node.id))
                        Text(node.name)
                        Rectangle().fill(Color.blue)
                    }


                }.transition(.opacity)
            }
        }.buttonStyle(BorderlessButtonStyle())
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
