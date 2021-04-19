//
//  SubView.swift
//  SpeedX
//
//  Created by ehco on 2021/4/18.
//

import SwiftUI

struct SubView: View {

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
                print("add button")
                showDetail = true
            }, label: {
                Image(systemName: "plus").imageScale(.large)
            }).sheet(isPresented: $showDetail, content: {
                SubDetailView(isPresented: $showDetail)
            })
        }
    }


    var body: some View {
        NavigationView {
            List {
//                NavigationLink(destination: SubDetailView()) {
//                    Text("url1")
//                }
                Text("url2")
                Text("url3")

            }.padding()
                .navigationTitle("订阅管理")
                .toolbar {
                ToolbarItem(placement: .navigationBarLeading) { qrcode }
                ToolbarItem(placement: .principal) { title }
                ToolbarItem(placement: .navigationBarTrailing) { add }
            }
        }
    }
}


struct SubView_Previews: PreviewProvider {
    static var previews: some View {
        SubView()
    }
}
