//
//  DetailReactor.swift
//  RxPlunger
//
//  Created by Ellen J on 2022/10/29.
//

import Foundation

import ReactorKit

final class DetailReactor: Reactor {
    enum Action {
        case tapBackButton
    }
    
    enum Mutation {
        case dismiss
    }
    
    struct State {
        var model: MockModel? = nil
        @Pulse var dissmissPublisher: Void?
    }
    
    let initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapBackButton:
            return .just(Mutation.dismiss)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .dismiss:
            newState.dissmissPublisher = ()
        }
        
        return newState
    }
}
