//
//  OnboardingView.swift
//  YodaAI
//
//  Created by felix ids on 17/10/2023.
//

import SwiftUI

struct Onboarding: Identifiable {
    var id: Int
    var title: String
    var text: String
    var imageName: String
}

struct OnboardingView: View {
    @State var currentIndex: Int = 0
    
    @AppStorage("hasOnboarded") var hasOnboarded: Bool = false
    @State private var navPath = NavigationPath()
    
    let onboardingPages: [Onboarding] = [
        Onboarding(
            id: 0,
            title: "Dream",
            text: "Welcome to the world of possibilities. This is where your dreams take flight.",
            imageName: "dream"
        ),
        Onboarding(
            id: 1,
            title: "Ideate",
            text: "Brainstorm, refine, and organize your thoughts with the help of our AI tools. Your next big innovation starts here.",
            imageName: "ideate"
        ),
        Onboarding(
            id: 2,
            title: "Build",
            text: "Our AI-powered features will be your trusty companions on this journey to manifest your vision.",
            imageName: "build"
        ),
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                
                // skip button
                HStack {
                    Text( hasOnboarded ? "onboarded" : "not $hasOnboarded")
                    Spacer()
                    
                    Button(action: {
                        
                        print("skip onboarding")
                        hasOnboarded = true
                    }, label: {
                        
                        NavigationLink(destination: PromptView()) {
                            
                            Text("Skip")
                                .foregroundColor(.teal)
                        }
                    })
                }
                .padding()
                
                // tabs
                TabView(selection: $currentIndex) {
                    
                    ForEach(0..<onboardingPages.count, id: \.self) { index in
                        
                        OnboardingViewContent(
                            onboarding: onboardingPages[index],
                            currentIndex: $currentIndex
                        )
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                // indicators and button
                VStack(alignment: .leading) {
                    
                    // indicators
                    HStack(alignment: .center) {
                        
                        ForEach(0..<3) { index in
                            
                            if index == currentIndex {
                                Rectangle()
                                    .frame(width: 24, height: 10)
                                    .cornerRadius(20)
                                    .foregroundColor(.teal)
                                
                            } else {
                                
                                Rectangle()
                                    .frame(
                                        width: 10,
                                        height: 10
                                    )
                                    .cornerRadius(20)
                                    .foregroundColor(.gray)
                                
                            }
                        }
                    }
                    .padding(.bottom)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    
                    // button
                    Button(action: {
                        
                        if self.currentIndex == onboardingPages.count - 1 {
                            
                            hasOnboarded = true
                            print("done onboarding, go to yoda")
                        } else {
                            
                            withAnimation {
                                currentIndex += 1
                            }
                            
                            print("still on the onboarding process")
                        }
                    }, label: {
                        
                        if self.currentIndex == onboardingPages.count - 1 {
                            
                            NavigationLink(
                                destination: PromptView()
                            ){
                                
                                Text( "Start Using Yoda" )
                                    .padding()
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.white)
                                    .background(.teal)
                                    .cornerRadius(10)
                            }
                            
                        } else {
                         
                            Text( "Next" )
                                .padding()
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                .foregroundColor(.white)
                                .background(.teal)
                                .cornerRadius(10)
                        }
                    })
                
                }
                .padding()
                
            }
            .navigationDestination(isPresented: $hasOnboarded) {
                PromptView()
            }
        }
        .onAppear {
            
            print( hasOnboarded ? "hasOnboarded" : "not hasOnboarded" )
        }
    }
}

struct OnboardingViewContent: View {
    var onboarding: Onboarding
    @Binding var currentIndex: Int
    
    var body: some View {
        VStack {
            
            // image
            Image(onboarding.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            // title
            Text(onboarding.title)
                .font(.system(size: 64))
                .bold()
            
            // description
            Text(onboarding.text)
                .fontWeight(.regular)
                .multilineTextAlignment(.center)
            
            // button
            
        }
        .padding()
    }
}

#Preview {
    OnboardingView()
}
