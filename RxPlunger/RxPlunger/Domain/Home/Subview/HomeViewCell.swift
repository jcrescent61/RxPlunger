//
//  MainView.swift
//  RxPlunger
//
//  Created by Ellen J on 2022/10/27.
//

import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa

final class HomeViewCell: UITableViewCell {
    static let id = "\(HomeViewCell.self)"
    var disposeBag = DisposeBag()
    
    private let titleLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textColor = .black
        $0.font = .preferredFont(forTextStyle: .title3)
        $0.textAlignment = .center
    }
    
    private let descriptionLabel = UILabel().then {
        $0.numberOfLines = 3
        $0.textColor = .black
        $0.font = .preferredFont(forTextStyle: .body)
        $0.textAlignment = .center
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
        self.bindConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.contentView.isUserInteractionEnabled = false
        self.backgroundColor = .white
        self.addSubviews(
            titleLabel,
            descriptionLabel
        )
    }
    
    private func bindConstraints() {
        self.titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
        }
        
        self.descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.left.equalTo(titleLabel.snp.left)
            $0.right.equalTo(titleLabel.snp.right)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
    
    func bind(_ model: MockModel) {
        self.titleLabel.text = model.title
        self.descriptionLabel.text = model.description
    }
}
