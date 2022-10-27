//
//  SignInView.swift
//  verdantVegan2
//
//  Created by Elizabeth Ponce on 10/26/22.
//

import SwiftUI

struct SignInView: View {
    
    @State var password = ""
    @State var email = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack{
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            
            VStack{
                TextField("Email Address", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                Button(action: {
                    
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    viewModel.signIn(email: email, password: password)
                }, label: {
                    Text("Sign In")
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .cornerRadius(10)
                        .background(Color.blue)
                })
                NavigationLink("Create Account", destination: SignUpView())
                    .padding()
            }
            .padding()
            Spacer()
        }
        .navigationTitle("Verdant Vegan")
            
        }
    }

struct LoginPageView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView{
            if viewModel.isSignedIn {
                VStack{
                    RecipeListView()
                    Button(action: {
                        viewModel.signOut()
                    }, label: {
                        Text("Sign Out")
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                            .padding()
                    })
                }
            }
            else {
                SignInView()
            }
        }
        .onAppear{
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}


struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}
