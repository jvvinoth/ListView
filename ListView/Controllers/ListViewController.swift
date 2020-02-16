//
//  ListViewController.swift
//  ListView
//
//  Created by Vinoth Varatharajan on 09/02/2020.
//  Copyright © 2020 Vin. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var appliedFilterLabel  : UILabel!
    @IBOutlet weak var listTable           : UITableView!

    private var listArray   : [listObj] = []
    private var filters       = ["Order by ID","Order by Name"]
    private var selectedIndex = 0
    private var holdingIndex  = 0
    
    lazy var viewmodel : ListViewModel = {
        return ListViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewmodel.delegate = self
        viewmodel.getMockData()

        listTable.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Show Filter
    func showPickerInActionSheet() {
        
        let title = "Dashboard Filter"
        let message = "Dashboard data will get filtered based on this"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet);
        
        alert.isModalInPopover = true
        
        let pickerFrame: CGRect = CGRect(x: 17, y: 52, width: 270, height: 100)
        let picker: UIPickerView = UIPickerView(frame: pickerFrame)
        
        picker.delegate = self
        picker.dataSource = self
        
        alert.view.addSubview(picker)
        
        self.present(alert, animated: true, completion: nil);
    }
    
    // MARK: - Button Filter Action
    @IBAction func filterAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "ListView Filter", message: "ListView data will get filter based on this", preferredStyle: .actionSheet)
        
        alert.addPickerView(values: [filters] ,initialSelection: (column: 0, row: selectedIndex)) { vc, picker, index, values in
            
            self.holdingIndex = index.row
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1) {
                    vc.preferredContentSize.height = 200
                }
            }
        }
        
        alert.addAction(image: nil, title: "Cancel", color: nil, style: .cancel, isEnabled: true, handler: { action in
            
        })
        
        alert.addAction(image: nil, title: "Apply", color: nil, style: .default, isEnabled: true, handler: { action in
            self.selectedIndex = self.holdingIndex
            self.appliedFilterLabel.text = self.filters[self.selectedIndex]
            switch self.selectedIndex {
            case 0:
                self .listArray  = self.listArray.sorted { $0.id < $1.id }
            case 1:
                self .listArray  = self.listArray.sorted { $0.name < $1.name }
            default:
                break
            }
            self .listTable.reloadData()
        })
        
        present(alert, animated: true, completion: nil)
    }

}

extension ListViewController : ListViewModelDelegate {
    
    func getResponseSuccessfull(_ list:  [listObj]) {
        self.appliedFilterLabel.text = self.filters[self.selectedIndex]
        self.listArray               = list
        listTable.reloadData()
    }
    
    func getResponseFailure() {
        
    }
}

extension ListViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return filters.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return filters[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
}


extension ListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self .listArray .count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listCell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        listCell .titleLabel .text  = self .listArray[indexPath.row].name[0]
        listCell .nameLabel .text   = self .listArray[indexPath.row].name
        listCell .idLabel .text     = self .listArray[indexPath.row].id
        return listCell
    }
}

extension UIAlertController {
    
    func set(vc: UIViewController?, width: CGFloat? = nil, height: CGFloat? = nil) {
        guard let vc = vc else { return }
        setValue(vc, forKey: "contentViewController")
        if let height = height {
            vc.preferredContentSize.height = height
            preferredContentSize.height = height
        }
    }
    
    func addAction(image: UIImage? = nil, title: String, color: UIColor? = nil, style: UIAlertAction.Style = .default, isEnabled: Bool = true, handler: ((UIAlertAction) -> Void)? = nil) {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        action.isEnabled = isEnabled
        
        // button image
        if let image = image {
            action.setValue(image, forKey: "image")
        }
        
        // button title color
        if let color = color {
            action.setValue(color, forKey: "titleTextColor")
        }
        
        addAction(action)
    }
}
