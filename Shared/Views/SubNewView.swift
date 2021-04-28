//
//  SubDetailView.swift
//  SpeedX
//
//  Created by ehco on 2021/4/19.
//

import SwiftUI

struct SubNewView: View {
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



struct SubDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SubNewView(isPresented: Binding.constant(true))
    }
}

