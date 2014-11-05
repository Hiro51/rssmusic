//
//  ViewController.swift
//  rssmusic
//
//  Created by Hiroyuki Tsujino on 11/4/14.
//  Copyright (c) 2014 Hiroyuki Tsujino. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        searchITunesFor("JQ Software")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        
        cell.textLabel.text = "Row #\(indexPath.row)"
        cell.detailTextLabel?.text = "Subtitle#\(indexPath.row)"
        
        return cell
    }

    @IBOutlet var appsTableViews : UITableView?
    
    var tableData = []
    
    func searchITunesFor(searchterm: String) {
        // The iTunes API wants multiple terms separated by + symbols, so replace spaces with + signs
        let itunesSearchTerm = searchTerm searchTerm.stringByReplacingOccurenceOfString(" ", withString: "+", options: NSStringCompare(
        // Now escape anything else that isn't URL-friendly
            if let escapedSearchTerm = itunesSearchTerm.stringByAddingPercentUsingEscapesUsingEncoding(NSUTF8StringEncoding) {
                let urlPath = "http://itunes.apple.com/search?term=\(escapedSearchTerm)&media=software"
                let url = NSURl(string: urlPath)
                let session = NSURLSession.sharedSession()
                let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in println("Task completed")
                    if(error != nil) {
                        // If there is an error in the web request, print it to the console
                        println(error.localizedDescription)
                    }
                    var err: NSError?
                    
                    var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &e)
                    if(err != nil) {
                        // If there is an error parsing JSON, print it to the console
                        println("Json Errror \(err!.localizedDescription)")
                    }
                    let results: NSArray = jsonResult["results"] as NSArray
                    dispatch_async(dispatch_get_main_queue(), {
                        self.tableData = results
                        self.appsTableViews!.reloadData()
                    })
            }
            task.resume()
        )
    }
    
}

