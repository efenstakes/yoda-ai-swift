//
//  Prompt.swift
//  YodaAI
//
//  Created by felix ids on 17/10/2023.
//

import Foundation


struct Prompt: Codable, Identifiable {
    var id: String = UUID().uuidString
    var prompt: String
    var reply: String
}

// for initial testing
var prompts: [Prompt] = [
    
    Prompt(prompt: "hello", reply: "Hello, how may I help you?"),
    Prompt(prompt: "hello", reply: "Hello, how may I help you?"),
    Prompt(prompt: "hello", reply: "Hello, how may I help you?"),
    Prompt(prompt: "hello", reply: "Hello, how may I help you?"),
    Prompt(prompt: "hello", reply: "Hello, how may I help you?"),
]
