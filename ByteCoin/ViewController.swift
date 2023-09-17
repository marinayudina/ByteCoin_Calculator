//
//  ViewController.swift
//  byte_new
//
//  Created by Blanc Pono on 9/14/23.
//


import UIKit



class ViewController: UIViewController {

    var coinManager = CoinManager()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "ByteCoin"
        label.font = .systemFont(ofSize: 30)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let bitcoinImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bitcoinsign.circle.fill")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.backgroundColor = .red
        return imageView
    }()
    private let bitcoinLabel: UILabel = {
        let label = UILabel()
        label.text = "..."
        label.textColor = .white
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 25)
//        label.backgroundColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let currencyLabel: UILabel = {
        let label = UILabel()
        label.text = "USD"
        label.textColor = .white
        label.font = .systemFont(ofSize: 25)

//        label.backgroundColor = .yellow
        label.textAlignment = .left
        

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var mainStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.backgroundColor = #colorLiteral(red: 0.4230758548, green: 0.7227563262, blue: 0.7280344367, alpha: 1)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var mainPicker: UIPickerView = {
        let picker = UIPickerView()
//        picker.backgroundColor = .red
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.5058823529, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
        
        setupView()
        setConstraints()
        
        coinManager.delegate = self
        mainPicker.dataSource = self
        mainPicker.delegate = self
    }
    func setupView() {
        view.addSubview(nameLabel)
        
        mainStack.addArrangedSubview(bitcoinImage)
        mainStack.addArrangedSubview(bitcoinLabel)
        mainStack.addArrangedSubview(currencyLabel)
        view.addSubview(mainStack)
        
        view.addSubview(mainPicker)
    }
    

}

extension ViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            mainStack.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            mainStack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            
            bitcoinImage.widthAnchor.constraint(equalToConstant: 80),
            
            mainPicker.heightAnchor.constraint(equalToConstant: 220),
            mainPicker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }

}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }
}

extension ViewController: CoinManagerDelegate {
    func didUpdatePrice(price: String, currency: String) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = price
            self.currencyLabel.text = currency
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}
