//
//  MyTableViewController.swift
//  SwiftTableViewTest
//
//  Created by Tomohiro Tashiro on 2014/06/28.
//  Copyright (c) 2014 test. All rights reserved.
//

import UIKit

class MyTableData: NSObject, UITableViewDataSource {
    
    let cellIdentifier = "Cell"
    let sectionTitle = [ "fruits", "vegetables" ]
    let itemList = [ [ "apple 🍎", "banana 🍌", "cherry 🍒", "orange 🍊", "grape 🍇", "pineapple 🍍", "meron 🍈" ],
                     [ "watermelon 🍉", "lemon 🍋", "tomato 🍅", "corn 🌽", "eggplant 🍆" ] ]

    
    func item(#indexPath: NSIndexPath!) -> String {
        return self.itemList[indexPath.section][indexPath.row]
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.itemList.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemList[section].count
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String {
        return self.sectionTitle[section]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as UITableViewCell
        cell.text = self.item(indexPath: indexPath)
        return cell
    }
    
}

class MyTableViewController: UIViewController, UITableViewDelegate {
    
    let tableView: UITableView = UITableView(frame:CGRectZero, style:.Plain)
    let tableData: MyTableData = MyTableData()
    
    
    init () {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //
        tableView.frame = self.view.bounds
        tableView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
  
        tableView.delegate = self
        tableView.dataSource = tableData
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: tableData.cellIdentifier)
        tableView.separatorColor = UIColor.blueColor()
        
        self.view.addSubview(tableView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.contentInset = UIEdgeInsetsMake(self.topLayoutGuide.length, 0, self.bottomLayoutGuide.length, 0)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 70
    }

    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        tableView.deselectRowAtIndexPath(indexPath, animated:true)
        
        //let alert = UIAlertView(title: nil, message: text, delegate: nil, cancelButtonTitle: "OK")  // => clash
        let alert = UIAlertView()
        alert.title = "Clicked"
        alert.message = tableData.item(indexPath: indexPath)
        alert.addButtonWithTitle("OK")
        alert.show()
    }
    
}
