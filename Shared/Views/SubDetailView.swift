//
//  SubDetailView.swift
//  SpeedX
//
//  Created by ehco on 2021/4/19.
//

import SwiftUI

struct SubDetailView: View {
    @State var url: String = ""
    @State var remark: String = ""
    @State private var showSaveAlert = false
    @Environment(\.managedObjectContext) var context

    private var navigationBarTitle: String
    // 控制是否展示的
    @Binding var isPresented: Bool
    init(isPresented: Binding<Bool>, navigationBarTitle: String) {
        self._isPresented = isPresented
        self.navigationBarTitle = navigationBarTitle
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("订阅配置")) {
                    TextField("订阅地址", text: $url)
                    TextField("备注", text: $remark)
                }
            }
                .navigationBarTitle(self.navigationBarTitle)
                .navigationBarItems(leading: cancel, trailing: done)
        }
    }


    var cancel: some View {
        Button(action: { self.isPresented = false }) {
            Image(systemName: "chevron.backward").imageScale(.large) }
    }

    var done: some View {
        Button(action: {
            Subscription.create(url: url, remark: remark, context: context)
            self.showSaveAlert.toggle()
        },
               label: {
                   Image(systemName: "checkmark").imageScale(.large)
               }
        ).alert(isPresented: $showSaveAlert, content: {
            Alert(title: Text("保存成功"), dismissButton: .default(Text("Ok")) {
                self.isPresented.toggle()
            })
        })
    }
}



//struct SubDetailView_Previews: PreviewProvider {
//    @State private var showDetail = true
//
//    static var previews: some View {
//        SubDetailView(isPresented: $showDetail)
//    }
//}

