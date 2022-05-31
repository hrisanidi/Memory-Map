//Created by Vladislav Khrisanov (xkhris00)

import Foundation
import CoreData
import UIKit

//Managing CoreData
struct DataController {
    static let shared = DataController()

    let container = NSPersistentContainer(name: "DataModel")

    //Loading a model and giving an access to the data inside
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("\(error.localizedDescription)")
            }
        }
    }

    //Saving data and error handling
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved successfully")
        } catch {
            let nsError = error as NSError
            fatalError("\(nsError), \(nsError.userInfo)")
        }
    }

    //Function for adding new location
    func addLocation(name: String, image: UIImage, review: String, latitude: Double, longitude: Double, context: NSManagedObjectContext) {
        let location = LocationProfile(context: context)
        let jpegImageData = image.jpegData(compressionQuality: 1.0)
        
        location.id = UUID()
        location.date = Date()
        location.name = name
        location.review = review
        location.picture = jpegImageData
        location.latitude = latitude
        location.longitude = longitude

        save(context: context)
    }
    
    //Function for editing location
    func editLocation(location: LocationProfile, name: String, image: UIImage, review: String, context: NSManagedObjectContext) {
        let jpegImageData = image.jpegData(compressionQuality: 1.0)

        location.name = name
        location.review = review
        location.picture = jpegImageData

        save(context: context)
    }
}

