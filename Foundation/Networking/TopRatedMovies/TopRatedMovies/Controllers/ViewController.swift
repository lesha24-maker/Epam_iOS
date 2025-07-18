//
//  ViewController.swift
//  TopRatedMovies
//
//  Created by Alexey Lim on 9/7/25.
//

import UIKit

class ViewController: UIViewController {
    
    private var seriesList: [TVSeries] = []
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 300
        tv.separatorStyle = .none
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .systemBackground
        setupTableView()
        fetchData()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TVSeriesCell.self, forCellReuseIdentifier: TVSeriesCell.identifier)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func fetchData() {
        NetworkManager.shared.fetchTopRatedSeries { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let series):
                self.seriesList = series
                self.tableView.reloadData()
                
            case .failure(let error):
                self.handleError(error)
            }
        }
    }
    
    private func handleError(_ error: NetworkError) {
        let title: String
        let message: String
        switch error {
        case .badURL:
            title = "Error"
            message = "The URL for the request was invalid."
        case .requestFailed(let underlyingError):
            title = "Request Failed"
            message = underlyingError.localizedDescription
        case .invalidResponse:
            title = "Error"
            message = "The server returned an invalid response."
        case .badStatusCode(let code):
            title = "Server Error"
            message = "The server returned a status code of \(code)."
        case .decodingError:
            title = "Parsing Error"
            message = "Could not parse the data from the server."
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seriesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TVSeriesCell.identifier, for: indexPath) as? TVSeriesCell else {
            return UITableViewCell()
        }
        
        let series = seriesList[indexPath.row]
        cell.configure(with: series)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedSeries = seriesList[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.series = selectedSeries
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
