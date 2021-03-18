import UIKit

class TitleSectionHeroeCell: UITableViewCell {

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
extension TitleSectionHeroeCell {
    
    func setupCell(_ model: TitleSectionHeroeCellViewModel) {
        
        titleLabel.text = model.title
    }
    
    func clean() {
        titleLabel.text = nil
    }
    
}
