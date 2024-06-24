//
//  NewView.swift
//  BWHealthApp
//
//  Created by Himalaya Rajput on 21/06/24.
//

import SwiftUI

//struct NewView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}

struct ContentView: View {
//  let options = ["Frida Kahlo", "Georgia O'Keeffe", "Mary Cassatt", "Lee Krasner", "Helen Frankenthaler"]
//  @State private var selectedOption = 0
//
//  var body: some View {
//    VStack {
//      HStack {
//        Image(systemName: "paintpalette")
//          .foregroundColor(.blue)
//          .padding(.trailing, 4)
//
//        Text("Favorite artist:")
//          .font(.title)
//
//        Text(options[selectedOption])
//          .font(.title)
//          .padding(.leading, 4)
//      }
//      .padding()
//
//      Picker("Options", selection: $selectedOption) {
//        ForEach(options.indices, id: \.self) { index in
//          Text(options[index])
//            .font(.headline)
//        }
//      }
//      .pickerStyle(.wheel)
//      .padding()
//    }
//  }
    var colors = ["Red", "Green", "Blue", "Tartan"]
    @State private var selectedColor: String
    init() {
        selectedColor = colors[0]
    }

      var body: some View {
          GeometryReader { geo in
              VStack {
                  Picker("Please choose a color", selection: $selectedColor) {
                      ForEach(colors, id: \.self) {
                          Text($0)
                      }
                  }.pickerStyle(.wheel)
                  Text("You selected: \(selectedColor)")
              }
          }
      }
}

#Preview {
    ContentView()
}
