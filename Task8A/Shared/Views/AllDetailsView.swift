//
//  AllDetailsView.swift
//  Task8A (iOS)
//
//  Created by Arun_Skyraan on 13/10/22.
//

import SwiftUI

struct AllDetailsView: View {
    @State var userModels: [UserModel] = []
    var body: some View {
        List(self.userModels.reversed()) { (model) in
            VStack {
                Text("\(model.aadhaar)")
            }
        }
        .onAppear{
            self.userModels = DB_Manager().getUsers()
        }
    }
}

struct AllDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AllDetailsView()
    }
}
