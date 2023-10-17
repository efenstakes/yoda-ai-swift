//
//  PromptService.swift
//  YodaAI
//
//  Created by felix ids on 17/10/2023.
//

import Foundation

class PromptService {
    
    // fetch prompt reply
    static func prompt(prompt: String) async throws -> Prompt {
        var urlRequest = URLRequest(url: URL(string: "https://xqwbyqql42.execute-api.us-west-1.amazonaws.com/prompts")!)
        
        // Set the HTTP method to POST.
        urlRequest.httpMethod = "POST"

        // Set the HTTP headers.
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Encode the prompt object to JSON data.
        let jsonData = try? JSONEncoder().encode(Prompt(prompt: prompt, reply: ""))

        // Set the HTTP request body to the JSON data.
        urlRequest.httpBody = jsonData

        // Create a URLSession object.
        let urlSession = URLSession.shared

        // Make the post request and await the response.
        let (data, response) = try await urlSession.data(for: urlRequest)

        // Check the response status code.
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode < 300 else {
            throw URLError(.badServerResponse)
        }

        // Decode the response data to a Response object.
        let responseObject = try JSONDecoder().decode(Prompt.self, from: data)

        // Return the response object.
        return responseObject
    }
    
}
