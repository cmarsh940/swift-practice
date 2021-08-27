//
//  ViewController.swift
//  Combine_Practice
//
//  Created by Cam on 8/27/21.
//

import Combine
import UIKit

class customTableCell: UITableViewCell {
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPink
        button.setTitle("Button", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let action = PassthroughSubject<String, Never>()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(button)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc private func didTapButton() {
        action.send("Cool, Button was tapped")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.frame = CGRect(x: 10, y: 3, width: contentView.frame.size.width-20, height: contentView.frame.size.height-6)
    }
}

class ViewController: UIViewController, UITableViewDataSource {
    
    private let tableView: UITableView =  {
        let table = UITableView()
        table.register( customTableCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    var observers: [AnyCancellable] = []
    
    private var models = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        APICaller.shared.fetchData()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
            switch completion {
                case .finished: print("finished")
                case .failure(let error): print(error)
            }
        }, receiveValue: { [weak self] value in
            self?.models = value
            self? .tableView.reloadData()
        }).store(in: &observers)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? customTableCell else {
            fatalError()
        }
//        cell.textLabel?.text = models[indexPath.row]
        cell.action.sink { string in
            print(string)
        }.store(in: &observers)
        return cell
    }


}

 
