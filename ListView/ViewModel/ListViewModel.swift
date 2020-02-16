//
//  ListViewModel.swift
//  ListView
//
//  Created by Vinoth Varatharajan on 10/02/2020.
//  Copyright © 2020 Vin. All rights reserved.
//

import UIKit

protocol ListViewModelDelegate {
    func getResponseSuccessfull(_ list : [listObj])
    func getResponseFailure()
}

class ListViewModel {
    
    var delegate : ListViewModelDelegate?
    
    func getMockData() {
        let path = Bundle.main.path(forResource: "Listdata", ofType: "json")
        if let jsonData = try? NSData(contentsOfFile: path!, options: NSData.ReadingOptions.mappedIfSafe) {
            do {
                let listDataObj = try JSONDecoder().decode(listData.self, from: jsonData as Data)
                self .delegate?.getResponseSuccessfull(listDataObj.data)
            }
            catch (let error){
                print(error)
                self .delegate?.getResponseFailure()
            }
        } else {
            self .delegate?.getResponseFailure()
        }
    }
}
