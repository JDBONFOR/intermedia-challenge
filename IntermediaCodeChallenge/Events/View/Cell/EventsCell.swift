import UIKit
import SDWebImage

class EventsCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    
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
extension EventsCell {
    
    func setupCell(_ model: EventsModel) {
        
        titleLabel.text = model.title
        
        if let start = model.start {
            startLabel.text = Utils.formateDate(start)
        }
        if let end = model.end {
            endLabel.text = Utils.formateDate(end)
        }

        let imageUrl = model.thumbnail.path + "." + model.thumbnail.fileExtension

        SDWebImageDownloader.shared().downloadImage(with: URL(string: imageUrl), options: [SDWebImageDownloaderOptions.allowInvalidSSLCertificates, SDWebImageDownloaderOptions.useNSURLCache, SDWebImageDownloaderOptions.scaleDownLargeImages], progress: nil, completed: { [weak self] (image, data, error, result) in
            guard let self = self, let image = image else { return }
            self.avatarImage.image = image
        })
    }
    
    func clean() {
        avatarImage.image = nil
        titleLabel.text = ""
        startLabel.text = ""
        endLabel.text = ""
    }
    
}
