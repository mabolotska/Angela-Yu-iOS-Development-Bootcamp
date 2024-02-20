//
//  ViewController.swift
//  Destini
//
//  Created by Maryna Bolotska on 20/02/24.
//

import UIKit
import SnapKit


class ViewController: UIViewController {
    var storyBrain = StoryBrain()
    
    let backgroundImage = UIImageView(image: UIImage(named: "background"))
    
    private let storyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let choice1Button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 255/255, green: 102/255, blue: 153/255, alpha: 1)
        button.titleLabel?.numberOfLines = 0
        button.addTarget(self, action: #selector(buttonOnePressed), for: .touchUpInside)
        return button
    }()
    
    private let choice2Button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 153/255, green: 51/255, blue: 255/255, alpha: 1)
        button.titleLabel?.numberOfLines = 0
        button.addTarget(self, action: #selector(buttonOnePressed), for: .touchUpInside)
        return button
    }()
    
    private let mainView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateUI()
    }
    
    @objc func updateUI() {
        storyLabel.text = storyBrain.getStoryText()
        choice1Button.setTitle(storyBrain.getAnswerOne(), for: .normal)
        choice2Button.setTitle(storyBrain.getAnswerTwo(), for: .normal)
    }

    @objc func buttonOnePressed() {
        storyBrain.nextQuestion(choice: 1)
        updateUI()
    }
}

extension ViewController {
    func setupUI() {
        view.addSubview(mainView)
        mainView.addSubview(backgroundImage)
        mainView.addSubview(storyLabel)
        mainView.addSubview(choice1Button)
        mainView.addSubview(choice2Button)
        
        backgroundImage.contentMode = .scaleAspectFill
        
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        storyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        choice1Button.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.bottom.equalToSuperview().offset(-40)
            make.width.equalTo(150)
            make.height.equalTo(100)
        }
        choice2Button.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-40)
            make.width.equalTo(150)
            make.height.equalTo(100)
        }
        
    }
}
