import UIKit

class EventsCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}

// MARK: - Extension
extension EventsCell {
    
    func setupCell(_ model: EventsModel) {
        
//        titleLabel.text = model.name
//        descriptionLabel.text = model.description
//
//        let imageUrl = model.thumbnail.path + "." + model.thumbnail.fileExtension
//
//        SDWebImageDownloader.shared().downloadImage(with: URL(string: imageUrl), options: [SDWebImageDownloaderOptions.allowInvalidSSLCertificates, SDWebImageDownloaderOptions.useNSURLCache, SDWebImageDownloaderOptions.scaleDownLargeImages], progress: nil, completed: { [weak self] (image, data, error, result) in
//            guard let self = self, let image = image else { return }
//            self.avatarImage.image = image
//        })
    }
    
}
