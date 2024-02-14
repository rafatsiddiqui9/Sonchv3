//
//  ContentView.swift
//  Sonchv3
//
//  Created by Rafat on 14/02/24.
//

import SwiftUI
import Alamofire
@_exported import Inject

struct ChatView: View {
    @ObservedObject var viewModel  = ViewModel()
    var body: some View {
        VStack {
          ScrollView {
              ForEach(viewModel.messages.filter({$0.role != .system}), id: \.id) { message in
                  messageView(message: message)
              }
          }
          HStack {
            TextField("Enter a message....", text: $viewModel.currentInput)
            Button {
                viewModel.sendMessage()
            } label: {
                Image(systemName: "paperplane")
            }
          }
        }
        .padding()
        .enableInjection()
    }
func messageView(message: Message) -> some View {
 HStack {
    if message.role == .user {Spacer()}
    Text(message.content)
         .padding()
         .background(message.role == .user ? Color.green : Color.gray.opacity(0.2))
         .cornerRadius(10)
    if message.role == .assistant {Spacer()}
 }
}
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
