//
//  JustoAP.swift
//  Justo
//
//  Created by daniel ortiz millan on 17/04/24.
//

import Foundation

var request = URLRequest(url: URL(string: "https://randomuser.me/api/")!,timeoutInterval: Double.infinity)
request.httpMethod = "GET"

let task = URLSession.shared.dataTask(with: request) { data, response, error in
  guard let data = data else {
    print(String(describing: error))
    return
  }
  print(String(data: data, encoding: .utf8)!)
}

task.resume()
