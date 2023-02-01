import Foundation
import Frigade

extension FrigadeClient {
    static let shared: FrigadeClient = {

        //TODO: replace with debtdestroyer public key
        let client = FrigadeClient(publicApiKey: "api_ANCKYIKTFN5A7VR14O5F1B9SNNZ0E5MZXPY4027PF717DKLR0JTSZ9RPXP1CVMXN")

        return client
    }()
}
