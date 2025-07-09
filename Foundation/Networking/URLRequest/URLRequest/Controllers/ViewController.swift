//
//  ViewController.swift
//  URLRequest
//
//  Created by Alexey Lim on 9/7/25.
//

import UIKit

class ViewController: UIViewController {
    
    var emails: [String] = []
    
    private lazy var emailTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.emailTableView.dataSource = self
        self.emailTableView.delegate = self
        self.emailTableView.register(UITableViewCell.self, forCellReuseIdentifier: "emailCell")
        setupUI()
        fetchEmails()
    }
    
    private func setupUI() {
        view.addSubview(emailTableView)
        NSLayoutConstraint.activate([
            emailTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emailTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emailTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emailTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func fetchEmails() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            print("Error, wrong URL!")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, responce, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                print("No data!")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let users = try decoder.decode([User].self, from: data)
                let emails = users.map { $0.email }
                DispatchQueue.main.async {
                    self.emails = emails
                    self.emailTableView.reloadData()
                }
            } catch {
                print("Error")
            }
        }
        task.resume()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emailCell", for: indexPath)
        let email = emails[indexPath.row]
        cell.textLabel?.text = email
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedEmail = emails[indexPath.row]
        print("Вы нажали на email: \(selectedEmail)")
    }
}
