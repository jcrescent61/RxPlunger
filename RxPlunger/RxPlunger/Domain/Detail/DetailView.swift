//
//  DetailView.swift
//  RxPlunger
//
//  Created by Ellen J on 2022/10/29.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

final class DetailView: UIView {
    
    private let topBarView = UIView().then {
        $0.backgroundColor = .white
    }
    
    fileprivate let backButton = UIButton().then {
        let configuration = UIImage.SymbolConfiguration(
            pointSize: 20,
            weight: .regular,
            scale: .large
        )
        $0.setImage(
            UIImage(systemName: "chevron.backward", withConfiguration: configuration),
            for: .normal
        )
        $0.tintColor = .gray
    }
    
    private let titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .preferredFont(forTextStyle: .title3)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    private let descriptionLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .preferredFont(forTextStyle: .callout)
        $0.textAlignment = .center
        $0.numberOfLines = 1
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
        self.bindConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.backgroundColor = .white
        self.addSubviews(
            topBarView,
            backButton,
            titleLabel,
            descriptionLabel
        )
    }
    
    private func bindConstraints() {
        self.topBarView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        self.backButton.snp.makeConstraints {
            $0.left.equalTo(topBarView.snp.left).offset(15)
            $0.bottom.equalTo(topBarView.snp.bottom).offset(-15)
        }

        self.titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
        }
        
        self.descriptionLabel.snp.makeConstraints {
            $0.centerX.equalTo(topBarView.snp.centerX)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
    }
    
    func setupTitle(model: MockModel) {
        self.titleLabel.text = model.title
        self.descriptionLabel.text = model.description
    }
}

extension Reactive where Base: DetailView {
    var tapBackButton: ControlEvent<Void> {
        return base.backButton.rx.tap
    }
}
