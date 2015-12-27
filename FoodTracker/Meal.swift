//
//  Meal.swift
//  FoodTracker
//
//  Created by andre trosky on 17/12/2015.
//  Copyright © 2015 andre trosky. All rights reserved.
//

import UIKit

class Meal: NSObject, NSCoding {
    
    //You’re making these variables (var) instead of constants (let) because they’ll need
    //to change throughout the course of a Meal object’s lifetime.

    //MARK: Properties
    
    struct PropertyKey {
        static let nameKey = "name"
        static let photoKey = "photo"
        static let ratingKey = "rating"
    }
    
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    // MARK: Archiving paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("meals")
    
    
    
    
    //MARK: Designated initializer
    init?(name: String, photo: UIImage?, rating: Int) {
    
        self.name = name
        self.photo = photo
        self.rating = rating
        
        // a designated intializer must call thru to its superclass's initializer
        super.init()
        
        
        if name.isEmpty || rating < 0 {
            return nil
        }
    }
    
    // Mark: NSCoding
    
    // prepares the class's information to be archived
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
        aCoder.encodeInteger(rating, forKey: PropertyKey.ratingKey)
    }
    
    
    //The convenience keyword denotes this initializer as a convenience initializer.
    //Convenience initializers are secondary, supporting initializers that need to call
    //one of their class’s designated initializers.
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        
        //because photo is an optional property of Meal, use conditional cast
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        let rating = aDecoder.decodeIntegerForKey(PropertyKey.ratingKey)
        
        // must call designated initializer
        self.init(name:name, photo:photo, rating:rating)
    }


}