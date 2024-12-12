//
//  BaseDataSource.swift
//  SabaideaTask
//
//  Created by Erfan mac mini on 12/9/24.
//


protocol BaseDataSource {}


protocol ErrorDataSourceDelegate {
    func handleError(_ error: Error)
}
