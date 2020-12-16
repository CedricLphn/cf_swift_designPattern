//
//  DesignPattern.swift
//  
//
//  Created by Cedric on 16/12/2020.
//

import UIKit

@objc class Person : NSObject {
    @objc dynamic var name = "Cédric"
}

class monSingleton {
    static let shared = monSingleton()
    var isChanged : Bool?
    
    private init() {
        
    }
    
    func update() {
        isChanged = true
        print("Update")
    }
}


class CommunicationViewController: UIViewController {
    
    let personA = Person() // KVO


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // notifiaction
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationAction), name: Notification.Name("NotificationIdentifier"), object : nil)
        
        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil)
        
        // Observer (KVO)
        personA.addObserver(self, forKeyPath: "name", options: NSKeyValueObservingOptions.new, context: nil)
        
        personA.name = "Solstice"
        
        // Singleton
        monSingleton.shared.update()
        
        // Target Action
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.setTitle("Hey", for: .normal)
        button.backgroundColor = .red
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(launchAction), for: .touchUpInside)
        
        
        
    }
    
    // Best practice
    deinit {
        // Notification
        NotificationCenter.default.removeObserver(self)
        // KVO
        removeObserver(personA, forKeyPath: #keyPath(Person.name))
    }
    
    // Target Action
    @objc func launchAction() {
        print("tapped");
    }
    // KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            if keyPath == #keyPath(Person.name) {
                print(change![NSKeyValueChangeKey.newKey]!)
        }
    }
    
    // Notification
    @objc func notificationAction(notification: NSNotification) {
        print("notif")
    }
}

