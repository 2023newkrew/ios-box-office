//
//  Result+Extension.swift
//  BoxOffice
//
//  Created by john-lim on 2023/02/06.
//

import Foundation

extension Result {
    @discardableResult
    func success() -> Success? {
        if case .success(let value) = self {
            return value
        }
        return nil
    }
    
    @discardableResult
    func failure() -> Failure? {
        if case .failure(let error) = self {
            return error
        }
        return nil
    }
}
