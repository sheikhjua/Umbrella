//
//  LogInView.swift
//  Umbrella
//
//  Created by Sheikh Ahmed on 24/04/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import SwiftUI
import Combine

struct LogInView: View {
    @Environment(\.presentationMode) var presentation
    @State var emailAddress: String = ""
    @State var password: String = ""
    @State var passwordString: String = ""
    @State var alertItem: UmbrellaAlert?
    @State var textFieldHavingError: APPTextFields?
    @State var shouldShowSheet: Bool = false
    private let firebaseManager = FirebaseAuthManager.shared
    var body: some View {
        VStack(spacing: 20){
            // Email text field
            HStack(spacing: 10){
                TextField(APPTextFields.emailAddress.rawValue.titleCase(), text: $emailAddress, onEditingChanged: { _ in
                    self.textFieldHavingError = nil
                })
                    .padding(10)
                    .autocapitalization(.none)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke( self.textFieldHavingError == .emailAddress
                            && !self.emailAddress.isValidEmailAddress()
                            ?  Color.red : Color.gray, lineWidth: 1)
                )
                ImageForTextField(imageName: .tick, imageColor: (self.emailAddress.isValidEmailAddress() ? .green : .clear))
            }
            // Password text field
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
            // Login button
            Button(action: {
                if self.checkValidInput() {
                    self.firebaseManager.loginUser(loginInfo: LoginInfo(email: self.emailAddress, password: self.passwordString)) { (response) in
                        switch response{
                        case .success(let data):
                            if let _ = data{
                                self.firebaseManager.loginState = true
                                UserDefaults.standard.setLogInState(state: true)
                                self.presentation.wrappedValue.dismiss()
                            }
                        case .failure(let error):
                            self.alertItem = UmbrellaAlert(customAlert: .unknownError, error: error)
                        }
                    }
                }
                else {
                    self.alertItem = UmbrellaAlert(customAlert: .incompleteRequiredData, error: nil)
                }
            })
            {
                FlexibleLabelWithImage(button: .logIn)
            }
            .overlay(RoundedRectangle(cornerRadius: 40)
            .stroke(Color.gray, lineWidth: 1)
            )
            // forgot password button
            Button(action: {
                if self.emailAddress.isValidEmailAddress() {
                    // look for whether email is registered
                    self.firebaseManager.isUserExists(email: self.emailAddress) { (result) in
                        switch result{
                        case .success(let response):
                            if let isSuccess = response, isSuccess{
                                self.alertItem = UmbrellaAlert(customAlert: .emailSentToResetPassword, error: nil)
                            } else {
                                self.alertItem = UmbrellaAlert(customAlert: .userNotRegistered, error: nil)
                            }
                        case .failure(let error):
                            self.alertItem = UmbrellaAlert(customAlert: .unknownError, error: error)
                        }
                    }
                } else {
                    self.alertItem = UmbrellaAlert(customAlert: .invalidEmailAddress, error: nil)
                }
            }) {
                FlexibleLabelWithImage(button: .forgetPassword)
            }.overlay(RoundedRectangle(cornerRadius: 40)
                .stroke(Color.gray, lineWidth: 1)
            )
            Spacer()
        }
        .navigationBarTitle(Text("Log in").bold(), displayMode: .inline)
        .padding()
        .onAppear {
            NotificationCenter.default.addObserver(forName: NSNotification.Name("switchViewChanged"), object: nil, queue: .main) { (_) in
                let view = UserDefaults.standard.getView()
                if view == "signUp" {
                    self.shouldShowSheet.toggle()
                }
            }
        }
        .sheet(isPresented: self.$shouldShowSheet) {
            SignUpView()
        }
        .alert(item: $alertItem) { item  in
            return item.alert
        }
    }
    // MARK:- check for valid customer inputs
    private func checkValidInput()->Bool{
        let email = self.emailAddress.trimmingCharacters(in: .whitespacesAndNewlines)
        let pass1 = self.password
        if !email.isValidEmailAddress() {
            self.textFieldHavingError = .emailAddress
            return false
        }
        if pass1.count < 6 {
            self.textFieldHavingError = .password
            return false
        }
        self.textFieldHavingError = nil
        return true
    }
    // MARK:-
}
struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}


// MARK:- Image Type
enum ResultImage{
    case tick
    case error
    var imageName: String{
        switch self {
        case .error: return "exclamationmark.triangle.fill"
        case .tick: return "checkmark"
        }
    }
}
// MARK:- Image Color
enum ResultImageColor{
    case green
    case red
    case clear
    var color: Color {
        switch self{
        case .clear: return .clear
        case .green: return .green
        case .red: return .red
        }
    }
}
// MARK:- Custom Image View for tick or error
struct ImageForTextField: View{
    var imageName: ResultImage
    var imageColor: ResultImageColor
    var body: some View {
        Image(systemName: self.imageName.imageName).foregroundColor(self.imageColor.color)
    }
}
