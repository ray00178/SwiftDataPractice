//
//  ContentView.swift
//  SwiftDataPractice
//
//  Created by Ray on 2024/11/6.
//

import SwiftData
import SwiftUI

struct ContentView: View {
  @Environment(\.modelContext) var modelContext

  @State private var path = [Destination]()
  @State private var sortOrder = SortDescriptor(\Destination.name)
  @State private var searchKeyword = ""
  
  var body: some View {
    NavigationStack {
      DestinationListingView(sort: sortOrder, keyword: searchKeyword)
        .navigationTitle("iTour")
        .navigationDestination(
          for: Destination.self, destination: EditDestinationView.init
        )
        .searchable(text: $searchKeyword, prompt: "關鍵字搜尋")
        .toolbar {
          Button("Add Samples", action: addSamples)
          Button("Add Destination", systemImage: "plus", action: addDestination)
          
          Menu("Sort", systemImage: "arrow.up.arrow.down") {
            Picker("Sort", selection: $sortOrder) {
              Text("Name")
                .tag(SortDescriptor(\Destination.name))
              
              Text("Priority")
                .tag(SortDescriptor(\Destination.priority, order: .reverse))
              
              Text("Date")
                .tag(SortDescriptor(\Destination.date))
            }
            .pickerStyle(.inline)
          }
        }
    }
  }

  private func addSamples() {
    let taipei = Destination(name: "Taipei")
    let tainan = Destination(name: "Tainan")
    let kaoshiung = Destination(name: "Kaohsiung")

    modelContext.insert(taipei)
    modelContext.insert(tainan)
    modelContext.insert(kaoshiung)
  }

  private func addDestination() {
    let destination = Destination()
    modelContext.insert(destination)
    path = [destination]
  }

}

#Preview {
  ContentView()
}
