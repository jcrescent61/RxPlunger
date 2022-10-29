//
//  DetailViewController.swift
//  RxPlunger
//
//  Created by Ellen J on 2022/10/27.
//

import UIKit

import ReactorKit
import RxSwift
import RxCocoa

final class DetailViewController: UIViewController, View {
    
    private let model: MockModel
    private let detailView = DetailView()
    private let detailReactor = DetailReactor()
    var disposeBag = DisposeBag()
    
    static func instance(model: MockModel) -> DetailViewController {
        return DetailViewController(model: model)
    }
    
    init(model: MockModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = detailView
        self.detailView.setupTitle(model: self.model)
        self.reactor = detailReactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func bind(reactor: DetailReactor) {
        // Bind Action
        self.detailView.rx.tapBackButton
            .map { Reactor.Action.tapBackButton }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
            
        // Bind State
        reactor.pulse(\.$dissmissPublisher)
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: self.disposeBag)
    }
}
