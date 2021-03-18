import UIKit
import SDWebImage

class HeaderSectionHeroeCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clean()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        clean()
    }
        
}

// MARK: - Extension
extension HeaderSectionHeroeCell {
    
    func setupCell(_ model: HeaderSectionHeroeCellViewModel) {
        
        let imageUrl: String = model.imageUrl
        
        SDWebImageDownloader.shared().downloadImage(with: URL(string: imageUrl), options: [SDWebImageDownloaderOptions.allowInvalidSSLCertificates, SDWebImageDownloaderOptions.useNSURLCache, SDWebImageDownloaderOptions.scaleDownLargeImages], progress: nil, completed: { [weak self] (image, data, error, result) in
            guard let self = self, let image = image else { return }
            self.avatarImage.image = image
        })
        
        descriptionLabel.text = model.description
    }
    
    func clean() {
        avatarImage.image = nil
        descriptionLabel.text = nil
    }
    
}
