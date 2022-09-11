//
//  CoordinatorDependencies.swift
//  SCBMonitorSwift
//
//  Created by ANTON DOBRYNIN on 05.07.2022.
//

import Foundation

protocol CoordinatorDependencies {
    
    func add(dependency coordinator: Coordinator)
    func remove(dependency coordinator: Coordinator)
}

final class DefaultCoordinatorDependencies: CoordinatorDependencies {
    
    private var dependencies = [Coordinator]()
    
    func add(dependency coordinator: Coordinator) {
        dependencies.append(coordinator)
    }
    
    func remove(dependency coordinator: Coordinator) {
        dependencies.removeAll(where: { $0 === coordinator })
    }
    
}
