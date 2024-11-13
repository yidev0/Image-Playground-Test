//
//  Image_Playground_TestApp.swift
//  Image Playground Test
//
//  Created by Yuto on 2024/11/05.
//

import SwiftUI

@main
struct Image_Playground_TestApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        
        WindowGroup("Result", id: "Image", for: URL.self) { url in
            ZStack {
                if let url = url.wrappedValue {
#if canImport(AppKit)
                    if let image = NSImage(data: .init(try! Data(contentsOf: url))) {
                        Image(nsImage: image)
                            .resizable()
                    }
#else
                    if let image = UIImage(data: .init(try! Data(contentsOf: url))) {
                        Image(uiImage: image)
                            .resizable()
                    }
#endif
                } else {
                    ContentUnavailableView("Image not available", systemImage: "photo")
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .frame(
                minWidth: 200,
                idealWidth: 200,
                minHeight: 200,
                idealHeight: 200
            )
            .aspectRatio(1, contentMode: .fit)
        }
        .windowIdealSize(.fitToContent)
        .windowResizability(.contentMinSize)
    }
}
