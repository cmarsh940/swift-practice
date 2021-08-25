//
//  ViewController.swift
//  Async_Practice
//
//  Created by Cam on 8/25/21.
//

import UIKit


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    func callBackgroundWork() {
        DispatchQueue.global(qos: .unspecified).async {
            //do what you want with your background thread
        }
    }
    
    func getData() {
        guard let url = URL(string: "") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { [weak self] data, response, error in
            guard data != nil else {
                return
            }
            DispatchQueue.main.async {
                self?.view.backgroundColor = .red
            }
        })
        task.resume()
    }

}

