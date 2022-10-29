//
//  HomeListEmptyView.swift
//  RxPlunger
//
//  Created by Ellen J on 2022/10/29.
//

import UIKit

import SnapKit
import Then

final class HomeListEmptyView: UIView {
        
    private let emptyImageView = UIImageView().then {
        let configuration = UIImage.SymbolConfiguration(
            pointSize: 100,
            weight: .regular,
            scale: .large
        )
        $0.image = UIImage(
            systemName: "questionmark.folder.fill",
            withConfiguration: configuration
        )
        $0.tintColor = .gray
    }
    
    private let emptyLabel = UILabel().then {
        $0.text = "데이터가 없어요🥲"
        $0.font = .preferredFont(forTextStyle: .title3)
        $0.textColor = .gray
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.setup()
        self.bindConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.addSubviews(
            emptyImageView,
            emptyLabel
        )
    }
    
    private func bindConstraints() {
        
        self.emptyImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-10)
            $0.centerX.equalToSuperview()
        }
        
        self.emptyLabel.snp.makeConstraints {
            $0.top.equalTo(self.emptyImageView.snp.bottom).offset(20)
            $0.centerX.equalTo(emptyImageView.snp.centerX)
        }
    }
    
    func isHiddenEmptyView(_ isHidden: Bool) {
        self.emptyImageView.isHidden = isHidden
        self.emptyLabel.isHidden = isHidden
    }
}
