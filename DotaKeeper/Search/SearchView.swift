//
//  SearchView.swift
//  DotaKeeper
//
//  Created by Spencer Lohrmann on 9/18/22.
//

import SwiftUI

struct SearchView: View {

    var body: some View {
        Content()
    }
}

// MARK: - Content
extension SearchView {
    struct Content: View {
        @State private var searchText: String = ""
        @State private var pickerState = SearchPickerState.heroes
        @State private var isPresented: Bool = false

        var body: some View {
            VStack {
                TopBarView(pickerState: $pickerState)
                ScrollView {
                    ForEach(1...100, id: \.self) { index in
                        Text("\(pickerState.rawValue) \(index)")
                            .padding()
                            .frame(maxWidth: .infinity)
                    }
                    .onTapGesture {
                        isPresented.toggle()
                    }
                    .fullScreenCover(isPresented: $isPresented) {
                        DetailView()
                    }
                }
            }
        }
    }
}

// Placeholder
struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Text("Go Back")
                        .padding()
                }
            }
            ScrollView {
                ForEach(1...100, id: \.self) { index in
                    Text("\(index)")
                        .padding()
                }
            }
        }
    }
}

enum SearchPickerState: String, PickerEnum {
    case players = "Players"
    case matches = "Matches"
    case heroes = "Heroes"

    var id: Self { self }

    @ViewBuilder
    var body: some View {
        switch self {
        case .players:
            PlayerFilter()
        case .matches:
            MatchFilter()
        case .heroes:
            HeroFilter()
        }
    }
}

enum GlossaryPickerState: String, PickerEnum {
    case heroes = "Heroes"
    case items = "Items"

    var id: Self { self }

    @ViewBuilder
    var body: some View {
        switch self {
        case .heroes:
            HeroFilter()
        case .items:
            ItemFilter()
        }
    }
}

protocol PickerEnum: CaseIterable, Identifiable, Hashable, RawRepresentable, View {}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
