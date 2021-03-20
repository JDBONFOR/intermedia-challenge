import UIKit

class ComicsSectionHeroeCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    
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
extension ComicsSectionHeroeCell {
    
    func setupCell(_ model: ComicsSectionHeroeCellViewModel) {
        
        titleLabel.text = model.title
    }
    
    func clean() {
        titleLabel.text = nil
    }
    
}
