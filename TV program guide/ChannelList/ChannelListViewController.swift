//
//  ChannelListViewController.swift
//  TV program guide
//
//  Created by Александр on 18.01.2022.
//

import UIKit

class ChannelListViewController: UIViewController {
    private var listOfChannels: [Channel] = []
    
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
        button.addTarget(self, action: #selector(allButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let favoritesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Избранные", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(favoritesButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let leftGreenView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 1
        return view
    }()
    
    private let rightGreenView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        return view
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var isFiltering = false {
        didSet {
            if leftGreenView.alpha == 1 && rightGreenView.alpha == 0 {
                UIView.animate(withDuration: 0.1) { [weak self] in
                    guard let self = self else { return }
                    self.leftGreenView.alpha = 0
                    self.rightGreenView.alpha = 1
                }
            } else {
                UIView.animate(withDuration: 0.1) { [weak self] in
                    guard let self = self else { return }
                    self.leftGreenView.alpha = 1
                    self.rightGreenView.alpha = 0
            }
        }
    }
    }
  
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getListOfChannels()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        setupScreenLabel()
        setupAllButton()
        setupFavoritesButton()
        setupLeftGreenView()
        setupRightGreenView()
        setupTableView()
//        getListOfChannels()
        NetworkManager.shared.fetchData { response in
            switch response {
            case .success(let tvProram):
                print(tvProram)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func allButtonPressed() {
        isFiltering = false
    }
    
    @objc func favoritesButtonPressed() {
        isFiltering = true
    }
    
    private func setupScreenLabel() {
        view.addSubview(screenLabel)
        NSLayoutConstraint.activate([
        screenLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
        screenLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        ])
    }
    
    private func setupAllButton() {
        view.addSubview(allButton)
        NSLayoutConstraint.activate([
        allButton.topAnchor.constraint(equalTo: screenLabel.bottomAnchor, constant: 20),
        allButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/5),
        allButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25)
        ])
    }
    
    private func setupFavoritesButton() {
        view.addSubview(favoritesButton)
        NSLayoutConstraint.activate([
        favoritesButton.topAnchor.constraint(equalTo: screenLabel.bottomAnchor, constant: 20),
        favoritesButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3),
        favoritesButton.leftAnchor.constraint(equalTo: allButton.rightAnchor, constant: 20)
        ])
    }
    
    private func setupLeftGreenView() {
        view.addSubview(leftGreenView)
        NSLayoutConstraint.activate([
        leftGreenView.widthAnchor.constraint(equalTo: allButton.widthAnchor),
        leftGreenView.topAnchor.constraint(equalTo: allButton.bottomAnchor),
        leftGreenView.leftAnchor.constraint(equalTo: allButton.leftAnchor),
        leftGreenView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
    
    private func setupRightGreenView() {
        view.addSubview(rightGreenView)
        NSLayoutConstraint.activate([
        rightGreenView.widthAnchor.constraint(equalTo: favoritesButton.widthAnchor),
        rightGreenView.topAnchor.constraint(equalTo: favoritesButton.bottomAnchor),
        rightGreenView.leftAnchor.constraint(equalTo: favoritesButton.leftAnchor),
        rightGreenView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            ChannelTableViewCell.self,
            forCellReuseIdentifier: "ChannelCell"
        )
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
        tableView.topAnchor.constraint(equalTo: leftGreenView.bottomAnchor, constant: 6),
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
        self.tableView.separatorStyle = .none
    }
}

// MARK: API Methods

extension ChannelListViewController {
    func getListOfChannels() {
        NetworkManager.shared.fetchData { [weak self] response in
            switch response {
            case .success(let tvProgram):
                guard let self = self else { return }
                self.listOfChannels = tvProgram.channels
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - TableViewDataSource

extension ChannelListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listOfChannels.count
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        view.frame.width / 3
    }
}

// MARK: - TableViewDelegate

extension ChannelListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ChannelCell",
            for: indexPath
        ) as! ChannelTableViewCell
        cell.channelLabel.text = listOfChannels[indexPath.row].name
        cell.broadcastLabel.text = listOfChannels[indexPath.row].current?.title
        if let imageData = ImageManager.shared.fetchImageData(from: URL(string:listOfChannels[indexPath.row].image)) {
            cell.channelImageView.image = UIImage(data: imageData)
            cell.channelImageView.layer.cornerRadius = ( cell.channelImageView.frame.width / 2 )
        }
//        cell.favoriteButton.setImage(UIImage(named: cell.isFavorite ? "star.fill" : "star"), for: .normal)
        return cell
    }
}
