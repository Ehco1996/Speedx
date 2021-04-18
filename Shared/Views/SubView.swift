//
//  SubView.swift
//  SpeedX
//
//  Created by ehco on 2021/4/18.
//

import SwiftUI

struct SubView: View {

    var body: some View {
        NavigationView {
            List {
                Text("url1")
                Text("url2")
                Text("url3")

            }.padding()
                .navigationTitle("订阅管理")
                .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button(action: {
                        print("Message button was tapped")
                    }) {
                        Image(systemName: "viewfinder").imageScale(.large)
                    }
                }
                ToolbarItem(placement: .principal) {
                    HStack {
                        Image(systemName: "bolt")
                        Text("SpeedX").font(.headline)
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: { print("plus added") }, label: {
                        Image(systemName: "plus").imageScale(.large)
                    })
                }
            }
        }
    }
}


struct SubView_Previews: PreviewProvider {
    static var previews: some View {
        SubView()
    }
}
