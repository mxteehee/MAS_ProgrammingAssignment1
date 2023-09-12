//
//  MAS_P1_MeenaAjithApp.swift
//  MAS_P1_MeenaAjith
//
//

import SwiftUI
import Firebase

@main
struct MAS_P1_MeenaAjithApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
