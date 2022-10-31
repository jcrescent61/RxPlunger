//
//  MainReactor.swift
//  RxPlunger
//
//  Created by Ellen J on 2022/10/26.
//

import Foundation

import ReactorKit
import RxRelay

final class HomeReactor: Reactor {
    
    enum Action {
        case viewDidLoad
        case tapModelCell(row: Int)
    }
    
    enum Mutation {
        case fetchModels([MockModel])
        case pushDetailView(model: MockModel)
        case showErrorAlert(error: RxPlungerError)
    }
    
    // TODO: []이 아니라 [MockModel]? 타입으로 선언한 이유는 무엇일까?
    struct State {
        var models: [MockModel]? = nil
        
        // TODO: Pulse가 무엇일까?
        @Pulse var detailViewPublisher: MockModel?
        @Pulse var alertErrorMessage: RxPlungerError?
    }
    
    let initialState = State()
    let disposeBag = DisposeBag() // TODO: DisposeBag의 역할은 무엇일까?
    private let networkService: NetworkServiceType
    //    let testPublisher = PublishRelay<MockModel>() // TODO: Pulse로 화면 전환할 때와 무엇이 다를까?
    
    // TODO: Reactor가 초기화되는 시점에 network 객체를 넣어주는 이유가 무엇일까?
    init(
        networkService: NetworkServiceType
    ) {
        self.networkService = networkService
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return self.fetchModels()
        case .tapModelCell(let row):
            guard let model = self.currentState.models?[row] else { return .empty() }
            return .just(.pushDetailView(model: model))
        }
    }
    
    // TODO: mutate 함수 -> reduce 함수의 흐름은 어떻게 구현되어있을까?
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .fetchModels(let model):
            newState.models = model
        case .pushDetailView(let model):
            newState.detailViewPublisher = model
        case .showErrorAlert(let error):
            newState.alertErrorMessage = error
        }
        
        return newState
    }
    
    // TODO: Observable<Mutation>을 반환하는 함수를 따로 구현한 이유는 무엇일까?
    private func fetchModels() -> Observable<Mutation> {
        return self.networkService.request()
            .asObservable()
            .map { result in
                switch result {
                case .success(let models):
                    return Mutation.fetchModels(models)
                case .failure(let error):
                    return Mutation.showErrorAlert(error: error)
                }
            }.delay(.seconds(3), scheduler: MainScheduler.instance)
    }
}

