//
//  DB_Manager.swift
//  SQLTask (iOS)
//
//  Created by Arun_Skyraan on 12/10/22.
//

 
import Foundation
import SQLite

class DB_Manager {
  
    private var db: Connection!

    private var users: Table!
   
    private var id: Expression<Int64>!
    private var name: Expression<String>!
    private var email: Expression<String>!
    private var age: Expression<Int64>!
    private var aadhaar: Expression<String>!
    private var phone: Expression<String>!
    private var dob: Expression<Date>!
    
   
    init() {
       
        do {
       
let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
   
            db = try Connection("\(path)/my_users.sqlite3")

            users = Table("users")
 
            id = Expression<Int64>("id")
            name = Expression<String>("name")
            email = Expression<String>("email")
            age = Expression<Int64>("age")
            aadhaar = Expression<String>("aadhaar")
            phone = Expression<String>("phone")
            dob = Expression<Date>("dob")
            

            if (!UserDefaults.standard.bool(forKey: "is_db_created")) {
            
                try db.run(users.create {(t) in
                    t.column(id, primaryKey: true)
                    t.column(name)
                    t.column(email, unique: true)
                    t.column(age)
                    t.column(aadhaar)
                    t.column(phone)
                    t.column(dob)
                    
                })
                
                UserDefaults.standard.set(true, forKey: "is_db_created")
            }

        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func addUser(nameValue: String, emailValue: String, ageValue: Int64, aadhaarValue: String, phoneValue: String, dobValue: Date) {
        do {
            try db.run(users.insert(name <- nameValue, email <- emailValue, age <- ageValue, aadhaar <- aadhaarValue, phone <- phoneValue, dob <- dobValue))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func updateUser(idValue: Int64, nameValue: String, emailValue: String, ageValue: Int64) {
        do {
   
            let user: Table = users.filter(id == idValue)
            try db.run(user.update(name <- nameValue, email <- emailValue, age <- ageValue))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func deleteUser(idValue: Int64) {
        do {
            let user: Table = users.filter(id == idValue)
            try db.run(user.delete())
        } catch {
            print(error.localizedDescription)
        }
    }
    

    public func getUsers() -> [UserModel] {

        var userModels: [UserModel] = []
 
        users = users.order(id.desc)

        do {
 
            for user in try db.prepare(users) {
        
                let userModel: UserModel = UserModel()
                

                userModel.id = user[id]
                userModel.name = user[name]
                userModel.email = user[email]
                userModel.age = user[age]
                userModel.aadhaar = user[aadhaar]
                userModel.phone = user[phone]
                userModel.dob = user[dob]
                
 
                userModels.append(userModel)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return userModels
    }
    

    public func getUser(idValue: Int64) -> UserModel {
  
        let userModel: UserModel = UserModel()
   
        do{
        
            let user: AnySequence<Row> = try db.prepare(users.filter(id == idValue))
            
          
            try user.forEach({ rowValue in
           
                userModel.id = try rowValue.get(id)
                userModel.name = try rowValue.get(name)
                userModel.email = try rowValue.get(email)
                userModel.age = try rowValue.get(age)
                userModel.aadhaar = try rowValue.get(aadhaar)
                userModel.phone = try rowValue.get(phone)
                userModel.dob = try rowValue.get(dob)
            })
        }
        
        catch {
            print(error.localizedDescription)
        }
        
        return userModel
    }
    
}

