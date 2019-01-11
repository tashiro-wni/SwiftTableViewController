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

    
    func item(indexPath: IndexPath) -> String {
        return self.itemList[indexPath.section][indexPath.row]
    }

// #pragma mark UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.itemList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemList[section].count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < sectionTitle.count {
            return self.sectionTitle[section]
        } else {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as UITableViewCell
        cell.textLabel?.text = self.item(indexPath: indexPath)
        return cell
    }
    
}

class MyTableViewController: UIViewController, UITableViewDelegate {
    
    let tableView = UITableView(frame:CGRect.zero, style:.plain)
    let tableData = MyTableData()
    
    
    init () {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  
        tableView.delegate = self
        tableView.dataSource = tableData
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableData.cellIdentifier)
        tableView.separatorColor = UIColor.blue
        
        self.view.addSubview(tableView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.contentInset = UIEdgeInsets.init(top: topLayoutGuide.length, left: 0, bottom: bottomLayoutGuide.length, right: 0)
    }
    
// #pragma mark UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated:true)
        
        //let alert = UIAlertView(title: nil, message: text, delegate: nil, cancelButtonTitle: "OK")  // => clash
        let alert = UIAlertView()
        alert.title = "Clicked"
        alert.message = tableData.item(indexPath: indexPath)
        alert.addButton(withTitle: "OK")
        alert.show()
    }
    
}
