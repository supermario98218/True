//
//  HomeViewController.swift
//  
//
//  Created by Mario Garcia on 3/24/17.
//
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class HomeViewController: UIViewController {

    var hallsArray = [Hall]()
    var dataBaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    var storageRef: FIRStorage {
        
        return FIRStorage.storage()
    }

    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var seatsAvLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var totalInTodayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDiningHall()
        //print(halls[1])
        //configureLabels(halls: hallsArray[1])
            
        
        // Do any additional setup after loading the view.
    }
    
    func fetchDiningHall(){
        
        dataBaseRef.child("UGADiningHall").observeSingleEvent(of: .value, with: { (snapshot) in
            var results = [Hall]()
            for halls in snapshot.children{
                let halls = Hall(snapshot: halls as! FIRDataSnapshot)//cuts off here, jumps to Struct Hall...does everything and stops on init
                results.append(halls)
                
            }//ends for
            self.hallsArray = results.sorted(by: { (u1, u2) -> Bool in
                u1.name < u2.name
            })
            
        
        })
        
    }
    func configureLabels(halls: Hall){
        //add text to all labels
        self.addressLabel.text = halls.name
        //self.price.text = "\(res.price as String)"
       // self.waitTime.text = "\(res.waitTime as Int) min"
        self.capacityLabel.text = "\(halls.capacity as Int)"
        self.latitudeLabel.text = "\(halls.latitude as Double)"
        self.longitudeLabel.text = "\(halls.longitude as Double)"
        self.nameLabel.text = halls.name
        self.seatsAvLabel.text = "\(halls.seatsAvailable as Int)"
        self.timeLabel.text = "\(halls.time as Int)"
        self.totalInTodayLabel.text = "\(halls.totalInToday as Int)"
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
