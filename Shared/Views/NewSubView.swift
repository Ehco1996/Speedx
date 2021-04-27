//
//  SubDetailView.swift
//  SpeedX
//
//  Created by ehco on 2021/4/19.
//

import SwiftUI

struct NewSubView: View {
    @Environment(\.managedObjectContext) var context

    @State var url: String = ""
    @State var remark: String = ""

    @State private var alertTitle = "保存成功"
    @State private var showSaveAlert = false

    // 控制是否展示的
    @Binding var isPresented: Bool
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("订阅配置")) {
                    TextField("订阅地址", text: $url)
                    TextField("备注", text: $remark)
                }
            }
                .navigationBarTitle("添加订阅")
                .navigationBarItems(leading: cancel, trailing: done)
        }
    }

    var cancel: some View {
        Button(action: { self.isPresented = false }) {
            Image(systemName: "chevron.backward").imageScale(.large) }
    }

    var done: some View {
        Button(action: {
            if (Subscription.create(context: context, url: url, remark: remark) == nil) {
                self.alertTitle = "保存失败url:\(url)"
            }
            self.showSaveAlert.toggle() },
            label: {
                Image(systemName: "checkmark").imageScale(.large)
            }
        ).alert(isPresented: $showSaveAlert, content: {
            Alert(title: Text(self.alertTitle), dismissButton: .default(Text("Ok")) {
                    self.isPresented.toggle()
                })
        })
    }
}


struct SubEditView: View {
    let sub: Subscription
    @State var url: String = ""
    @State var remark: String = ""

    init(sub: Subscription) {
        self.sub = sub
        self._url = State(initialValue: sub.url)
        self._remark = State(initialValue: sub.remark!)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("订阅配置")) {
                    TextField("订阅地址", text: $url)
                    TextField("备注", text: $remark)
                }
            }
                .navigationBarTitle("编辑订阅")
        }
    }
}



struct SubDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NewSubView(isPresented: Binding.constant(true))
    }
}

