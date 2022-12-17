//
//  UserView.swift
//  Task8A (iOS)
//
//  Created by Arun_Skyraan on 13/10/22.
//

import SwiftUI

struct UserView: View {
    
    @State var aadhaar: String = ""
    @State var name: String = ""
    @State var phone: String = ""
    @State var email: String = ""
    @State var dob: Date = Date()
    
    @State var userModels: [UserModel] = []
    
    var body: some View {
        VStack {
            TextField("aadhaar", text: $aadhaar)
                .padding()
            TextField("name", text: $name)
                .padding()
            TextField("phone", text: $phone)
                .padding()
            TextField("email", text: $email)
                .padding()
            DatePicker(selection: $dob, label: { Text("Date") })
            
            Button(action: {
                DB_Manager().addUser(nameValue: self.name, emailValue: self.email, ageValue: 0, aadhaarValue: self.aadhaar, phoneValue: self.phone, dobValue: self.dob)
                
                let dbManager: DB_Manager = DB_Manager()
                self.userModels = dbManager.getUsers()
            }, label: {
                Text("save")
            })
            
            NavigationLink(destination: {
                
            }, label: {
                Text("go")
            })
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
