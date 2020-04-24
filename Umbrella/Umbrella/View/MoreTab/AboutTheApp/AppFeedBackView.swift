//
//  AppFeedBackView.swift
//  Umbrella
//
//  Created by Sheikh Ahmed on 24/04/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import SwiftUI
import MessageUI

struct AppFeedbackView: View {
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    @State var alertNoMail = false
    var body: some View {
        ZStack{
            VStack{
                Button(action: {
                    MFMailComposeViewController.canSendMail() ? self.isShowingMailView.toggle() : self.alertNoMail.toggle()
                }) {
                    FlexibleLabelWithImage(button: .sendFeedback)
                }.overlay(RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.gray, lineWidth: 1)
                )
                    .padding()
                    .frame(height: 50)
                Spacer()
            }.padding()
        }
        .navigationBarTitle(Text(MoreListItems.appFeedback.rawValue.titleCase()).bold(),displayMode: .inline)
        .sheet(isPresented: $isShowingMailView) {
            MailView(result: self.$result)
        }
        .alert(isPresented: self.$alertNoMail) {
            UmbrellaAlert.init(customAlert: .emailNotSet, error: nil).alert
        }
    }
}

struct AppFeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        AppFeedbackView()
    }
}
