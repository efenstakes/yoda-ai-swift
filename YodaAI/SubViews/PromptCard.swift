//
//  PromptCard.swift
//  YodaAI
//
//  Created by felix ids on 17/10/2023.
//

import SwiftUI

struct PromptCard: View {
    var prompt: Prompt
    
    @State var showCopiedSuccessfully: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {

            // prompt
            HStack(alignment: .top) {
                VStack{
                    Text(prompt.prompt)
                }
                .padding()
                .frame(width: UIScreen.main.bounds.width * 0.85, alignment: .leading)
                .background(Color(hex: "F2E8DF"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .frame(width: UIScreen.main.bounds.width - 20, alignment: .leading)
            
            // reply
            VStack {
                VStack(alignment: .leading) {
                    
                    HStack {
                        
                        Spacer()
                        
                        if !showCopiedSuccessfully {
                            
                            Image(systemName: "clipboard")
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 12)
                                .foregroundColor(.white)
                                .onTapGesture {
                                    print("copy reply \(prompt.reply)")

                                    let pasteboard = UIPasteboard.general
                                    pasteboard.string = prompt.reply
                                    
                                    withAnimation {
                                        showCopiedSuccessfully.toggle()
                                    }
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                        
                                        withAnimation {
                                            showCopiedSuccessfully.toggle()
                                        }
                                    }

                                }
                            
                        }
                        
                        if showCopiedSuccessfully {
                            
                            Text("Copied")
                                .font(.footnote)
                                .foregroundColor(.white)
                            
                        }
                        
                    }
                    
                    Text(prompt.reply)
                        .foregroundColor(.white)
                }
                .padding()
                .frame(width: UIScreen.main.bounds.width * 0.85, alignment: .leading)
                // #182625, 486966
                .background(Color(hex: "486966"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .frame(width: UIScreen.main.bounds.width - 20, alignment: .trailing)
            
            
        }
    }
}

#Preview {
    PromptCard(
        prompt: prompts[0]
    )
}
