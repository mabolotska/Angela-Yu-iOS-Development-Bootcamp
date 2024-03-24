//
//  ViewController.swift
//  ByteCoin
//
//  Created by Maryna Bolotska on 23/03/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let coinManager = CoinManager()
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        return view
    }()
    private let bitcoinLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    private let bitImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "bitcoinsign.circle.fill")
        return image
    }()
    lazy var currencyPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myColor = UIColor(named: "Background Color") ?? UIColor.red
        view.backgroundColor = myColor
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(mainView)
        mainView.addSubview(bitcoinLabel)
        mainView.addSubview(bitImage)
        view.addSubview(currencyPicker)
        
        mainView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(30)
            
        }
        bitImage.snp.makeConstraints { make in
            make.height.width.equalTo(50)
            make.top.leading.equalTo(10)
        }
        bitcoinLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        currencyPicker.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.centerX.equalToSuperview()
        }
    }

}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(currency: selectedCurrency)
   
    }
    
}
