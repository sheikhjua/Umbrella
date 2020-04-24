//
//  Result.swift
//  Umbrella
//
//  Created by Sheikh Ahmed on 23/04/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//
enum Result<T, U> where U: Error  {
    case success(T)
    case failure(U)
}
enum TupleResult<T, A , U> where U: Error  {
    case success(T, A)
    case failure(U)
}
