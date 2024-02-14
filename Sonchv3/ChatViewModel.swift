//
//  ChatViewModel.swift
//  Sonchv3
//
//  Created by Rafat on 14/02/24.
//

import Foundation

extension ChatView {
    class ViewModel: ObservableObject {
        @Published var messages: [Message] = [Message(id: UUID(), role: .user, content: "You are personal assistant expert in programming. You will only respond in Python", createAt: Date())]

        @Published var currentInput: String = ""
        
        private let openAIService = OpenAIService()
        
        func sendMessage() {
            let newMessage = Message(id: UUID(), role: .user, content: currentInput, createAt: Date())  
            messages.append(newMessage  )
            currentInput = ""

            Task {
                let response = await openAIService.sendMessage(messages: messages)
                guard let receivedOpenAIMessage = response.choices.first?.message else {
                    print("No message received from OpenAI")
                    return
                }
                let receivedMessage = Message(id: UUID(), role: receivedOpenAIMessage.role, content: receivedOpenAIMessage.content, createAt: Date())
                await MainActor.run {
                    messages.append(receivedMessage)
                }
            }
        }
    }
}

struct Message: Decodable {
    let id: UUID
    let role: SenderRole
    let content: String
    let createAt: Date
}
