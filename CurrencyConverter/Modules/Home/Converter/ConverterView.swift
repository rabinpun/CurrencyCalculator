//
//  ConverterView.swift
//  CurrencyConverter
//
//  Created by rabin on 19/07/2022.
//

import UIKit

final class ConverterView: BaseView {
    
    private var viewsLayedout = false
    
    lazy var amountTextField: TextField = {
        let textField = TextField(frame: .zero)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .white
        textField.textAlignment = .right
        textField.textColor = .black
        textField.keyboardType = .decimalPad
        textField.placeholder = "Please enter the amount..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var selectedCurrencyView: SelectedCurrencyView = {
        let view = SelectedCurrencyView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var conversionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
//        collectionView.backgroundColor = .clear
        collectionView.bounces = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.contentInset = .zero
        collectionView.maskTop(40)
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 5, bottom: 0, right: 5)
        collectionView.register(ConversionResultCell.self, forCellWithReuseIdentifier: ConversionResultCell.identifier)
        collectionView.register(CurrencyErrorCell.self, forCellWithReuseIdentifier: CurrencyErrorCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var picker: UIPickerView = {
        let pickerView = UIPickerView.init()
        pickerView.backgroundColor = .white
        pickerView.autoresizingMask = .flexibleWidth
        pickerView.contentMode = .center
        pickerView.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 150, width: UIScreen.main.bounds.size.width, height: 150)
        return pickerView
    }()
    
    lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 200, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        
       let doneButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))
       let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        doneButton.tintColor = .appGreen
        toolBar.items = [flexibleSpace , doneButton]
        return toolBar
    }()
    
    override func layoutSubviews() {
        guard !viewsLayedout, conversionCollectionView.frame.minY > 0 else { return }
        viewsLayedout.toggle()
        addGradient([.appBlue, .appGreen], locations: [0, 1], frame: CGRect(x: 0, y: 0, width: frame.width, height: conversionCollectionView.frame.minY + 50))
        
        let view = UIView()
        let gradientFrame = CGRect(x: 0, y: 0, width: conversionCollectionView.bounds.width, height: conversionCollectionView.bounds.height)
        view.addGradient([.appGreen, .appBlue], locations: [0, 1], frame: gradientFrame)
        conversionCollectionView.backgroundView = view
    }
    
    override func create() {
        backgroundColor = .white
        addSubview(amountTextField)
        addSubview(selectedCurrencyView)
        addSubview(conversionCollectionView)
        
        NSLayoutConstraint.activate([
            
            amountTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            amountTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            amountTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            amountTextField.heightAnchor.constraint(equalToConstant: 50),
            
            selectedCurrencyView.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 20),
            selectedCurrencyView.leadingAnchor.constraint(equalTo: amountTextField.centerXAnchor),
            selectedCurrencyView.trailingAnchor.constraint(equalTo: amountTextField.trailingAnchor),
            selectedCurrencyView.heightAnchor.constraint(equalToConstant: 50),
            
            conversionCollectionView.topAnchor.constraint(equalTo: selectedCurrencyView.bottomAnchor, constant: 40),
            conversionCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            conversionCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            conversionCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc private func onDoneButtonTapped() {
        removePickerView()
    }
    
    func removePickerView() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    
}
