//
//  SearchController.swift
//  BENDAHIABOU
//
//  Created by Ingénieur on 17/01/2019.
//  Copyright © 2019 ENSISA. All rights reserved.
//

import UIKit

class SearchController: UIViewController, UITableViewDataSource, UITableViewDelegate ,UISearchBarDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var inSearchMode = false
    var inSearchScene = false
    var inTitleScene = false
    var inAuthorScene = false
    
    var cds = [CD]()
    var filterCds = [CD]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inSearchMode ? filterCds.count : cds.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return inAuthorScene ? cds.count : 1
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return inAuthorScene ? cds[section].author : ""
    }
    
    override func viewDidLoad() {
        
        let cdParser = CDParser()
        cds = cdParser.cds
        
        cds.sort(by: {$0.title < $1.title})
        
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        let selectedIndexName = self.tabBarItem.title
        switch (selectedIndexName) {
        case "Titres":
            inTitleScene = true
            inSearchScene = false
            inAuthorScene = false
            break
        case "Search":
            inSearchScene = true
            inAuthorScene = false
            inTitleScene = false
            searchBar.delegate = self
            filterCds = cds
            break
        case "Auteurs":
            inAuthorScene = true
            inSearchScene = false
            inTitleScene = false
            break
        default:
            break
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        
        let cd :CD?
        if inSearchMode {
            cd = filterCds[indexPath.row]
        } else {
            cd = cds[indexPath.row]
        }
        print("Cell = \(cell)")
        cell.dateLabel!.text = cd!.date
        cell.titleLabel!.text = cd!.title
        cell.authorLabel!.text = cd!.author
        
        return cell
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
        } else {
            inSearchMode = true
            filterCds = cds.filter { cd in cd.options.lowercased().contains(searchBar.text!.lowercased()) }
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete && !inSearchMode{
            self.cds.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
