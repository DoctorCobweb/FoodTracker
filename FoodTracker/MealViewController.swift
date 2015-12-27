//
//  MealViewController.swift
//  FoodTracker
//
//  Created by andre trosky on 6/12/2015.
//  Copyright © 2015 andre trosky. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    //value is either passed in by MealTableViewController in 'prepareForSegue(_:sender:)'
    //or constructed as part of adding a new meal.
    var meal: Meal?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle the text field's user input through delegate callbacks
        nameTextField.delegate = self
        
        print("meal is: ", meal)
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        
        //enable the save button only if the text field has a valid Meal name.
        checkValidFieldName()
    }
    
    
    
    // MARK: UITextFieldDelegate
    
    //called when user hits Enter/Done on keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        // hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    //called after textField resigns as first responder
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidFieldName()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // disable save button while editing
        saveButton.enabled = false
    }
    
    func checkValidFieldName() {
        //disable the save button if the text is empty
        let text = nameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    

    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // dismiss the view controller if the user cancels it
        dismissViewControllerAnimated(true, completion: nil)
    }
    
 
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        //gets called when the user selects a photo
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage

        
        // set photoImageView to display the selected image
        photoImageView.image = selectedImage
        
        //dismiss the picker
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    
    
    // MARK: Navigation
    @IBAction func cancel(sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this 
        // view controller needs to be dismissed in two different ways.
        
        /* This creates a Boolean value that indicates whether the view controller that presented this scene is of type UINavigationController. As the constant name isPresentingInAddMealMode indicates, this means that the meal scene was presented using the Add button. This is because the meal scene is embedded in its own navigation controller when it’s presented in this manner, which means that navigation controller is what presents it.
        */
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        if isPresentingInAddMealMode {
            print("hello from isPresentingInAddMealMode true block")
            dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            navigationController!.popViewControllerAnimated(true)
        
        }
    }

    
    //this method allows you to configure a view controller before it's presented
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let name = nameTextField.text ?? ""
            let photo = photoImageView.image
            let rating = ratingControl.rating
            
            // Set the meal to be passed to MealTableViewController after the unwind segue.
            meal = Meal(name:name, photo:photo, rating:rating)
        }
    }
    
    
    
    
    
    // MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
}

