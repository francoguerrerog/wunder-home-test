import UIKit

class CarListView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    
    static func initFromNib(owner: Any? = nil, options: [UINib.OptionsKey : Any]? = nil) -> Self {
        
        let nib = UINib(nibName: String(describing: self), bundle: Bundle(for: self))
        return nib.instantiate(withOwner: owner, options: options).first as! Self
    }
}
