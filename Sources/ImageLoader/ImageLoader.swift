//
//  ImageLoader.swift
//  DemoFramework
//
//  Created by Aline Arely Ordonez Garcia on 30/09/20.
//

import SwiftUI
import Combine
import Foundation

@available(iOS 13.0, *)
public class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let url: URL
    private var cancellable: AnyCancellable?
    
    init(_ url: URL) {
        self.url = url
    }
    
    deinit {
        cancel()
    }
    
    func load() {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }
    
    func cancel() {
        cancellable?.cancel()
    }
}
