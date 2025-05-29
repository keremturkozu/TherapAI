// TherapAIApp.swift
// App entry point for the therapy AI app.
// Shows EntryView as the main screen. MVVM/Core-Features structure.
// All UI is in English. Apple Design Tips are followed.

import SwiftUI

@main
struct TherapAIApp: App {
    var body: some Scene {
        WindowGroup {
            MainView() // Show the main navigation view
        }
    }
}
