//
//  DestinationListingView.swift
//  SwiftDataPractice
//
//  Created by Ray on 2024/11/10.
//

import SwiftData
import SwiftUI

struct DestinationListingView: View {
  
  @Environment(\.modelContext) var modelContext
  
  // @Query var destinations: [Destination]
  // @Query(sort: \Destination.name, order: .reverse) var destinations: [Destination]
  @Query(sort: [
    SortDescriptor(\Destination.priority, order: .forward),
    SortDescriptor(\Destination.name),
  ]) var destinations: [Destination]

  init(sort: SortDescriptor<Destination>, keyword: String) {
    _destinations = Query(filter: #Predicate {
      if keyword.isEmpty {
        return true
      } else {
        return $0.name.localizedStandardContains(keyword)
      }
    }, sort: [sort])
  }
  
  var body: some View {
    List {
      ForEach(destinations) { destination in
        NavigationLink(value: destination) {
          VStack(alignment: .leading) {
            Text(destination.name)
              .font(.headline)

            Text(destination.date.formatted(date: .long, time: .shortened))
          }
        }
      }
      .onDelete(perform: deleteDestinations)
    }
  }
  
  private func deleteDestinations(_ indexSet: IndexSet) {
    for index in indexSet {
      let destination = destinations[index]
      modelContext.delete(destination)
    }
  }
}

#Preview {
  DestinationListingView(sort: SortDescriptor(\Destination.name), keyword: "")
}
