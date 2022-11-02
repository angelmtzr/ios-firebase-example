import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var text = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = text
    }
    
}
