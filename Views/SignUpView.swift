//
//  SignUpView.swift
//  verdantVegan2
//
//  Created by Elizabeth Ponce on 10/26/22.
//

import SwiftUI

struct SignUpView: View {
    
    @State var password = ""
    @State var email = ""
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
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
                    viewModel.signUp(email: email, password: password)
                }, label: {
                    Text("Create Account")
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .cornerRadius(10)
                        .background(Color.blue)
                })
            }
            .padding()
            Spacer()
        }
        .navigationTitle("Create Account")
    }
    
    func saveButtonPressed() {
        if passwordIsReal() {

            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func passwordIsReal() -> Bool {
        if password.count < 3 {
            alertTitle = "Your password must be at least 6 characters long 😱"
            showAlert.toggle()
            return false
        }
        //check for swear words!
        //show alert
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
