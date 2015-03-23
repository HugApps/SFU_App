import Foundation
import UIKit

class NewsController: UITableViewController, NSXMLParserDelegate,ENSideMenuDelegate {
    let urlstring = "http://www.nasa.gov/rss/dyn/breaking_news.rss"
    var element:NSString = ""
    var items:[String] = []
    var item = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set slide menu control to this controller
        self.sideMenuController()?.sideMenu?.delegate = self;
        
        //   dispatch_queue_t myQueue = dispatch_queue_create("queue",NULL)
        println("TEST")
        loadParser()
    }
    
    // MARK: - ENSideMenu Delegate
    func sideMenuWillOpen() {
        println("sideMenuWillOpen")
    }
    
    func sideMenuWillClose() {
        println("sideMenuWillClose")
    }
    // disabled Slide Menu
    func sideMenuShouldOpenSideMenu() -> Bool {
        println("sideMenuShouldOpenSideMenu")
        return false;
    }
    
    //MARK - tableviewdelegate
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel.text = items[indexPath.row]
        
        return cell
    }
    
    //MARK - parser
    
    func loadParser(){
        let url = NSURL(string: urlstring)
        var parser = NSXMLParser(contentsOfURL: url)
        parser?.delegate = self
        parser?.shouldProcessNamespaces = true
        parser?.shouldReportNamespacePrefixes = true
        parser?.shouldResolveExternalEntities = true
        parser?.parse()
    }
    
    
    //MARK: - Parser Delegate
    
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]!) {
        
        element = elementName
        if ((elementName as NSString).isEqualToString("item")){
            item = ""
        }
        
    }
    
    
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
        
        if ((elementName as NSString).isEqualToString("item")){
            items.append(item)
        }
    }
    
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        if ( (element.isEqualToString("title")) && (element != "") ){
            item += string
        }
    }
    
    
    
    func parserDidEndDocument(parser: NSXMLParser!) {
        println(items)
        self.tableView.reloadData()
    }
}