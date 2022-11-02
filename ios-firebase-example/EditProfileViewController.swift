import UIKit
import FirebaseAuth
import FirebaseDatabase

class EditProfileViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var major: UITextField!
    @IBOutlet weak var semester: UITextField!
    
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayCurrentInfo()
    }
    
    @IBAction func updateInfo(_ sender: UIButton) {
        let uid = (Auth.auth().currentUser?.uid)!
        
        let newUser = ["name": name.text!,
                    "lastname": lastname.text!,
                    "major": major.text!,
                    "semester": semester.text!]
        
        ref.child("users").child(uid).setValue(newUser,
                                                 withCompletionBlock: {
            [weak self] (error, snapshot) in
            
            guard let strongSelf = self else { return }
            
            guard error == nil else {
                strongSelf.didNotUpdateInfo(error)
                return
            }
            
            strongSelf.didUpdateInfo()
        })
    }
    
    private func displayCurrentInfo() {
        let uid = Auth.auth().currentUser?.uid
        
        ref.child("users").child(uid!).getData(completion: {
            [weak self] error, snapshot in
            
            guard let strongSelf = self else { return }
            
            guard error == nil else {
                print(error!.localizedDescription)
                return;
            }

            strongSelf.name.text = (snapshot?
                .childSnapshot(forPath: "name").value as! String)
            strongSelf.lastname.text = (snapshot?
                .childSnapshot(forPath: "lastname").value as! String)
            strongSelf.major.text = (snapshot?
                .childSnapshot(forPath: "major").value as! String)
            strongSelf.semester.text = (snapshot?
                .childSnapshot(forPath: "semester").value as! String)
        });
    }
    
    private func didUpdateInfo() {
        let alert = UIAlertController(title: "Success",
                                      message: "Your changes were made.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func didNotUpdateInfo(_ error: Error?) {
        let alert = UIAlertController(title: "Error",
                          message: error!.localizedDescription,
                          preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
}
