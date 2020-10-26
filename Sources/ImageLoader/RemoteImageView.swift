//
//  RemoteImageView.swift
//  DemoFramework
//
//  Created by Aline Arely Ordonez Garcia on 30/09/20.
//

import SwiftUI

@available(iOS 14.0, *)
public struct RemoteImageView<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: Placeholder
    
    public init(url: URL, @ViewBuilder placeholder: () -> Placeholder) {
        self.placeholder = placeholder()
        _loader = StateObject(wrappedValue: ImageLoader(url))
    }
    
    public var body: some View {
        content
            .onAppear(perform: loader.load)
    }
    
    private var content: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .clipped()
            } else {
                placeholder
            }
        }
    }
}
