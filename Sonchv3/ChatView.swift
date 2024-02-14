//
//  ContentView.swift
//  Sonchv3
//
//  Created by Rafat on 14/02/24.
//

import SwiftUI
import Alamofire
@_exported import Inject

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .enableInjection()
    }
}

#Preview {
    ContentView()
}
