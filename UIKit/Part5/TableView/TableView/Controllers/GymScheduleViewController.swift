//
//  ViewController.swift
//  TableView
//
//  Created by Alexey Lim on 26/6/25.
//

import UIKit

class GymScheduleViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(GymClassTableViewCell.self, forCellReuseIdentifier: GymClassTableViewCell.identifier)
        return tableView
    }()
    
    private var sectionsData: [[String: Any]] = [
        [
            "headerDay": "Friday",
            "headerDate": "21 Feb 2025",
            "classes": [
                [
                    "className": "Stretching", "time": "18:00", "duration": "55m",
                    "trainerName": "Agata Wójcik", "trainerPhoto": "person.crop.circle", "isRegistered": false
                ]
            ]
        ],
        [
            "headerDay": "Saturday",
            "headerDate": "22 Feb 2025",
            "classes": [
                [
                    "className": "Stretching", "time": "10:00", "duration": "55m",
                    "trainerName": "Ewa Pietrzyk", "trainerPhoto": "person.crop.circle.fill", "isRegistered": true
                ],
                [
                    "className": "Pilates", "time": "15:00", "duration": "55m",
                    "trainerName": "Agata Wójcik", "trainerPhoto": "person.crop.circle", "isRegistered": false
                ]
            ]
        ],
        [
            "headerDay": "Monday",
            "headerDate": "24 Feb 2025",
            "classes": [
                [
                    "className": "Stretching", "time": "09:00", "duration": "55m",
                    "trainerName": "Agata Wójcik", "trainerPhoto": "person.crop.circle", "isRegistered": false
                ]
            ]
        ]
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Gym Schedule"
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
    }
    
    private func handleRegistrationToggle(for indexPath: IndexPath) {
        guard var classesArray = sectionsData[indexPath.section]["classes"] as? [[String: Any]] else {
            return
        }
        var gymClassData = classesArray[indexPath.row]
        
        let currentStatus = gymClassData["isRegistered"] as? Bool ?? false
        gymClassData["isRegistered"] = !currentStatus
        
        classesArray[indexPath.row] = gymClassData
        sectionsData[indexPath.section]["classes"] = classesArray
        
        let className = gymClassData["className"] as? String ?? "the class"
        let message: String
        let alertTitle: String
        if !currentStatus {
            alertTitle = "Registered!"
            message = "You have registered to \(className), see you there!"
        } else {
            alertTitle = "Cancelled"
            message = "You have just cancelled \(className) :("
        }
        
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}

extension GymScheduleViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let classes = sectionsData[section]["classes"] as? [[String: Any]] {
            return classes.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GymClassTableViewCell.identifier, for: indexPath) as? GymClassTableViewCell else {
            return UITableViewCell()
        }
        
        if let classes = sectionsData[indexPath.section]["classes"] as? [[String: Any]],
           indexPath.row < classes.count {
            let classData = classes[indexPath.row]
            cell.configure(with: classData)
            
            cell.registrationButtonAction = { [weak self] in
                self?.handleRegistrationToggle(for: indexPath)
            }
        }
        return cell
    }
}

extension GymScheduleViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: (tableView.style == .insetGrouped ? 20 : 16)),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8)
        ])
        
        let sectionInfo = sectionsData[section]
        let dayString = sectionInfo["headerDay"] as? String ?? ""
        let dateString = sectionInfo["headerDate"] as? String ?? ""
        
        let dayAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 20, weight: .bold),
            .foregroundColor: UIColor.label
        ]
        let dateAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 20, weight: .regular),
            .foregroundColor: UIColor.systemPink
        ]
        
        let attributedText = NSMutableAttributedString(string: dayString, attributes: dayAttributes)
        attributedText.append(NSAttributedString(string: " ", attributes: dateAttributes))
        attributedText.append(NSAttributedString(string: dateString, attributes: dateAttributes))
        
        label.attributedText = attributedText
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            guard let self = self else {
                completionHandler(false)
                return
            }
            
            if var classesArray = self.sectionsData[indexPath.section]["classes"] as? [[String: Any]] {
                classesArray.remove(at: indexPath.row)
                self.sectionsData[indexPath.section]["classes"] = classesArray
                
                if classesArray.isEmpty {
                    self.sectionsData.remove(at: indexPath.section)
                    tableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
                } else {
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            }
            completionHandler(true)
        }
        deleteAction.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
