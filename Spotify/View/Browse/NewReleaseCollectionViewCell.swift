//
//  NewReleaseCollectionViewCell.swift
//  Spotify
//
//  Created by Ümit Şimşek on 13.11.2024.
//

import UIKit
import SDWebImage
class NewReleaseCollectionViewCell: UICollectionViewCell {
    static let identifier = "NewReleaseCollectionViewCell"

    
    private let albumCoverImageView:UIImageView = {
       let imgView = UIImageView()
        imgView.image = UIImage(systemName: "photo")
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    private let albumNameLabel: UILabel = {
       let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 20,weight: .semibold)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let numberOfTracksLabel : UILabel = {
       let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 18,weight: .thin)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let artistNameLabel : UILabel = {
       let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 18,weight: .light)
        lbl.numberOfLines = 0
        return lbl
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(albumNameLabel)
        contentView.addSubview(numberOfTracksLabel)
        contentView.addSubview(artistNameLabel)
        contentView.clipsToBounds = true

    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size: CGFloat = contentView.height-10
        let albumLabelSize = albumNameLabel.sizeThatFits(CGSize(width: contentView.width-size-10,
                                                                height: contentView.height-10))
        albumNameLabel.sizeToFit()
        artistNameLabel.sizeToFit()
        numberOfTracksLabel.sizeToFit()
        
        albumCoverImageView.frame = CGRect(x: 5, y: 5, width: size, height: size)
        let albumLabelHeight =  min(80, albumLabelSize.height)
        
        albumNameLabel.frame = CGRect(
            x: albumCoverImageView.right+10,
            y: 5,
            width: albumLabelSize.width,
            height:albumLabelHeight)
        
        artistNameLabel.frame = CGRect(
            x: albumCoverImageView.right+10,
            y: albumCoverImageView.bottom,
            width: contentView.width-albumCoverImageView.right-10,
            height:30)
        
        numberOfTracksLabel.frame = CGRect(
            x: albumCoverImageView.right+10,
            y: albumCoverImageView.bottom-50,
            width: numberOfTracksLabel.width,
            height: 44)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        albumNameLabel.text = nil
        artistNameLabel.text = nil
        numberOfTracksLabel.text = nil
        albumCoverImageView.image = nil
    }
    
    func configure(with viewModel: NewReleasesCellViewModel){
        albumNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        numberOfTracksLabel.text = "Tracks: \(viewModel.numberOfTracks)"
        albumCoverImageView.sd_setImage(with: viewModel.artworkURL)
        
    }
}
