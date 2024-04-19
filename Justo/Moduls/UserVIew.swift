//
//  UserVIew.swift
//  Justo
//
//  Created by daniel ortiz millan on 17/04/24.
//



import MapKit
import SwiftUI


struct UserListView: View {
    @State private var users: [ResultUser] = []
    @State private var isRefreshing = false
    
    var body: some View {
        
        VStack {
            
            List(users, id: \.login.uuid) { user in
                VStack(alignment: .center) {
                    if let imageURL = URL(string: user.picture.large), //
                       let imageData = try? Data(contentsOf: imageURL),
                       let uiImage = UIImage(data: imageData) {
                        
                        Text("Profile")
                            .foregroundColor(.blue)
                            .italic()
                            .font(.title)
                                .bold()
                        Spacer().frame(height: 15)
                        
                        HStack {
                            Spacer()
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200, height: 200)
                                .cornerRadius(50)
                                .shadow(color: Color.blue.opacity(2), radius: 20, x: 0, y: 6)
                            
                         Spacer()
                        }
                    }
                    
                    HStack {
                        Spacer()
                    }
                    Spacer().frame(height: 35)
                                      
                    Text("Name: ") .italic()
                        .foregroundColor(.gray)
                        .font(.headline)
                        +
                        Text("\(user.name.first) \(user.name.last)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Spacer().frame(height: 15)
                            
                    Text("Email: ") .italic()
                        .foregroundColor(.gray)
                           .font(.headline)
                       Text("\(user.email)")
                        .foregroundColor(.gray)
                           .font(.subheadline)
                           .foregroundColor(.blue)
                           .onTapGesture {
                               if let emailURL = URL(string: "mailto:\(user.email)") {
                                   UIApplication.shared.open(emailURL)
                               }
                           }
                    
                    Spacer().frame(height: 15)
                    
                    Text("Phone: ") .italic()
                        .foregroundColor(.gray)
                           .font(.headline)
                       Text("\(user.phone.description)")
                           .font(.subheadline)
                           .foregroundColor(.blue)
                           .onTapGesture {
                               if let phoneURL = URL(string: "tel://\(user.phone.description)") {
                                   UIApplication.shared.open(phoneURL)
                               }
                           }
                    
                    Spacer().frame(height: 15)
                         
                    Text("Cell: ") .italic()
                        .foregroundColor(.gray)
                            .font(.headline)
                        Text("\(user.cell)")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                            .onTapGesture {
                                if let cellURL = URL(string: "tel://\(user.cell)") {
                                    UIApplication.shared.open(cellURL)
                                }
                            }
                    
                    Spacer().frame(height: 15)
                    
                    Text("Address: ") .italic()
                        .foregroundColor(.gray)
                            .font(.headline)
                        Text("\(user.location.city), \(user.location.state), \(user.location.country)")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                            .onTapGesture {
                                let address = "\(user.location.city), \(user.location.state), \(user.location.country)"
                                if let encodedAddress = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                                   let mapsURL = URL(string: "maps://?q=\(encodedAddress)") {
                                    UIApplication.shared.open(mapsURL)
                                }
                            }
                    
                    //BUTTON UPDATE
                    Button(action: {
                        userData()
                    }) {
                        Image(systemName: "arrow.clockwise.circle.fill") // Cambia "arrow.clockwise.circle.fill" por el nombre del sistema de tu símbolo
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()
                            .foregroundColor(.blue)
                    }
//                    // fin del boton
                    .padding()
                    }.background(Color.black)
                }
                .onAppear {
                    userData()
                }
            }
        
        }
        
        func userData() {
            guard let url = URL(string: "https://randomuser.me/api/") else {
                print("Invalid URL")
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                if let decodedResponse = try? JSONDecoder().decode(Justo.self, from: data) {
                    DispatchQueue.main.async {
                        self.users = decodedResponse.results
                    }
                } else {
                    print("Error decoding response")
                }
            }.resume()
        }
    }
        
    struct UserListView_Previews: PreviewProvider {
        static var previews: some View {
            UserListView()
        }
    }
    #Preview {
        UserListView()
    }
    

