//
//  MusicTableViewCell.swift
//  MusicSearch
//
//  Created by Allan Auezkhan on 02.09.2025.
//

import UIKit
import SDWebImage

class MusicTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var artworkImageView: UIImageView!
    
    @IBOutlet weak var trackNameLabel: UILabel!
    
    @IBOutlet weak var artistNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData (music: MusicItem) {
        trackNameLabel.text = music.trackName
        artistNameLabel. text = music.artistName
        
        artworkImageView.sd_setImage(with: URL(string: music.artworkUr1100))
    }

}
