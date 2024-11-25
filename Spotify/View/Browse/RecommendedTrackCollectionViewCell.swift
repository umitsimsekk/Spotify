//
//  RecommendedTrackCollectionViewCell.swift
//  Spotify
//
//  Created by Ümit Şimşek on 13.11.2024.
//

import UIKit

class RecommendedTrackCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecommendedTrackCollectionViewCell"
    
    private let albumCoverImageView:UIImageView = {
       let imgView = UIImageView()
        imgView.image = UIImage(systemName: "photo")
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    private let trackNameLabel: UILabel = {
       let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 20,weight: .semibold)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let artistNameLabel : UILabel = {
       let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 18,weight: .light)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(artistNameLabel)
        contentView.clipsToBounds = true

    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size: CGFloat = contentView.height-70
        
        albumCoverImageView.frame = CGRect(x: 5,
                                              y: 2,
                                              width: contentView.height-4,
                                              height: contentView.height-4)
        trackNameLabel.frame = CGRect(x: albumCoverImageView.right+10,
                                      y: 0,
                                      width: contentView.width-albumCoverImageView.right-15,
                                      height: contentView.height/2)
        artistNameLabel.frame = CGRect(x: albumCoverImageView.right+10,
                                       y: contentView.height/2,
                                      width: contentView.width-albumCoverImageView.right-15,
                                      height: contentView.height/2)
       
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackNameLabel.text = nil
        artistNameLabel.text = nil
        albumCoverImageView.image = nil
    }
    
    func configure(with viewModel: RecommendedTracksCellViewModel){
        trackNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        albumCoverImageView.sd_setImage(with: viewModel.artworkURL)
        
    }
}
