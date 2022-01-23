//
//  ChannelListViewController.swift
//  TV program guide
//
//  Created by Александр on 18.01.2022.
//

import UIKit

class ChannelListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "broadcastCell",
            for: indexPath
        )
        return cell
    }
    
    private let screenLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Телеканалы"
        return label
    }()
    
    private let allButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Все", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let favoritesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Избранные", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let leftGreenView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let rightGreenView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        setupScreenLabel()
        setupAllButton()
        setupFavoritesButton()
        setupLeftGreenView()
        setupRightGreenView()
        setupTableView()
        NetworkManager.shared.fetchData { response in
            switch response {
            case .success(let tvProram):
                print(tvProram)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setupScreenLabel() {
        view.addSubview(screenLabel)
        screenLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        screenLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
    }
    
    private func setupAllButton() {
        view.addSubview(allButton)
        allButton.topAnchor.constraint(equalTo: screenLabel.bottomAnchor, constant: 20).isActive = true
        allButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/5).isActive = true
        allButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
    }
    
    private func setupFavoritesButton() {
        view.addSubview(favoritesButton)
        favoritesButton.topAnchor.constraint(equalTo: screenLabel.bottomAnchor, constant: 20).isActive = true
        favoritesButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
        favoritesButton.leftAnchor.constraint(equalTo: allButton.rightAnchor, constant: 20).isActive = true
    }
    
    private func setupLeftGreenView() {
        view.addSubview(leftGreenView)
        leftGreenView.widthAnchor.constraint(equalTo: allButton.widthAnchor).isActive = true
        leftGreenView.topAnchor.constraint(equalTo: allButton.bottomAnchor).isActive = true
        leftGreenView.leftAnchor.constraint(equalTo: allButton.leftAnchor).isActive = true
        leftGreenView.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    private func setupRightGreenView() {
        view.addSubview(rightGreenView)
        rightGreenView.widthAnchor.constraint(equalTo: favoritesButton.widthAnchor).isActive = true
        rightGreenView.topAnchor.constraint(equalTo: favoritesButton.bottomAnchor).isActive = true
        rightGreenView.leftAnchor.constraint(equalTo: favoritesButton.leftAnchor).isActive = true
        rightGreenView.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "broadcastCell"
        )
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: leftGreenView.bottomAnchor, constant: 6).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }
}

