//
//  ViewController.swift
//  UserDefaults3
//
//  Created by Alexey Lim on 23/7/25.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {

    private var searchHistory: [String] = []

    private let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Search for something..."
        sb.searchBarStyle = .minimal
        sb.translatesAutoresizingMaskIntoConstraints = false
        return sb
    }()
    
    private let historyTableView: UITableView = {
        let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "historyCell")
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadSearchHistory()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Recent Searches"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        searchBar.delegate = self
        historyTableView.dataSource = self
        historyTableView.delegate = self
        
        view.addSubview(searchBar)
        view.addSubview(historyTableView)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            historyTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            historyTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            historyTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            historyTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadSearchHistory() {
        searchHistory = SearchHistoryManager.shared.getSearchHistory()
        historyTableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        SearchHistoryManager.shared.saveSearchTerm(searchTerm)
        
        loadSearchHistory()
        
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = searchHistory[indexPath.row]
        content.image = UIImage(systemName: "clock.arrow.circlepath")
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return searchHistory.isEmpty ? "No recent searches" : "Your last \(searchHistory.count) searches"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedTerm = searchHistory[indexPath.row]
        
        searchBar.text = selectedTerm
        searchBar.becomeFirstResponder()
    }
}
