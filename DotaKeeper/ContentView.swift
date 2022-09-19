//
//  ContentView.swift
//  DotaKeeper
//
//  Created by Spencer Lohrmann on 9/18/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Content()
    }
}

extension ContentView {
    struct Content: View {
        @State private var tab = Tab.profile

        var body: some View {
            TabView(selection: $tab) {
                Text("Glossary")
                    .tabItem {
                        Image(systemName: "book.closed.fill")
                        Text("Glossary")
                    }
                    .tag(Tab.glossary)
                SavedView()
                    .tabItem {
                        Image(systemName: "bookmark.fill")
                        Text("Saved")
                    }
                    .tag(Tab.saved)
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                    .tag(Tab.profile)
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass.circle.fill")
                        Text("Search")
                    }
                    .tag(Tab.search)
                SettingsView()
                    .tabItem {
                        Image(systemName: "gearshape.fill")
                        Text("Settings")
                    }
                    .tag(Tab.settings)
            }
        }
    }
}

extension ContentView.Content {
    enum Tab: String, CaseIterable, Identifiable {
        case search
        case saved
        case profile
        case glossary
        case settings

        var id: Self { self }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
