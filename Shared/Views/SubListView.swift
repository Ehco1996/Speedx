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

    var scanQrcode: some View {
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
        HStack(alignment: .bottom) {
            Text("订阅列表")
            Spacer()
            Button(action: { self.editMode.toggle() }) {
                Text("...").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(.gray).bold()
            }
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            NavigationView {
                List {
                    Section(header: editButton) {
                        ForEach(subList, id: \.uid) { sub in
                            SubRowView(sub: sub)
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
                    ToolbarItem(placement: .navigationBarLeading) { scanQrcode }
                    ToolbarItem(placement: .principal) { title }
                    ToolbarItem(placement: .navigationBarTrailing) { addOrEdit }
                }.environment(\.editMode, self.$editMode)
                    .sheet(isPresented: $showDetail) {
                    SubDetailView(isPresented: $showDetail, navigationBarTitle: "添加订阅").environment(\.managedObjectContext, self.context)
                }
            }
                .navigationViewStyle(StackNavigationViewStyle())
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
