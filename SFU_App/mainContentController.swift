//
//  mainContentController.swift
//  SFU_App
//
//  Created by Jerrod Seger on 2015-03-24.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//

import Foundation
import UIKit



class classCell: UITableViewCell{
    
    @IBOutlet weak var className: UILabel!
    @IBOutlet weak var classDesc: UILabel!
    @IBOutlet weak var classInstruct: UILabel!
    @IBOutlet weak var classTimes: UILabel!
    @IBOutlet weak var classDays: UILabel!
    @IBOutlet weak var classLocation: UILabel!
    
    
}

var arr: [courses] = []

var courseList: [courseLists] = []


class mainContentController: UITableViewController, ENSideMenuDelegate {
    
    @IBOutlet weak var subView1: UIView!
    @IBOutlet weak var subView2: UIView!
    @IBOutlet weak var subView3: UIView!
    
    @IBOutlet weak var instagramImage: UIImageView!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    // Create a reachability object
    let reachability = Reachability.reachabilityForInternetConnection()
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        //Check internet connection to instantly return
        if(Reachability.isConnectedToNetwork() == false){
            return
        }
        
        // Prepare notifier which constantly observes for connection in the background
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: ReachabilityChangedNotification, object: reachability)
        reachability.startNotifier()
       
        
       println("should be done")
        println(courseList.count);
        
        println("TEST")
        var randomImage: UInt32 = (arc4random_uniform(12) + 1)
        var rdnImage = UIImage(named: "1.png") as UIImage!
        if randomImage == 1{
            rdnImage = UIImage(named: "1.png") as UIImage!
        }else if randomImage == 2{
            rdnImage = UIImage(named: "2.png") as UIImage!
        }else if randomImage == 3{
            rdnImage = UIImage(named: "3.png") as UIImage!
        }else if randomImage == 4{
            rdnImage = UIImage(named: "4.png") as UIImage!
        }else if randomImage == 5{
            rdnImage = UIImage(named: "5.png") as UIImage!
        }else if randomImage == 6{
            rdnImage = UIImage(named: "6.png") as UIImage!
        }else if randomImage == 7{
            rdnImage = UIImage(named: "7.png") as UIImage!
        }else if randomImage == 8{
            rdnImage = UIImage(named: "8.png") as UIImage!
        }else if randomImage == 9{
            rdnImage = UIImage(named: "9.png") as UIImage!
        }else if randomImage == 10{
            rdnImage = UIImage(named: "10.png") as UIImage!
        }else if randomImage == 11{
            rdnImage = UIImage(named: "11.png") as UIImage!
        }
        
        instagramImage.image = rdnImage
        
        self.sideMenuController()?.sideMenu?.delegate = self;
        
        let shadowPath = UIBezierPath(rect: subView1.bounds)
        subView1.layer.masksToBounds = false
        subView1.layer.shadowColor = UIColor.blackColor().CGColor
        subView1.layer.shadowOffset = CGSizeMake(0, 0.5)
        subView1.layer.shadowOpacity = 0.1
        subView1.layer.shadowPath = shadowPath.CGPath
        
        let shadowPath2 = UIBezierPath(rect: subView2.bounds)
        subView2.layer.masksToBounds = false
        subView2.layer.shadowColor = UIColor.blackColor().CGColor
        subView2.layer.shadowOffset = CGSizeMake(0, 0.5)
        subView2.layer.shadowOpacity = 0.1
        subView2.layer.shadowPath = shadowPath2.CGPath
        
        let shadowPath3 = UIBezierPath(rect: subView3.bounds)
        subView3.layer.masksToBounds = false
        subView3.layer.shadowColor = UIColor.blackColor().CGColor
        subView3.layer.shadowOffset = CGSizeMake(0, 0.5)
        subView3.layer.shadowOpacity = 0.1
        subView3.layer.shadowPath = shadowPath3.CGPath
        
        
        
        
        var response2: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
        var error2: NSErrorPointer = nil
                
        let url = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=Burnaby,CA&units=metric")
        let request = NSURLRequest(URL: url!)
        
        var dataVal: NSData =  NSURLConnection.sendSynchronousRequest(request, returningResponse: response2, error:nil)!
            
        let json = JSON(data: dataVal)
        var humidity = "NaN"
        var description = "NaN"
        var weatherid = "NaN".toInt()
        let temperature = json["main"]["temp"].stringValue
        humidity = json["main"]["humidity"].stringValue
        description = json["weather"][0]["description"].stringValue
        weatherid = json["weather"][0]["id"].stringValue.toInt()
        var index2 = temperature.rangeOfString(".", options: .BackwardsSearch)?.startIndex
        if(temperature.isEmpty){
            let temperatureStr = " null"
        }else{
            let temperatureStr = temperature.substringToIndex(index2!)
          temp.text = temperatureStr + "°C"}
        
        //humid.text = humidity + "%"
        //weatherDesc.text = description.capitalizedString
        
        let moon = UIImage(named: "moon.png") as UIImage!
        let thunder = UIImage(named: "thunder.png") as UIImage!
        let cloudy = UIImage(named: "cloudy.png") as UIImage!
        let suncloud = UIImage(named: "suncloud.png") as UIImage!
        let snow = UIImage(named: "snow.png") as UIImage!
        let rain = UIImage(named: "rain.png") as UIImage!
        let sunny = UIImage(named: "sunny.png") as UIImage!
        
        if weatherid >= 600 && weatherid <= 622{
            weatherIcon.image = snow
        }else
        if weatherid >= 802 && weatherid <= 804{
            weatherIcon.image = cloudy
        }else
        if weatherid == 801{
            weatherIcon.image = suncloud
        }else
        if weatherid == 80{
            weatherIcon.image = sunny
        }else
        if weatherid >= 200 && weatherid <= 232{
            weatherIcon.image = thunder
        }else
        if weatherid >= 300 && weatherid <= 321{
            weatherIcon.image = rain
        }else
        if weatherid >= 500 && weatherid <= 531{
            weatherIcon.image = rain
        }else{
            weatherIcon.image = cloudy
        }
        
       
        //self.updateSch()
    }
    
    // Deinitializes notifier
    deinit {
        reachability.stopNotifier()
    }
    
    // adds matrix to database
    func updateSch () -> Void {
        var POSTrequest = NSMutableURLRequest(URL: NSURL( string: "http://cmpt275team1.hostoi.com/Time.php")!)
        var name : NSString = defaults.stringForKey("usernameKey")!
        var session = NSURLSession.sharedSession()
        POSTrequest.HTTPMethod="POST"
        POSTrequest.addValue("application/x-www-form-urlencoded",forHTTPHeaderField: "Content-Type")
        var matrix = CreateMatrix()
        var body = "USERID=\(name)&Sch=\(matrix)"
        POSTrequest.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
        
        var DataTask = session.dataTaskWithRequest(POSTrequest) {
            data, response, error in
            
            if(error != nil){
                println("error=\(error)")
                return;
            }
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
           // println(strData)
        }
        
        DataTask.resume()
        println(matrix)
    }



        
    // update user schedule with new matrix
        
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        println("MEM")
    }
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    // MARK: - ENSideMenu Delegate
    func sideMenuWillOpen() {
        println("sideMenuWillOpen")
    }
    
    func sideMenuWillClose() {
        println("sideMenuWillClose")
    }
    
    func sideMenuShouldOpenSideMenu() -> Bool {
        println("sideMenuShouldOpenSideMenu")
        return true;
    }
    
    // Function to output alert when internet connection changed
    func reachabilityChanged(note: NSNotification) {
        
        let reachability = note.object as Reachability
        
        if reachability.isReachable() {
            if reachability.isReachableViaWiFi() {
                println("Reachable via WiFi")
            } else {
                println("Reachable via Cellular")
            }
        } else {
            println("Not reachable")
            let alertController = UIAlertController(title: "Error", message: "No internet connection detected", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
  
    
    
    
    
    
    
    
    
    
    
    
    
    
}