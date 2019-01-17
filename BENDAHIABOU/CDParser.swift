//
//  CDParser.swift
//  BENDAHIABOU
//
//  Created by Ingénieur on 17/01/2019.
//  Copyright © 2019 ENSISA. All rights reserved.
//

import UIKit

class CDParser: NSObject, XMLParserDelegate{
    
    var eName: String = String()
    var titl: String = String()
    var date: String = String()
    var options: String = String()
    var author: String = String()
    var cds: [CD] = []
    var authors: [String] = []
    
    
    override init() {
        super.init()
        let path = Bundle.main.path(forResource: "CDs", ofType: "xml")
        let url = URL(fileURLWithPath: path!)
        if let parser = XMLParser(contentsOf: url) {
            parser.delegate = self
            parser.parse()
        }
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        eName = elementName
        if elementName == "cd" {
            titl = String()
            date = String()
            options = String()
            author = String()
        }
    }
    
    
    // 2
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        // code here
        
        if elementName == "cd" {
            let cd = CD()
            cd.title = titl
            cd.date = date
            cd.options = options
            cd.author = author
            authors.append(cd.author)
            cds.append(cd)
        }
        
    }
    
    func cdsAuthors(author: String) -> [String] {
        var cdsAu: [String] = []
        
        for cd in cds {
            if(cd.author == author) {
                cdsAu.append(cd.title)
            }
        }
        return cdsAu
    }
    
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        if(!data.isEmpty) {
            switch eName {
            case "title":
                titl += data
            case "date":
                date += data.replacingOccurrences(of: "(", with: "", options: NSString.CompareOptions.literal, range: nil).replacingOccurrences(of: ")", with: "", options: NSString.CompareOptions.literal, range: nil)
            case "options":
                options += data
            case "author":
                author += data
            default:
                return
            }
        }
    }
    
    
    
}
