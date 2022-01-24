//
//  ChannelTableViewCell.swift
//  TV program guide
//
//  Created by Александр on 24.01.2022.
//

import Foundation
import UIKit

class ChannelTableViewCell: UITableViewCell {
    
    let isFavorite = false
    
    let channelImageView: UIImageView = {
        let cellImageView = UIImageView()
//        cellImageView.contentMode = .scaleAspectFill
//        cellImageView.layer.cornerRadius = 10
//            (cellImageView.frame.size.height)/2
//        cellImageView.clipsToBounds = true
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        return cellImageView
    }()
    
    let channelLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.preferredMaxLayoutWidth = 100
       label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    let broadcastLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "star.fill"), for: .normal)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupContentView()
    }
    
    override func layoutIfNeeded() {
        setupChannelImageView()
        setupChannelLabel()
        setupBroadcastLabel()
        setupFavoriteButton()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupContentView() {
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        contentView.layer.cornerRadius = 10
        contentView.layer.borderColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1).cgColor
        contentView.layer.borderWidth = 1
        contentView.clipsToBounds = true
    }
    
//    private func setImageForFavoriteButtonn() {
//        if !isFavorite {
//            favoriteButton.setImage(UIImage(named: "star"), for: .normal)
//        } else {
//            favoriteButton.setImage(UIImage(named: "star.fill"), for: .normal)
//        }
//    }
    
    private func setupChannelImageView() {
        addSubview(channelImageView)
        channelImageView.contentMode = .scaleAspectFit
        channelImageView.layer.cornerRadius = 20
        channelImageView.clipsToBounds = true
        NSLayoutConstraint.activate([
        channelImageView.topAnchor.constraint(equalTo:contentView.topAnchor, constant: (contentView.frame.width / 15)),
        channelImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: (contentView.frame.width / 20)),
        channelImageView.widthAnchor.constraint(equalToConstant: CGFloat(contentView.frame.width / 5)),
        channelImageView.heightAnchor.constraint(equalTo: channelImageView.widthAnchor)
        ])
    }
    
    private func setupChannelLabel() {
        addSubview(channelLabel)
        NSLayoutConstraint.activate([
            channelLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: (contentView.frame.height / 3.5)),
            channelLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: (contentView.frame.width / 3.5 )),
            channelLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 200)
        ])
    }
    
    private func setupBroadcastLabel() {
        addSubview(broadcastLabel)
        NSLayoutConstraint.activate([
            broadcastLabel.topAnchor.constraint(equalTo:contentView.topAnchor, constant: (contentView.frame.height / 1.8)),
            broadcastLabel.leftAnchor.constraint(equalTo: channelLabel.leftAnchor),
//            broadcastLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    private func setupFavoriteButton() {
        addSubview(favoriteButton)
        NSLayoutConstraint.activate([
            favoriteButton.centerYAnchor.constraint(equalTo:contentView.centerYAnchor),
            favoriteButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
//            favoriteButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -25),
//            favoriteButton.widthAnchor.constraint(equalToConstant: 30)
            
        ])
    }
    
    
}
