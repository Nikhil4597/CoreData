//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by ROHIT MISHRA on 14/07/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    private let addUserButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add user", for: .normal)
        button.backgroundColor = .black
        button.titleLabel?.textColor = .white
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private let getUserButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get user Data", for: .normal)
        button.backgroundColor = .black
        button.titleLabel?.textColor = .white
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private let updateUserButton: UIButton = {
        let button = UIButton()
        button.setTitle("Update user data", for: .normal)
        button.backgroundColor = .black
        button.titleLabel?.textColor = .white
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private let deleteUserButton: UIButton = {
        let button = UIButton()
        button.setTitle("Remove user", for: .normal)
        button.backgroundColor = .black
        button.titleLabel?.textColor = .white
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let deleteAllUserButton: UIButton = {
        let button = UIButton()
        button.setTitle("Remove all user", for: .normal)
        button.backgroundColor = .black
        button.titleLabel?.textColor = .white
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let showStatusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .systemBlue
        label.text = ""
        label.numberOfLines = 6
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(addUserButton)
        view.addSubview(getUserButton)
        view.addSubview(updateUserButton)
        view.addSubview(deleteUserButton)
        view.addSubview(deleteAllUserButton)
        view.addSubview(showStatusLabel)
        
        addUserButton.addTarget(self, action: #selector(createData), for: .touchUpInside)
        getUserButton.addTarget(self, action: #selector(retrieveData), for: .touchUpInside)
        updateUserButton.addTarget(self, action: #selector(updateData), for: .touchUpInside)
        deleteUserButton.addTarget(self, action: #selector(deleteData), for: .touchUpInside)
        deleteAllUserButton.addTarget(self, action: #selector(deleteAllData), for: .touchUpInside)

        activeConstraints()
    }
    
    private func activeConstraints() {
        NSLayoutConstraint.activate([
            addUserButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            addUserButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            addUserButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            getUserButton.topAnchor.constraint(equalTo: addUserButton.bottomAnchor, constant: 40),
            getUserButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            getUserButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            updateUserButton.topAnchor.constraint(equalTo: getUserButton.bottomAnchor, constant: 40),
            updateUserButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            updateUserButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            deleteUserButton.topAnchor.constraint(equalTo: updateUserButton.bottomAnchor, constant: 40),
            deleteUserButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            deleteUserButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            deleteAllUserButton.topAnchor.constraint(equalTo: deleteUserButton.bottomAnchor, constant: 40),
            deleteAllUserButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            deleteAllUserButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            showStatusLabel.topAnchor.constraint(equalTo: deleteAllUserButton.bottomAnchor, constant: 40),
            showStatusLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            showStatusLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    

    
// MARK: - Core Data operations
    /*
     * Refer to persistentContainer from appdelegate
     * Create the context from persistentContainer
     * Create an entity with User
     * Create new record with this User Entity
     * Set values for the records for each key
     */
    @objc
    private func createData() {
        guard let appDelegate = UIApplication.shared.delegate as?  AppDelegate else {return}
        
        // Context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // create user entities
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        
        for i in 1...5 {
            let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
            user.setValue("Ankur\(i)", forKey: "username")
            user.setValue("ankur\(i)@gmail.com", forKey: "email")
            user.setValue("Ankur@123_\(i)", forKey: "password")
        }
        
        do {
            try managedContext.save()
            showStatusLabel.text = "Save Data Successfully"
        } catch let error as NSError {
            print("Could not save. \(error) \(error.userInfo)")
        }
    }
    
    /*
     * Prepare the request of type NSFetchRequest for the entity (User in our example)
        if required use predicate for filter data
     * Fetch the result from context in the form of array of [NSManagedObject]
     * Iterate through an array to get value for the specific key
     */
    @objc
    private func retrieveData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            var output = ""
            for data in result as! [NSManagedObject] {
                output += data.value(forKey: "username") as! String + "\n"
            }
            showStatusLabel.text = output
        } catch{
            print("Failed to reterive the data.")
        }
    }
    
    
    /*
     * Prepare the request with predicate for the entity (User in our example)
     * Fetch record and Set New value with key
     * And Last Save context same as create data.
     */
    @objc
    private func updateData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
        
        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur1")
        
        do {
            let test = try managedContext.fetch(fetchRequest)
            
            let objectUpdate = test[0] as! NSManagedObject
            objectUpdate.setValue("newname", forKey: "username")
            objectUpdate.setValue("newmail", forKey: "email")
            objectUpdate.setValue("newpassword", forKey: "password")
            
            do{
                try managedContext.save()
                showStatusLabel.text = "New User Data add successfully"
            } catch {
                print("Unable to save updated value \(error.localizedDescription)")
            }
        } catch {
            print("Unable to update data with error  \(error)")
        }
    }
    
    /*
     * Prepare the request with predicate for the entity (User in our example)
     * Fetch record and which we want to delete
     * And make context.delete(object) call (ref image attached below)
     */
    @objc
    private func deleteData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur3")
        
        do {
            let test = try managedContext.fetch(fetchRequest)
            
            let objectToDelete = test[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            
            do {
                try managedContext.save()
                showStatusLabel.text = "Delete user successfully"
            } catch {
                print("Unable to update \(error)")
            }
        } catch {
            print("Unable to delete \(error)")
        }
    }
    
    @objc
    private func deleteAllData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                managedContext.delete(data)
            }
            showStatusLabel.text = "Removed all users"
        } catch{
            print("Failed to reterive the data.")
        }
    }

}

