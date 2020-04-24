//
//  SignUpView.swift
//  Umbrella
//
//  Created by Sheikh Ahmed on 24/04/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import Combine

// MARK:- Signup View
struct SignUpView: View {
    @Environment(\.presentationMode) var presentation
    @State var emailAddress: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var passwordString: String = ""
    @State var confirmPasswordString: String = ""
    @State var alertItem: UmbrellaAlert?
    @State var textFieldHavingError: APPTextFields?
    @State var shouldShowSheet: Bool = false
    var body: some View {
        // Three text boxes
        VStack(spacing: 20){
            HStack(spacing: 10){
                TextField(APPTextFields.emailAddress.rawValue.titleCase(), text: $emailAddress, onEditingChanged: { _ in
                    self.textFieldHavingError = nil
                })
                    .font(.system(size: 18))
                    .padding(10)
                    .autocapitalization(.none)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke( self.textFieldHavingError == .emailAddress
                            && !self.emailAddress.isValidEmailAddress()
                            ?  Color.red : Color.gray, lineWidth: 1)
                )
                ImageForTextField(imageName: .tick, imageColor: (self.emailAddress.isValidEmailAddress() ? .green : .clear))
            }
            HStack(spacing: 10){
                TextField(APPTextFields.password.rawValue.titleCase(), text: $password, onEditingChanged: { _ in
                    self.textFieldHavingError = nil
                })
                    .padding(10)
                    .autocapitalization(.none)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke( (self.textFieldHavingError == .password) && (self.password.count < 6)
                            ?  Color.red : Color.gray, lineWidth: 1)
                        .onReceive(Just(password)) { (newValue) in
                            if self.passwordString.count == newValue.count {
                                return
                            }
                            if let lastCharacter = newValue.last{
                                if self.passwordString.count < self.password.count {
                                    self.passwordString.append(lastCharacter)
                                } else {
                                    self.passwordString = String(self.passwordString.dropLast(1))
                                }
                                self.password = String(repeating: "*", count: newValue.count)
                            }
                        }
                )
                ImageForTextField(imageName: .tick, imageColor: (self.password.count > 5 ? .green : .clear))
            }
            HStack(spacing: 10){
                TextField(APPTextFields.confirmPassword.rawValue.titleCase(), text: $confirmPassword, onEditingChanged: { _ in
                    self.textFieldHavingError = nil
                })
                    .padding(10)
                    .autocapitalization(.none)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke( (self.textFieldHavingError == .confirmPassword) && (self.confirmPassword.count < 6)
                            ?  Color.red : Color.gray, lineWidth: 1)
                        .onReceive(Just(confirmPassword)) { (newValue) in
                            if self.confirmPasswordString.count == newValue.count {
                                return
                            }
                            if let lastCharacter = newValue.last{
                                if self.confirmPasswordString.count < self.confirmPassword.count {
                                    self.confirmPasswordString.append(lastCharacter)
                                } else {
                                    self.confirmPasswordString = String(self.confirmPasswordString.dropLast(1))
                                }
                                self.confirmPassword = String(repeating: "*", count: newValue.count)
                            }
                        }
                )
                ImageForTextField(imageName: .tick, imageColor: (self.confirmPassword.count > 5 ? .green : .clear))
            }
            // Sign up button
            Button(action: {
                let authManager = FirebaseAuthManager.shared
                if self.checkValidInput() {
                    authManager.createUser(loginInfo: LoginInfo(email: self.emailAddress, password: self.passwordString)){ (response) in
                        switch response{
                        case .success(let data):
                            if let _ = data{
                            }
                        case .failure(let error):
                            self.alertItem = UmbrellaAlert(customAlert: .unknownError, error: error)
                        }
                    }
                }
                else {
                    self.alertItem = UmbrellaAlert(customAlert: .incompleteRequiredData, error: nil)
                }
            }) {
                FlexibleLabelWithImage(button: .signUp)
            }.overlay(RoundedRectangle(cornerRadius: 40)
                .stroke(Color.gray, lineWidth: 1)
            )
            Spacer()
        }
        .navigationBarTitle(Text("Sign up").bold(), displayMode: .inline)
        .padding()
        .alert(item: $alertItem) { item in
            return item.alert
        }
        .onAppear {
            NotificationCenter.default.addObserver(forName: NSNotification.Name("switchViewChanged"), object: nil, queue: .main) { (_) in
                let view = UserDefaults.standard.getView()
                if view == "logIn" {
                    self.shouldShowSheet.toggle()
                }
            }
        }
        .sheet(isPresented: self.$shouldShowSheet) {
            LogInView()
        }
    }
    // MARK:- check Error alert
    private func getErrorAlert(withError error: Error)->Alert{
        return Alert(title: Text("What?"))
    }
    // MARK:- check for valid customer inputs
    private func checkValidInput()->Bool{
        let email = self.emailAddress.trimmingCharacters(in: .whitespacesAndNewlines)
        if !email.isValidEmailAddress(){
            self.textFieldHavingError = .emailAddress
            return false
        }
        if self.password.isEmpty {
            self.textFieldHavingError = .password
            return false
        }
        if self.confirmPassword.isEmpty{
            self.textFieldHavingError = .confirmPassword
            return false
        }
        if self.password != self.confirmPassword {
            self.textFieldHavingError = .password
            return false
        }
        self.textFieldHavingError = nil
        return true
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}


