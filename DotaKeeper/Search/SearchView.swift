//
//  SearchView.swift
//  DotaKeeper
//
//  Created by Spencer Lohrmann on 9/18/22.
//

import SwiftUI

struct SearchView: View {

    @State private var text: String = ""
    @State private var pickerState = SearchPickerState.heroes
    @State private var isPresented: Bool = false
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        VStack {
            // SearchBarView(pickerState: $pickerState)
            TextField("Search", text: $text)
                .onSubmit {
                    Task {
                        await viewModel.searchPlayersAsync(withName: text)
                    }
                }
            ZStack {
                if viewModel.isRefreshing {
                    VStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                } else {
                    List {
                        ForEach(viewModel.players) { player in
                            PlayerView(player: player)
                                .listRowSeparator(.hidden)
                        }
                        .onTapGesture {
                            isPresented.toggle()
                        }
                        .fullScreenCover(isPresented: $isPresented) {
                            DetailView()
                        }
                    }
                    .listStyle(.plain)
                }
            }
        }
    }
}

// MARK: - Placeholder Views

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

struct PlayerView: View {
    let player: Player

    var body: some View {
        VStack(alignment: .leading) {
            CachedImage(url: player.avatarFull) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    VStack {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
//                            .padding()
//                            .background(.blue, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                case .failure(error: _):
                    VStack {
                        Image(systemName: "xmark")
                            .symbolVariant(.circle.fill)
                            .foregroundStyle(.white)
                            .frame(width: 100, height: 100)
                            .background(.blue, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                @unknown default:
                    EmptyView()
                }
            }
            Text("Account ID: \(player.accountID)")
            Text("Persona Name: \(player.personaName)")
            Text("Avatar Full: \(player.avatarFull)")
            Text("Last Match Time: \(player.playerLastMatch)")
            Text("Similarity: \(player.similarity)")

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
