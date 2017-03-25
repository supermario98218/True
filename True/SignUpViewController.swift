//
//  SignUpViewController.swift
//  True
//
//  Created by Mario Garcia on 3/23/17.
//  Copyright © 2016 Mario Garcia. All rights reserved.
//

import UIKit


class SignUpViewController: UIViewController {
    
    @IBOutlet weak var userImageView: UIImageView! {
        didSet{
            userImageView.clipsToBounds = true
            userImageView.layer.borderColor = UIColor.white.cgColor
             userImageView.layer.borderWidth = 2
             userImageView.layer.masksToBounds = true
            userImageView.isUserInteractionEnabled = true
            
        }
    }
    
    @IBOutlet weak var firstAndLastNameTextField: UITextField!{ didSet{
        firstAndLastNameTextField.attributedPlaceholder = NSAttributedString(string:"First and Last Name", attributes: [NSForegroundColorAttributeName: UIColor.black])
        firstAndLastNameTextField.layer.cornerRadius = 15
        firstAndLastNameTextField.layer.borderWidth = 3
        firstAndLastNameTextField.layer.borderColor = UIColor.white.cgColor
        firstAndLastNameTextField.delegate = self
        }
    }
    
    @IBOutlet weak var userNameTextField: UITextField!{ didSet{
        userNameTextField.attributedPlaceholder = NSAttributedString(string:"Username", attributes: [NSForegroundColorAttributeName: UIColor.black])
        
        userNameTextField.layer.cornerRadius = 15
        userNameTextField.layer.borderWidth = 3
        userNameTextField.layer.borderColor = UIColor.white.cgColor
        userNameTextField.delegate = self
        }
    }
    
    @IBOutlet weak var emailTextField: UITextField!{ didSet{
        emailTextField.attributedPlaceholder = NSAttributedString(string:"Email", attributes: [NSForegroundColorAttributeName: UIColor.black])
        emailTextField.layer.cornerRadius = 15
        emailTextField.layer.borderWidth = 3
        emailTextField.layer.borderColor = UIColor.white.cgColor
        emailTextField.delegate = self
        }
    }
    
    @IBOutlet weak var phoneNumberTextField: UITextField!{ didSet{
        phoneNumberTextField.attributedPlaceholder = NSAttributedString(string:"Phone Number", attributes: [NSForegroundColorAttributeName: UIColor.black])
        phoneNumberTextField.layer.cornerRadius = 15
        phoneNumberTextField.layer.borderWidth = 3
        phoneNumberTextField.layer.borderColor = UIColor.white.cgColor
        phoneNumberTextField.delegate = self
        }
    }
    
    @IBOutlet weak var passwordTextField: UITextField!{ didSet{
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string:"Password", attributes: [NSForegroundColorAttributeName: UIColor.black])
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.layer.borderWidth = 3
        passwordTextField.layer.borderColor = UIColor.white.cgColor
        passwordTextField.delegate = self
        }
    }
    
    @IBOutlet weak var rePassword: UITextField!{ didSet{
        
        rePassword.attributedPlaceholder = NSAttributedString(string:"Re Password", attributes: [NSForegroundColorAttributeName: UIColor.black])
        rePassword.layer.cornerRadius = 15
        rePassword.layer.borderWidth = 3
        rePassword.layer.borderColor = UIColor.white.cgColor
        rePassword.delegate = self
        }
    }
    @IBOutlet weak var signUpButton: UIButton!{ didSet{
        
        
        signUpButton.layer.cornerRadius = 15
        signUpButton.layer.borderWidth = 0
        
        }
    }
    
    @IBOutlet weak var backLogin: UIButton!{ didSet{
        backLogin.layer.cornerRadius = 15
        backLogin.layer.borderWidth = 0
        
        }
    }
    
    @IBAction func backLogin(_ sender: UIButton) {
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "logInMenu") as! ViewController
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
//    @IBAction func termsOfUseButton(_ sender: UIButton) {
//        let url = URL(string: "http://www.google.com")!
//        if #available(iOS 10.0, *) {
//            UIApplication.shared.open(url, options: [:], completionHandler: nil)
//        } else {
//            UIApplication.shared.openURL(url)
//        }
//    }
//    @IBAction func privacyPolicyButton(_ sender: UIButton) {
//        let url = URL(string: "http://www.yahoo.com")!
//        if #available(iOS 10.0, *) {
//            UIApplication.shared.open(url, options: [:], completionHandler: nil)
//        } else {
//            UIApplication.shared.openURL(url)
//        }
//    }
    
    
    var authentication = Authentication()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //assignBackground()
        setGestureRecognizersToDismissKeyboard()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func userNameTaken(){
        let alertController = UIAlertController(title: "Error", message: "A user with the same user name already exists. Please choose another one", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func signUpAction(sender: UIButton){
        let email = emailTextField.text!.lowercased()
        let finalEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let phoneNumber = phoneNumberTextField.text!
        let userName = userNameTextField.text!
        let password = passwordTextField.text!
        let rePasswordString = rePassword.text!
        let firstandLastName = firstAndLastNameTextField.text!
        let pictureData = UIImageJPEGRepresentation(self.userImageView.image!, 0.70)
        
        if finalEmail.isEmpty || phoneNumber.isEmpty || userName.isEmpty || password.isEmpty || firstandLastName.isEmpty {
            self.view.endEditing(true)
            let alertController = UIAlertController(title: "Error", message: "Please fill in all fields!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Try Again", style: .cancel, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
        else if password != rePasswordString {
            self.view.endEditing(true)
            let alertController = UIAlertController(title: "Failed to create account", message: "Passwords do not match!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Try Again", style: .cancel, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
        else if password.characters.count < 5 {
            let alertController = UIAlertController(title: "Error", message: "Passwords must contain more than 5 characters", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Try Again", style: .cancel, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
        else if phoneNumber.characters.count != 10 {
            let alertController = UIAlertController(title: "Error", message: "Invalid Phone Number", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Try Again", style: .cancel, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
        else{
            self.view.endEditing(true)
            authentication.signUp(firstAndLastName: firstandLastName, userName: userName, email: finalEmail, phoneNumber: phoneNumber, password: password, pictureData: pictureData as NSData!)
            
        }
    }
    
//    func assignBackground(){
//        UIGraphicsBeginImageContext(self.view.frame.size)
//        UIImage(named: "sample3")?.draw(in: self.view.bounds)
//        
//        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
//        
//        UIGraphicsEndImageContext()
//        
//        self.view.backgroundColor = UIColor(patternImage: image)
//    }
    
}


extension SignUpViewController: UITextFieldDelegate, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func setGestureRecognizersToDismissKeyboard(){
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.choosePictureAction(sender:)))
        imageTapGesture.numberOfTapsRequired = 1
        userImageView.addGestureRecognizer(imageTapGesture)
        
        // Creating Tap Gesture to dismiss Keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.dismissKeyboard(gesture:)))
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)
        
        // Creating Swipe Gesture to dismiss Keyboard
        let swipDown = UISwipeGestureRecognizer(target: self, action: #selector(SignUpViewController.dismissKeyboard(gesture:)))
        swipDown.direction = .down
        view.addGestureRecognizer(swipDown)
    }
    
    func choosePictureAction(sender: AnyObject) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        
        let alertController = UIAlertController(title: "Add a Profile Picture", message: "Choose From", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            pickerController.sourceType = .camera
            self.present(pickerController, animated: true, completion: nil)
            
        }
        let photosLibraryAction = UIAlertAction(title: "Photos Library", style: .default) { (action) in
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
            
        }
        
        let savedPhotosAction = UIAlertAction(title: "Saved Photos Album", style: .default) { (action) in
            pickerController.sourceType = .savedPhotosAlbum
            self.present(pickerController, animated: true, completion: nil)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alertController.addAction(cameraAction)
        alertController.addAction(photosLibraryAction)
        alertController.addAction(savedPhotosAction)
        alertController.addAction(cancelAction)
        
        
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage]  as? UIImage{
            self.userImageView.image = image
        }else if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.userImageView.image = image
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    //    @IBAction func unwindToLogin(storyboard: UIStoryboardSegue){}
    
    // Dismissing the Keyboard with the Return Keyboard Button
    func dismissKeyboard(gesture: UIGestureRecognizer){
        self.view.endEditing(true)
    }
    
    // Dismissing the Keyboard with the Return Keyboard Button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        phoneNumberTextField.resignFirstResponder()
        return true
    }
    
    // Moving the View down after the Keyboard appears
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateView(up: true, moveValue: 45)
    }
    
    // Moving the View down after the Keyboard disappears
    func textFieldDidEndEditing(_ textField: UITextField) {
        animateView(up: false, moveValue: 45)
    }
    
    
    // Move the View Up & Down when the Keyboard appears
    func animateView(up: Bool, moveValue: CGFloat){
        
        let movementDuration: TimeInterval = 0.3
        let movement: CGFloat = (up ? -moveValue : moveValue)
        UIView.beginAnimations("animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    
    
}
