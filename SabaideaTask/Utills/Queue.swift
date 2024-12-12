//
//  Queue.swift
//  SabaideaTask
//
//  Created by Erfan mac mini on 12/11/24.
//

func delayWithSeconds(_ seconds: Double, completion: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        completion()
    }
}

func mainThread(_ completion: @escaping () -> Void) {
    DispatchQueue.main.async {
        completion()
    }
}
