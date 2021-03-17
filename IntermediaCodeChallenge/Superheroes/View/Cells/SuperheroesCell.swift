import UIKit
import SDWebImage

class SuperheroesCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var avatarImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
        
}

// MARK: - Extension
extension SuperheroesCell {
    
    func setupCell(_ model: HeroesModel) {
        
        titleLabel.text = model.name
        descriptionLabel.text = model.description
        
        let imageUrl = model.thumbnail.path + "." + model.thumbnail.fileExtension

        SDWebImageDownloader.shared().downloadImage(with: URL(string: imageUrl), options: [SDWebImageDownloaderOptions.allowInvalidSSLCertificates, SDWebImageDownloaderOptions.useNSURLCache, SDWebImageDownloaderOptions.scaleDownLargeImages], progress: nil, completed: { [weak self] (image, data, error, result) in
            guard let self = self, let image = image else { return }
            self.avatarImage.image = image
        })
    }
    
}
