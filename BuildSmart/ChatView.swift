//
//  ChatbotView.swift
//  BuildSmart
//
//  Created by apple on 10/04/25.
//

import SwiftUI

// MARK: - ChatView View
struct ChatView: View {
    @State private var messages: [ChatMessage] = []
    @State private var inputText: String = ""
    @State private var isTyping: Bool = false
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(messages, id: \ .self) { message in
                            HStack {
                                if message.isUser { Spacer() }
                                if !message.isUser {
                                    Text("AI")
                                        .padding(5)
                                        .foregroundColor(.white)
                                        .background(Circle()
                                            .fill(Color.blue)
                                            .frame(width: 30, height: 30)
                                        )
                                }
                                handleText(message.isUser, text: message.text)
                                if !message.isUser { Spacer() }
                            }
                        }
                    }.padding()
                    
                    if isTyping {
                        HStack {
                            Text("AI is typing...")
                                .italic()
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        .padding()
                    }
                }
                .onChange(of: messages.count) {
                    if let lastMessage = messages.last {
                        proxy.scrollTo(lastMessage.id, anchor: .bottom)
                    }
                }
            }
            HStack {
                TextField("Ask me anything...", text: $inputText)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal, 10)
                
                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .padding(.top, 10)
    }
    
    @ViewBuilder func handleText(_ isUser: Bool, text: String) -> some View {
        Text(text)
            .padding(10)
            .background( isUser ? Color.blue.opacity(0.1) : Color.gray.opacity(0.1))
            .foregroundColor(.primary)
            .cornerRadius(10)
            .frame(maxWidth: .infinity, alignment: isUser ? .trailing : .leading)
    }
}

extension ChatView {
    func sendMessage() {
        guard !inputText.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        
        let userMessage = ChatMessage(text: inputText, isUser: true)
        messages.append(userMessage)
        inputText = ""
        isTyping = true
        
        ChatService.getAIResponse(for: userMessage.text) { response in
            DispatchQueue.main.async {
                isTyping = false
                if let reply = response {
                    let botMessage = ChatMessage(text: reply, isUser: false)
                    messages.append(botMessage)
                } else {
                    let errorMessage = ChatMessage(text: "Sorry, I couldn’t understand that.", isUser: false)
                    messages.append(errorMessage)
                }
            }
        }
    }
}

#Preview {
    ChatView()
}
