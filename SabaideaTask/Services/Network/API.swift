//
//  API.swift
//  BSLA tech task
//
//  Created by Erfan mac mini on 9/30/24.
//

import Foundation

struct API {
    static let baseURL = "https://api.themoviedb.org/3/"
    static let mediaBaseURL = "https://image.tmdb.org/t/p/w500"
    static let apiKey = "0e60e139520d4a0ebfdeae5f45ab500c"
    static let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2ZWNhZjE5MmZkMTFiNzZjNzgzMzY2MDQ2NjkwOWUyZiIsIm5iZiI6MTY2MTU5MTEzOS42OTI5OTk4LCJzdWIiOiI2MzA5ZGU2MzAzOThhYjAwN2Q3NmVmOTEiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.iJTcuGq7rqb2tfvYK8q07VPonXWEwyh0B5QlkzyZTxI"
    
    
    struct Routes {
        static let movieList = baseURL + "discover/movie"
        static let search = baseURL + "search/movie"
        static let movieDetail = baseURL + "movie/"
    }

}
