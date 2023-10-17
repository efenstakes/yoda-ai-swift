//
//  PromptView.swift
//  YodaAI
//
//  Created by felix ids on 17/10/2023.
//

import SwiftUI

struct PromptView: View {
    @State var currentPrompt = ""
    @StateObject var promptVM: PromptViewModel = PromptViewModel()
    
    
    var body: some View {
        VStack(alignment: .leading) {
            
            if !promptVM.prompts.isEmpty {
                ScrollView {

                    VStack(alignment: .leading, spacing: 32) {
                        
                        ForEach(promptVM.prompts) { prompt in
                            
                            PromptCard(prompt: prompt)
                            
                        }
                        
                        if promptVM.isLoading {
                            
                            HStack {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: Color(hex: "486966")))
                                    .frame(alignment: .center)
                            }
                            .frame(width: UIScreen.main.bounds.width - 20)
                            .padding(.top)
                        }
                    }
                    .padding()
                    
                }
            }
            
            if promptVM.prompts.isEmpty {
                ContentUnavailableView("No Prompts", systemImage: "hourglass.circle", description: Text("You don't have any prompts yet. Ask Yoda anything.."))
                    .symbolVariant(.slash)
            }

            
            
            HStack {
                
                // search field
                TextField(text: $currentPrompt, prompt: Text("Ask anything..")) {
                    Text("hola")
                }
                .padding()
                
                Group {
                    // start search button
                    if promptVM.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color(hex: "486966")))
                    }
                    
                    if !promptVM.isLoading {
                        
                        Button(action: {
                            
                            print("search prompt for \(currentPrompt)")
                            Task {
                                await promptVM.getPrompt(for: currentPrompt)
                                currentPrompt = ""
                            }
                            
                        }, label: {
                            Image(systemName: "paperplane")
                        })
                        .rotationEffect(.degrees(0))
                        .disabled(currentPrompt.isEmpty)
                    }
                }
                .padding()
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .rotationEffect(.degrees(45))
                .disabled(currentPrompt.isEmpty)
                
            }
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.gray, lineWidth: 2)
            )
            .padding(.horizontal)
            
            
        }
        .onAppear {
            print("hola we online")
        }
        .navigationTitle("Yoda AI")
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)

    }
}

#Preview {
    PromptView()
}
