//
//  SelectedFoodView.swift
//  SpeedX
//
//  Created by ehco on 2022/10/9.
//

import SwiftUI

struct SelectedFoodView: View {

    let food = ["1", "2", "3", "12312312"]
    @State private var selectedfood: String?

    var body: some View {
        VStack(spacing: 30) {
            Image("rock")
                .resizable()
                .aspectRatio(contentMode: .fit)

            Text("今天吃什么？").font(.largeTitle).bold()

            if selectedfood != .none {
                Text(selectedfood ?? "")
                    .font(.title)
            }

            Button(role: .none, action: {
                selectedfood = food.shuffled().first
            }) {
                Text(selectedfood == .none ? "告诉我" : "换一个")
                    .frame(width: 200)
                    .animation(.none, value: selectedfood)
                    .transformEffect(.identity)
            }
                .padding(.bottom, -15)

            Button(role: .none, action: {
                selectedfood = .none
            }) {
                Text("重置").frame(width: 200)
            }
                .buttonStyle(.bordered)

        }
            .padding()
            .frame(maxHeight: .infinity)
            .background(Color(.secondarySystemBackground))
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .font(.title)
            .animation(.easeInOut(duration: 1), value: selectedfood)// food 发生变化的时候，会产生动画
    }
}

struct SelectedFoodView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedFoodView()
    }
}
