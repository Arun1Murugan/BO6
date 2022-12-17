//
//  UserModel.swift
//  SQLTask (iOS)
//
//  Created by Arun_Skyraan on 12/10/22.
//

import Foundation
 
class UserModel: Identifiable {
    
    public var id: Int64 = 0
    public var name: String = ""
    public var email: String = ""
    public var age: Int64 = 0
    public var aadhaar: String = ""
    public var phone: String = ""
    public var dob: Date = Date()
    
}
