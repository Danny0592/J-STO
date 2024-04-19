//
//  UserViewModel.swift
//  Justo
//
//  Created by daniel ortiz millan on 17/04/24.
//

import Foundation

class UserViewModel: ObservableObject {
    
    @Published var userDetail: Justo?
    @Published var error: Error?
    

    let apiClient = ApiClient()
    
    func userData() {
        apiClient.getUser { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self.userDetail = user
                    self.error = nil
                    print("results: \(user)")
                case .failure(let error):
                    self.error = error
                    print("Error fetching post: \(error)")
                    
                }
                
            }
        }
        func refreshContent() {
            userData()
        }
    }
}


/*
 class UserViewModel: ObservableObject {
     
     @Published var userDetail: Justo?
     @Published var error: Error?
     

     let apiClient = ApiClient()
     
     func userData() {
         apiClient.getUser { result in
             DispatchQueue.main.async {
                 switch result {
                 case .success(let quotes):
                     self.userDetail = quotes
                     print("results \(String(describing: self.userDetail))")
                 case .failure(let error):
                     print("Error fetching post: \(error)")
                     
                 }
                 
             }
         }
         func refreshContent() {
             userData()
         }
     }
 } */
