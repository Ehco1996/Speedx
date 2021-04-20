//
//  SubView.swift
//  SpeedX
//
//  Created by ehco on 2021/4/18.
//

import SwiftUI

struct SubListView: View {

    var title: some View {
        HStack {
            Image(systemName: "bolt")
            Text("SpeedX").font(.headline)
        }
    }

    var qrcode: some View {
        Button(action: {
            print("Message button was tapped")
        }) {
            Image(systemName: "viewfinder").imageScale(.large)
        }
    }

    @State private var showDetail = false
    var add: some View {
        VStack {
            Button(action: {
                print("click add button")
                self.showDetail.toggle()
            }, label: {
                Image(systemName: "plus").imageScale(.large)
            })
        }
    }

    @Environment(\.managedObjectContext) var context
    @FetchRequest(fetchRequest: Subscription.listAll()) var subList: FetchedResults<Subscription>
    init() {
        self._subList = FetchRequest(fetchRequest: Subscription.listAll())
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(subList, id: \.uid) { sub in
                    Text(sub.uid.uuidString)
                }
            }.navigationTitle("订阅管理")
                .toolbar {
                ToolbarItem(placement: .navigationBarLeading) { qrcode }
                ToolbarItem(placement: .principal) { title }
                ToolbarItem(placement: .navigationBarTrailing) { add }
            }.sheet(isPresented: $showDetail, content: {
                SubDetailView(isPresented: $showDetail, navigationBarTitle: "添加订阅").environment(\.managedObjectContext, self.context)
            })
        }
    }
}


struct SubView_Previews: PreviewProvider {
    @Environment(\.managedObjectContext) var context
    @FetchRequest var subList: FetchedResults<Subscription>
    static var previews: some View {
        SubListView()
    }
}
