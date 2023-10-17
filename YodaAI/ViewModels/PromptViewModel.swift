//
//  PromptViewModel.swift
//  YodaAI
//
//  Created by felix ids on 17/10/2023.
//

import Foundation

enum PromptError {
    case emptyPrompt
    case networkError
}

@MainActor
class PromptViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var error: PromptError? = nil
    @Published var prompts: [Prompt] = []
    
    // this function receives the users prompt as a parameter and queries yoda ai for a reply
    func getPrompt(for prompt: String) async {
        guard !prompt.isEmpty else { return }
        isLoading = true
        error = nil
        
        // finally, set isloading to false
        defer {
            isLoading = false
        }
        
        print("going to search now")
        do {
            let prompt = try await PromptService.prompt(prompt: prompt)
            
            // The post request was successful.
            print("got response ")
            print(prompt.prompt)
            print(prompt.reply)
            
            prompts.append(prompt)
        } catch {
            // The post request failed.
            print(error)
            
            self.error = PromptError.networkError
        }
    }
    
}
