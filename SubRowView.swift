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
    }
}

struct SubRowView_Previews: PreviewProvider {

    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        let sub = Subscription.init(context: context)
        sub.url = "1996.02.02"
        sub.remark = "mizhiwu.text"
        return SubRowView(sub: sub)
    }
}
