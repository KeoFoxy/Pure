//
//  signInView.swift
//  PureMagic
//
//  Created by Alexander Sorokin on 11.06.2022.
//

import SwiftUI
import RiveRuntime

struct signInView: View {
    @State var email = ""
    @State var password = ""
    @State var isLoading = false
    @Binding var showModal: Bool
    let check = RiveViewModel(fileName: "check", stateMachineName: "State Machine 1")
    let confetti = RiveViewModel(fileName: "confetti", stateMachineName: "State Machine 1")
    
    func logIn(){
        isLoading = true
        
        if email != "" {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            try? check.triggerInput("Check")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            isLoading = false
            try? confetti.triggerInput("Trigger explosion")
        }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4){
                withAnimation {
                    showModal = false
                }
            }
    }
        else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                try? check.triggerInput("Error")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isLoading = false
            }
        }
}
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Sign In")
                .customFont(.largeTitle)
            Text("Some text TBC")
                .customFont(.headline)
                 
            VStack(alignment: .leading) {
                Text("Email")
                    .customFont(.subheadline)
                .foregroundColor(.secondary)
                TextField("", text: $email)
                    .customTextField(image: Image("Icon Email"))
            }
            
            VStack(alignment: .leading) {
                Text("Password")
                    .customFont(.subheadline)
                .foregroundColor(.secondary)
                SecureField("", text: $password)
                    .customTextField(image: Image("Icon Lock"))
            }
            
            Button{
                logIn()
            } label: {
                Label("Sign In", systemImage: "arrow.right")
                    .customFont(.headline)
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "F77D8E"))
                    .foregroundColor(.white)
                    .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                    .cornerRadius(8, corners: [.topLeft])
                .shadow(color: Color(hex: "F77D8E").opacity(0.5), radius: 20, x: 0, y: 10)
            }
            
            HStack {
                Rectangle().frame(height: 1).opacity(0.1)
                Text("OR").customFont(.subheadline2).foregroundColor(.black.opacity(0.3))
                Rectangle().frame(height: 1).opacity(0.1)
            }
            
            Text("Sign in via Email, Apple ID or Google")
                .customFont(.subheadline)
                .foregroundColor(.secondary)
            
            HStack {
                Image("Logo Email")
                Spacer()
                Image("Logo Apple")
                Spacer()
                Image("Logo Google")
            }
        }
        .padding(30)
        .background(.regularMaterial)
        .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color("Shadow").opacity(0.3), radius: 5, x: 10, y: 3)
        .shadow(color: Color("Shadow").opacity(0.3), radius: 5, x: 0, y: 10)
        .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous)
            .stroke(.linearGradient(colors: [.white.opacity(0.8), .white.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing ))
        )
        .padding()
        .overlay(
            ZStack{
            if isLoading{
                check.view()
                    .frame(width: 100, height: 100)
                    .allowsHitTesting(false)
                }
                confetti.view()
                    .scaleEffect(3)
                    .allowsHitTesting(false)
            }
        )
    }
}

struct signInView_Previews: PreviewProvider {
    static var previews: some View {
        signInView(showModal: .constant(true))
    }
}
