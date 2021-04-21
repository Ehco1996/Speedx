//
//  SubView.swift
//  SpeedX
//
//  Created by ehco on 2021/4/18.
//

import SwiftUI

struct SubListView: View {

    @State private var showDetail = false
    @State private var editMode = EditMode.inactive

    @Environment(\.managedObjectContext) var context
    @FetchRequest(fetchRequest: Subscription.listAll()) var subList: FetchedResults<Subscription>
    init() {
        self._subList = FetchRequest(fetchRequest: Subscription.listAll())
    }

    var title: some View {
        HStack {
            Image(systemName: "bolt")
            Text("SpeedX").font(.headline)
        }
    }

    var ScanQrcodeOrDelete: some View {
        Button(action: {
            print("Message button was tapped")
        }) {
            Image(systemName: "viewfinder").imageScale(.large)
        }
    }


    private var addOrEdit: some View {
        switch self.editMode {
        case .active:
            return AnyView(EditButton())
        default:
            return AnyView(
                Button(action: {
                    print("click add button")
                    self.showDetail.toggle()
                }, label: {
                    Image(systemName: "plus").imageScale(.large)
                }))
        }
    }



    private var editButton: some View {
        Button(action: { }) {
            Text("...")
        }
    }

    var body: some View {
        NavigationView {
            List {
//                editButton()

                ForEach(subList, id: \.uid) { sub in
                    Text(sub.remark!)
                }.onDelete { indexSet in
                    indexSet.map { self.subList[$0] }.forEach { sub in
                        sub.delete(context: context)
                    }
                }
            }.navigationTitle("订阅管理")
                .toolbar {
                ToolbarItem(placement: .navigationBarLeading) { ScanQrcodeOrDelete }
                ToolbarItem(placement: .principal) { title }
                ToolbarItem(placement: .navigationBarTrailing) { addOrEdit }
            }.sheet(isPresented: $showDetail, content: {
                SubDetailView(isPresented: $showDetail, navigationBarTitle: "添加订阅").environment(\.managedObjectContext, self.context)
            })
                .environment(\.editMode, self.$editMode)
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
