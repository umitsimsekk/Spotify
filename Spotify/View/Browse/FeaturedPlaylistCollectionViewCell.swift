//
//  FeaturedPlaylistCollectionViewCell.swift
//  Spotify
//
//  Created by Ümit Şimşek on 13.11.2024.
//

import UIKit

class FeaturedPlaylistCollectionViewCell: UICollectionViewCell {
    static let identifier = "FeaturedPlaylistCollectionViewCell"

    private let playlistCoverImageView:UIImageView = {
       let imgView = UIImageView()
        imgView.image = UIImage(systemName: "photo")
        imgView.layer.masksToBounds = true
        imgView.layer.cornerRadius = 4
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    private let playlistNameLabel: UILabel = {
       let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 20,weight: .semibold)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let creatorNameLabel : UILabel = {
       let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 18,weight: .light)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(playlistCoverImageView)
        contentView.addSubview(playlistNameLabel)
        contentView.addSubview(creatorNameLabel)
        contentView.clipsToBounds = true

    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size: CGFloat = contentView.height-70
        
        playlistCoverImageView.frame = CGRect(x: (contentView.width-size)/2, y: 3, width: size, height: size)
        
        playlistNameLabel.frame = CGRect(
            x: 3,
            y: contentView.height-60,
            width: contentView.width-6,
            height:4)
        
        creatorNameLabel.frame = CGRect(
            x: 3,
            y: contentView.height-44,
            width: contentView.width-6,
            height:30)
       
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playlistNameLabel.text = nil
        creatorNameLabel.text = nil
        playlistCoverImageView.image = nil
    }
    
    func configure(with viewModel: FeaturedPlaylistCellViewModel){
        playlistNameLabel.text = viewModel.name
        creatorNameLabel.text = viewModel.creatorName
        playlistCoverImageView.sd_setImage(with: viewModel.artworkURL)
        
    }
}
