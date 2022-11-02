import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var major: UITextField!
    @IBOutlet weak var semester: UITextField!
    
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        Auth.auth()
            .createUser(withEmail: email.text!, password: password.text!) {
                [weak self] authResult, error in
                
                guard let strongSelf = self else { return }
                
                guard let user = authResult?.user, error == nil else {
                    strongSelf.didNotCreateUser(error)
                    return
                }
                strongSelf.didCreateUser(user)
        }
    }
    
    private func didCreateUser(_ user: User) {
        let newUser = ["name": name.text!,
                       "lastname": lastname.text!,
                       "major": major.text!,
                       "semester": semester.text!]
        
        self.ref.child("users").child(user.uid).setValue(newUser)
        
        let alert = UIAlertController(title: "Success",
                                      message: "Signed up successfully.\n" +
                                      "\(user.email!)",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func didNotCreateUser(_ error: Error?) {
        let alert = UIAlertController(title: "Error",
                          message: error!.localizedDescription,
                          preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
}
