//
//  EditDestinationView.swift
//  SwiftDataPractice
//
//  Created by Ray on 2024/11/9.
//

import SwiftData
import SwiftUI

struct EditDestinationView: View {
  @Bindable var destination: Destination
  @State private var newSightName: String = ""

  var body: some View {
    Form {
      TextField("Name", text: $destination.name)
      TextField("Details", text: $destination.details, axis: .vertical)
      DatePicker("Date", selection: $destination.date)
      
      Section("Priority") {
        Picker("Priority", selection: $destination.priority) {
          Text("Meh").tag(1)
          Text("Maybe").tag(2)
          Text("Must").tag(3)
        }
        .pickerStyle(.segmented)
      }
      
      Section("Sight") {
        ForEach(destination.sights) { sight in
          Text(sight.name)
        }
        
        HStack {
          TextField("Add new sight in \(destination.name)", text: $newSightName)
          
          Button("Add sight", action: addSight)
        }
      }
    }
    .navigationTitle("Edit Destination")
    .navigationBarTitleDisplayMode(.inline)
  }
  
  private func addSight() {
    guard newSightName.isEmpty == false else { return }
    let sight = Sight(name: newSightName)
    destination.sights.append(sight)
    newSightName = ""
  }
}

#Preview {
  let config = ModelConfiguration(isStoredInMemoryOnly: true)
  let container = try! ModelContainer(for: Destination.self, configurations: config)
  let example = Destination(
    name: "Example",
    details:
      "Day handsome addition horrible sensible goodness two contempt. Evening for married his account removal. Estimable me disposing of be moonlight cordially curiosity. Delay rapid joy share allow age manor six. Went why far saw many knew. Exquisite excellent son gentleman acuteness her. Do is voice total power mr ye might round still."
  )
  
  EditDestinationView(destination: example)
    .modelContainer(container)
}
