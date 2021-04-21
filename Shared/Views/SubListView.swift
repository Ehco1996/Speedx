//
//  SubView.swift
//  SpeedX
//
//  Created by ehco on 2021/4/18.
//

import SwiftUI

extension EditMode {
    mutating func toggle() {
        self = self == .active ? .inactive : .active
    }
}

struct SubListView: View {

    @State private var showDetail = false
    @State private var editMode: EditMode = .inactive
    @State private var selection: String?

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
        HStack {
            Text("订阅列表")
            Spacer()
            Button(action: { self.editMode.toggle() }) {
                Image(systemName: "square.and.pencil").imageScale(.large)
            }
        }
    }

    var body: some View {
        NavigationView {
            List {
                Section(header: editButton) {
                    ForEach(subList, id: \.uid) { sub in
                        Text(sub.remark!)
                    }.onDelete { indexSet in
                        indexSet.map { self.subList[$0] }.forEach { sub in
                            sub.delete(context: context)
                        }
                    }
                }
            }
                .listStyle(GroupedListStyle())
                .navigationTitle("订阅管理")
                .toolbar {
                ToolbarItem(placement: .navigationBarLeading) { ScanQrcodeOrDelete }
                ToolbarItem(placement: .principal) { title }
                ToolbarItem(placement: .navigationBarTrailing) { addOrEdit }
            }.environment(\.editMode, self.$editMode)
                .sheet(isPresented: $showDetail) {
                SubDetailView(isPresented: $showDetail, navigationBarTitle: "添加订阅").environment(\.managedObjectContext, self.context)
            }
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
