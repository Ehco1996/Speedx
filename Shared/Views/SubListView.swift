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

    private var addButton: some View {
        Button(action: {
            print("click add button")
            self.showDetail.toggle()
        }, label: {
                Image(systemName: "plus").imageScale(.large)
            })
    }


    private var editButton: some View {
        HStack(alignment: .bottom) {
            Text("订阅列表")

            Spacer()
            Button(action: { self.editMode.toggle() }) {
                switch self.editMode {
                case .active:
                    Text("done").foregroundColor(.gray).bold()
                default:
                    Text("...").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(.gray).bold()
                }
            }
        }
    }

    @ViewBuilder
    func sectiondSubRow(sub: Subscription) -> some View {
        // NOTE: 只有第一个格子有title和editbutton,最后一个格子有footer
        if sub == self.subList.first {
            Section(header: editButton) {
                SubRowView(sub: sub)
            }
        } else if sub == self.subList.last {
            Section(footer: Text("只会测试当前展开订阅组里的节点")) {
                SubRowView(sub: sub)
            }
        } else {
            Section() {
                SubRowView(sub: sub)
            }
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            NavigationView {
                List {
                    ForEach(subList, id: \.uid) { sub in
                        sectiondSubRow(sub: sub)
                    }
                        .onDelete { indexSet in
                        indexSet.map { self.subList[$0] }.forEach { sub in
                            sub.delete(context: context)
                        }
                    }
                }
                    .navigationTitle("订阅管理")
                    .listStyle(GroupedListStyle())
                    .environment(\.editMode, self.$editMode)
                    .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) { scanQrcode }
                    ToolbarItem(placement: .principal) { title }
                    ToolbarItem(placement: .navigationBarTrailing) { addButton } }
                    .sheet(isPresented: $showDetail) { SubNewView(isPresented: $showDetail).environment(\.managedObjectContext, self.context)
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
