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


    // 控制是否展示的
    @Binding var isPresented: Bool
    init(isPresented: Binding<Bool>) {
        _isPresented = isPresented
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("订阅配置")) {
                    TextField("订阅地址", text: $url)
                    TextField("备注", text: $remark)
                }
            }
                .navigationBarTitle("添加/编辑订阅")
                .navigationBarItems(leading: cancel, trailing: done)
        }
    }


    var cancel: some View {
        Button(action: { self.isPresented = false }) {
            Image(systemName: "chevron.backward").imageScale(.large) }
    }

    var done: some View {
        Button(action: { self.isPresented = false }) {
            Image(systemName: "checkmark").imageScale(.large) }
    }
}


//struct SubDetailView_Previews: PreviewProvider {
//    @State private var showDetail = true
//
//    static var previews: some View {
//        SubDetailView(isPresented: $showDetail)
//    }
//}

