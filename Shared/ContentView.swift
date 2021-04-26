//
//  ContentView.swift
//  Shared
//
//  Created by ehco on 2021/4/18.
//

import SwiftUI
import CoreData

struct ContentView: View {
	var body: some View {
		SubListView()
	}
}


struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
	}
}
