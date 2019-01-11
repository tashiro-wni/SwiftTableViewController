//
//  MyTableViewController.swift
//  SwiftTableViewTest
//
//  Created by Tomohiro Tashiro on 2014/06/28.
//  Copyright (c) 2014 test. All rights reserved.
//

import UIKit

final class MyTableData: NSObject, UITableViewDataSource {
    
    let cellIdentifier = "Cell"
    let sectionTitle = [ "fruits", "vegetables" ]
    let itemList = [ [ "apple 🍎", "banana 🍌", "cherry 🍒", "orange 🍊", "grape 🍇", "pineapple 🍍", "meron 🍈" ],
                     [ "watermelon 🍉", "lemon 🍋", "tomato 🍅", "corn 🌽", "eggplant 🍆" ] ]
    
    func item(indexPath: IndexPath) -> String {
        return itemList[indexPath.section][indexPath.row]
    }

    //MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList[section].count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < sectionTitle.count {
            return sectionTitle[section]
        } else {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as UITableViewCell
        cell.textLabel?.text = item(indexPath: indexPath)
        return cell
    }
    
}

final class MyTableViewController: UIViewController, UITableViewDelegate {
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let tableData = MyTableData()
    
    
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
        
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  
        tableView.delegate = self
        tableView.dataSource = tableData
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableData.cellIdentifier)
        tableView.separatorColor = .blue
        tableView.rowHeight = 70
        
        self.view.addSubview(tableView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.contentInset = view.safeAreaInsets
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated:true)
        
        let alert = UIAlertController(title: "Clicked", message: tableData.item(indexPath: indexPath), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
