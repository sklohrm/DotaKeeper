//
//  CachedImageManager.swift
//  DotaKeeper
//
//  Created by Spencer Lohrmann on 9/26/22.
//

import Foundation

final class CachedImageManager: ObservableObject {

    @Published private(set) var currentState: CurrentState?

    private let imageRetriever = ImageRetriever()

    @MainActor
    func load(_ imageURL: String, cache: ImageCache = .shared) async {

        self.currentState = .loading

        if let imageData = cache.object(forKey: imageURL as NSString) {
            self.currentState = .success(data: imageData)
            return
        }

        do {
            let data = try await imageRetriever.fetch(imageURL)
            self.currentState = .success(data: data)
            cache.set(object: data as NSData, forKey: imageURL as NSString)
        } catch {
            self.currentState = .failed(error: error)
        }
    }
}

extension CachedImageManager {
    enum CurrentState {
        case loading
        case failed(error: Error)
        case success(data: Data)
    }
}

extension CachedImageManager.CurrentState: Equatable {
    static func == (lhs: CachedImageManager.CurrentState,
                    rhs: CachedImageManager.CurrentState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (let .failed(lhsError), let .failed(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case (let .success(lhsData), let .success(rhsData)):
            return lhsData == rhsData
        default:
            return false
        }
    }
}
