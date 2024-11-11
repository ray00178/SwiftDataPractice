//
//  SwiftDataPracticeApp.swift
//  SwiftDataPractice
//
//  Created by Ray on 2024/11/6.
//

import SwiftUI

@main
struct SwiftDataPracticeApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
    .modelContainer(for: Destination.self)
  }
}
