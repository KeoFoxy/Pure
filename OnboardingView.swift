//
//  OnboardingView.swift
//  PureMagic
//
//  Created by Alexander Sorokin on 07.06.2022.
//
//

import SwiftUI
import RiveRuntime

struct OnboardingView: View {
    let button = RiveViewModel(fileName: "button")
    let shapes = RiveViewModel(fileName: "shapes")
    
    var body: some View {
        ZStack {
            background
            //button_start
            
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Welcome to the Pure")
                    .font(.custom("Poppins Bold", size: 50, relativeTo: .largeTitle))
                    .frame(width: 260, alignment: .leading)
                
                Text("Created by KeoFoxy")
                    .customFont(.body)
                    .opacity(0.8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                   Spacer()
                
                button_start
                
                Text("SomeText to be changed in the future")
                    .customFont(.footnote)
                    .opacity(0.7)
            }
            .padding(45)
            .padding(.top, 40)
        }
    }
    
    
    var background: some View{
        shapes.view()
            .ignoresSafeArea()
            .blur(radius: 15)
            .background(
            Image("Spline")
                .blur(radius: 50)
                .offset(x: 150, y: 100)
        )
    }
    
    var button_start: some View{
        button.view()
            .frame(width: 236, height: 64)
            .overlay(
            Label("Start", systemImage: "arrow.forward")
                .offset(x: 4, y: 4)
                .font(.headline)
                 )
            .background(
                Color.black
                    .cornerRadius(30)
                    .blur(radius: 10)
                    .opacity(0.3)
                    .offset(y: 10)
            )
            .onTapGesture {
                button.play(animationName: "active")
            }
    }
     
    

}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
