import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    
    let options = ["Edit Profile", "Log out"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
    }
    
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section:
                   Int) -> Int {
        
        return options.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath:
                   IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell (style: .default, reuseIdentifier: "cel")
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath.row == 0) {
            performSegue(withIdentifier: "editProfile", sender: self)
        }
        else {
            do {
                try Auth.auth().signOut()
                navigationController?.popViewController(animated: true)
            } catch let signOutError as NSError{
                print(signOutError)
            }
        }
    }
}
