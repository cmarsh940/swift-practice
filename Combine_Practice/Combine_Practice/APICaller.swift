//
//  APICaller.swift
//  Combine_Practice
//
//  Created by Cam on 8/27/21.
//

import Combine
import Foundation


class APICaller {
    static let shared = APICaller()
    
    func fetchData() -> Future<[String], Error> {
        
        return Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                promise(.success(["Apple", "Google", "Facebook", "Microsoft"]))
            }
        }
    }
}
