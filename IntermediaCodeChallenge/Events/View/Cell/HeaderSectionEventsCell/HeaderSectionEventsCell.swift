import UIKit
import SDWebImage

class HeaderSectionEventsCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var collapseIndicadorImage: UIImageView!
    
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
extension HeaderSectionEventsCell {
    
    func setupCell(_ model: HeaderSectionEventsCellViewModel) {
                        
        titleLabel.text = model.title
        
        if let start = model.startDate {
            startLabel.text = Utils.formateDate(start)
        }
        if let end = model.dueDate {
            endLabel.text = Utils.formateDate(end)
        }

        SDWebImageDownloader.shared().downloadImage(with: URL(string: model.imageUrl), options: [SDWebImageDownloaderOptions.allowInvalidSSLCertificates, SDWebImageDownloaderOptions.useNSURLCache, SDWebImageDownloaderOptions.scaleDownLargeImages], progress: nil, completed: { [weak self] (image, data, error, result) in
            guard let self = self, let image = image else { return }
            self.avatarImage.image = image
        })
        
        toggleCollapseIndicator(model.isOpened)
    }
    
    func clean() {
        avatarImage.image = nil
        titleLabel.text = nil
        startLabel.text = nil
        endLabel.text = nil
        collapseIndicadorImage.image = nil
    }
    
    func setupCellCommics(_ comic: ComicsItems) {
        titleLabel.text = comic.name
    }
    
    func toggleCollapseIndicator(_ status: Bool) {
        
        collapseIndicadorImage.image = UIImage(named: "cell-arrow")
        collapseIndicadorImage.transform = .identity
        UIView.animate(withDuration: 0.6) {
            if status {
                self.collapseIndicadorImage.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
            } else {
                self.collapseIndicadorImage.transform = CGAffineTransform(rotationAngle: 0.0)
            }
        }
    }
    
}
