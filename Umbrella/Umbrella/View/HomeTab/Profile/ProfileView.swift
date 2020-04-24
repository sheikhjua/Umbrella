//
//  ProfileView.swift
//  Umbrella
//
//  Created by Sheikh Ahmed on 24/04/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentation
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var phoneNumber: String = ""
    @State var alertItem: UmbrellaAlert?
    @State var textFieldHavingError: APPTextFields?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var profileImage: Image?
    var body: some View {
        ZStack{
            // BackgroundView(gradient: gradient)
            //   .opacity(0.99)
            VStack(spacing: 10){
                // First Name
                HStack{
                    TextField(APPTextFields.firstName.rawValue.titleCase(), text: $firstName, onEditingChanged: { _ in
                        self.textFieldHavingError = nil
                    })
                        .font(.system(size: 18))
                        .padding(10)
                        .autocapitalization(.none)
                        .frame(height: 40)
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke( self.textFieldHavingError == .firstName
                                && self.firstName.isEmpty
                                ?  Color.red : Color.gray, lineWidth: 1)
                    )
                    
                    ImageForTextField(imageName: .tick, imageColor: (!self.firstName.isEmpty ? .green : .clear))
                }
                // Last Name
                HStack{
                    TextField(APPTextFields.lastName.rawValue.titleCase(), text: $lastName, onEditingChanged: { _ in
                        self.textFieldHavingError = nil
                    })
                        .font(.system(size: 18))
                        .padding(10)
                        .autocapitalization(.none)
                        .frame(height: 40)
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke( self.textFieldHavingError == .lastName
                                && self.lastName.isEmpty
                                ?  Color.red : Color.gray, lineWidth: 1)
                    )
                    
                    ImageForTextField(imageName: .tick, imageColor: (self.lastName.count > 2 ? .green : .clear))
                }
                // Phone Number
                HStack{
                    TextField(APPTextFields.phoneNumber.rawValue.titleCase(), text: $phoneNumber, onEditingChanged: { _ in
                        self.textFieldHavingError = nil
                    })
                        .font(.system(size: 18))
                        .padding(10)
                        .autocapitalization(.none)
                        .frame(height: 40)
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke( self.textFieldHavingError == .phoneNumber
                                && self.phoneNumber.count < 9
                                ?  Color.red : Color.gray, lineWidth: 1)
                    )
                    
                    ImageForTextField(imageName: .tick, imageColor: (self.phoneNumber.count > 8 ? .green : .clear))
                }
                // Image
                HStack{
                    self.profileImage?
                        .resizable()
                        .frame(width: 75, height: 75)
                        .clipShape(Circle())
                        .overlay(Circle()
                            .stroke(Color.blue)
                    )
                    Button(action: {
                        self.showingImagePicker = true
                    }) {
                        Text("Choose image")
                    }
                }
                // Update Button
                Button(action: {
                    // make API call
                    let authManager = FirebaseAuthManager.shared
                    let userProfile = UserProfile(userID: authManager.currentUserProfile.userID,
                                                  firstName: self.firstName,
                                                  lastName: self.lastName,
                                                  phoneNumber: self.phoneNumber,
                                                  profileImage: self.inputImage)
                    authManager.saveUserProfile(userID: authManager.currentUserProfile.userID ?? "",
                                                userProfile: userProfile) { (response) in
                                                    switch response{
                                                    case .success(let profileUpdated):
                                                        if let flag = profileUpdated, flag {
                                                            UserDefaults.standard.setProfileChanged(status: true)
                                                            self.presentation.wrappedValue.dismiss()
                                                        }
                                                        else {
                                                            self.alertItem = UmbrellaAlert(customAlert: .profileUpdateFailed, error: nil)
                                                        }
                                                    case .failure(let error):
                                                        self.alertItem = UmbrellaAlert(customAlert: .profileUpdateFailed, error: error)
                                                    }
                    }
                }) {
                    FlexibleLabelWithImage(button: .update)
                }
                .overlay(RoundedRectangle(cornerRadius: 40)
                .stroke(Color.gray, lineWidth: 1)
                )
                Spacer()
            }.padding()
            
        }
        .onAppear(perform: loadProfile)
        .navigationBarTitle(Text(MoreListItems.manageProfile.rawValue.titleCase()).bold(),displayMode: .inline)
        .sheet(isPresented: $showingImagePicker, onDismiss: refreshProfileImage) {
            ImagePickerView(image: self.$inputImage)
        }
        .alert(item: $alertItem) { item in
            return item.alert
        }
    }
    private func refreshProfileImage(){
        self.profileImage = Image(uiImage: self.inputImage ?? UIImage())
    }
    func loadProfile(){
        let authManager = FirebaseAuthManager.shared
        self.firstName = authManager.currentUserProfile.firstName ?? ""
        self.lastName = authManager.currentUserProfile.lastName ?? ""
        self.phoneNumber = authManager.currentUserProfile.phoneNumber ?? ""
        self.inputImage = authManager.currentUserProfile.profileImage
        self.profileImage = Image(uiImage: authManager.currentUserProfile.profileImage ?? UIImage())
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
