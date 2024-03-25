//
//  MVVMViewController.swift
//  ByteCoin
//
//  Created by Maryna Bolotska on 25/03/24.
//

import UIKit
struct JSONDataModel: Codable {
    let rate: Double?
}

class ViewModel {
    var jsonData: JSONDataModel?
    let myApiKey = "362EE18C-44D4-44D4-BB9D-3F0B75F15511"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func fetchData(currency: String, completion: @escaping (Result<JSONDataModel, Error>) -> Void) {
            let urlString = "https://rest.coinapi.io/v1/exchangerate/BTC/\(currency)?apikey=\(myApiKey)"
            guard let url = URL(string: urlString) else {
                completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                    }
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(JSONDataModel.self, from: data)
                    self.jsonData = decodedData
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
    }





class MVVMViewController: UIViewController {
    var viewModel = ViewModel()
    
    
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        return view
    }()
    private let bitcoinLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
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
      //  fetchDataAndUpdateUI()
    }
    func fetchDataAndUpdateUI() {
     
        }
    
    func setupUI() {
        view.addSubview(mainView)
        mainView.addSubview(bitcoinLabel)
        mainView.addSubview(bitImage)
        view.addSubview(currencyPicker)
        
        mainView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(70)
            
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


extension MVVMViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = viewModel.currencyArray[row]

        viewModel.fetchData(currency: selectedCurrency) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.bitcoinLabel.text = String(data.rate ?? 0)
                    }
                case .failure(let error):
                    print("Error fetching data: \(error.localizedDescription)")
                    // Handle error presentation, e.g., showing an alert
                }
            }
    }
    
}

