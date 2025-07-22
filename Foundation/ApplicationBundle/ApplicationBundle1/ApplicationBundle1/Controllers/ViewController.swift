//
//  ViewController.swift
//  ApplicationBundle1
//
//  Created by Alexey Lim on 22/7/25.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {

    private let textFileManager = TextFileManager()
    private let filename = "UserNote.txt"
    private let placeholder = "Enter your text here..."

    private lazy var textView: UITextView = {
        let tv = UITextView()
        tv.font = .systemFont(ofSize: 16)
        tv.layer.borderColor = UIColor.lightGray.cgColor
        tv.layer.borderWidth = 1.0
        tv.layer.cornerRadius = 8
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        loadTextFromFile()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Note Taker"
        
        view.addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    private func setupNavigationBar() {
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
    }

    @objc private func saveButtonTapped() {
        let textToSave = (textView.text == placeholder) ? "" : textView.text
        
        textFileManager.saveText(textToSave ?? "", to: filename)
        
        let alert = UIAlertController(title: "Success", message: "Your note has been saved.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        
        textView.resignFirstResponder()
    }
    
    private func loadTextFromFile() {
        if let savedText = textFileManager.retrieveText(from: filename), !savedText.isEmpty {
            textView.text = savedText
            textView.textColor = .label
        } else {
            setupPlaceholder()
        }
    }
    
    private func setupPlaceholder() {
        textView.text = placeholder
        textView.textColor = .placeholderText
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .placeholderText {
            textView.text = nil
            textView.textColor = .label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            setupPlaceholder()
        }
    }
}
