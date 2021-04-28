//
//  SubEditView.swift
//  SpeedX
//
//  Created by ehco on 2021/4/28.
//

import SwiftUI

struct SubEditView: View {
    let sub: Subscription
    @State var url: String = ""
    @State var remark: String = ""
    @State var showAlert: Bool = false

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) var context

    init(sub: Subscription) {
        self.sub = sub
        self._url = State(initialValue: sub.url)
        self._remark = State(initialValue: sub.remark!)
    }


    var saveButton: some View {

        Button(
            action: {
                print("save url: \(url)  remark: \(remark)")
                self.sub.url = url
                self.sub.remark = remark
                do {
                    // Save Managed Object Context
                    try context.save()
                    self.showAlert.toggle()
                } catch {
                    print("Unable to save managed object context.")
                }
                // 返回上一页的环境变量
                self.presentationMode.wrappedValue.dismiss()
            },
            label: {
                HStack {
                    Spacer()
                    Text("保存")
                    Spacer()
                }
            })
            .alert(isPresented: self.$showAlert) { Alert(title: Text("保存成功"), dismissButton: .none) }
    }

    var body: some View {
        VStack {
            Form {
                Section(header: Text("订阅配置")) {
                    TextField("订阅地址", text: $url)
                    TextField("备注", text: $remark)
                }
                saveButton
            }
        }
            .navigationBarTitle("编辑订阅")
    }
}







struct SubEditView_Previews: PreviewProvider {


    static var previews: some View {

        let context = PersistenceController.shared.container.viewContext

        let node = ProxyNode(context: context)
        node.id = 1
        node.name = "测试节点"

        let sub = Subscription.init(context: context)
        sub.remark = "1991.01.01"
        sub.url = "test.com"
        sub.addToNodes(node)

        return SubEditView(sub: sub)
    }
}
