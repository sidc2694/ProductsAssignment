//
//  ImageDownloaderAuthenticationChallenge.swift
//  ProductsAssignment
//
//  Created by Siddharth Chauhan on 07/06/24.
//

import Foundation
import Kingfisher

final class ImageDownloaderAuthenticationChallenge: AuthenticationChallengeResponsible {
    func downloader(_ downloader: ImageDownloader, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        challenge.trustServer { challangeDisposition, credential in
            completionHandler(challangeDisposition, credential)
        }
    }
}

extension URLAuthenticationChallenge {
    func trustServer(completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if self.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            if let serverTrust = self.protectionSpace.serverTrust {
                let credential = URLCredential(trust: serverTrust)
                completionHandler(.useCredential, credential)
                return
            }
        }
        completionHandler(.performDefaultHandling, nil)
    }
}
