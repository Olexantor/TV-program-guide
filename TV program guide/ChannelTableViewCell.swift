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
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        return cellImageView
    }()
    
    let channelLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
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
        label.preferredMaxLayoutWidth = 200
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        let largeConfig = UIImage.SymbolConfiguration(
            pointSize: 30,
            weight: .bold,
            scale: .large
        )
        let largeBoldStar = UIImage(
            systemName: "star.fill",
            withConfiguration: largeConfig
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(largeBoldStar, for: .normal)
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
        setupFavoriteButton()
        setupChannelLabel()
        setupBroadcastLabel()
    }
    
    private func setupContentView() {
        contentView.frame = contentView.frame.inset(
            by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        )
        contentView.layer.cornerRadius = 10
        contentView.layer.borderColor = UIColor(
            red: 224/255,
            green: 224/255,
            blue: 224/255,
            alpha: 1
        ).cgColor
        contentView.layer.borderWidth = 1
        contentView.clipsToBounds = true
    }
    
    private func setupChannelImageView() {
        contentView.addSubview(channelImageView)
        channelImageView.contentMode = .scaleToFill
        channelImageView.layer.cornerRadius = 20
        channelImageView.clipsToBounds = true
        NSLayoutConstraint.activate([
            channelImageView.leftAnchor.constraint(
                equalTo: contentView.leftAnchor,
                constant: (contentView.frame.width / 20)
            ),
            channelImageView.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),
            channelImageView.widthAnchor.constraint(
                equalToConstant: CGFloat(contentView.frame.width / 5)
            ),
            channelImageView.heightAnchor.constraint(
                equalTo: channelImageView.widthAnchor
            )
        ])
    }
    
    private func setupChannelLabel() {
        contentView.addSubview(channelLabel)
        NSLayoutConstraint.activate([
            channelLabel.layoutMarginsGuide.topAnchor.constraint(
                equalTo: contentView.layoutMarginsGuide.topAnchor,
                constant: 16
            ),
            channelLabel.layoutMarginsGuide.leadingAnchor.constraint(
                equalTo: channelImageView.layoutMarginsGuide.trailingAnchor,
                constant: 32
            ),
            channelLabel.layoutMarginsGuide.trailingAnchor.constraint(
                equalTo: favoriteButton.layoutMarginsGuide.leadingAnchor,
                constant: -16
            )
        ])
    }
    
    private func setupBroadcastLabel() {
        contentView.addSubview(broadcastLabel)
        NSLayoutConstraint.activate([
            broadcastLabel.layoutMarginsGuide.topAnchor.constraint(
                equalTo: channelLabel.layoutMarginsGuide.topAnchor,
                constant: 32
            ),
            broadcastLabel.layoutMarginsGuide.leadingAnchor.constraint(
                equalTo: channelImageView.layoutMarginsGuide.trailingAnchor,
                constant: 32
            ),
            broadcastLabel.layoutMarginsGuide.trailingAnchor.constraint(
                equalTo: favoriteButton.layoutMarginsGuide.leadingAnchor,
                constant: -16
            )
        ])
    }
    
    private func setupFavoriteButton() {
        contentView.addSubview(favoriteButton)
        NSLayoutConstraint.activate([
            favoriteButton.centerYAnchor.constraint(
                equalTo:contentView.centerYAnchor
            ),
            favoriteButton.layoutMarginsGuide.trailingAnchor.constraint(
                equalTo: contentView.layoutMarginsGuide.trailingAnchor,
                constant: -32
            ),
            favoriteButton.widthAnchor.constraint(
                equalToConstant: 30
            ),
            favoriteButton.heightAnchor.constraint(
                equalTo: favoriteButton.widthAnchor
            )
        ])
    }
}
