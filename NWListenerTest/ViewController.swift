//
//  ViewController.swift
//  NWListenerTest
//
//  Created by user on 23.07.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import UIKit
import Network

class ViewController: UIViewController {

    let listener = ConnectionListener(port: 5000, maxLength: 5000)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func startAction(_ sender: UIButton) {
        listener.startListening()
    }
    
    @IBAction func stopAction(_ sender: UIButton) {
        listener.stopListening()
    }
    
}


final class ConnectionListener {
        
    var dataReceivedHandler: ((Data) -> Void)?
    
    private let port: UInt16
    private let maxLength: Int
    
    private var listener: NWListener!
    private var connection: NWConnection!
    
    init(port: UInt16, maxLength: Int) {
        self.port = port
        self.maxLength = maxLength
    }
    
    deinit {
        print("❌ Deinitialize \(self)")
    }
    
    // MARK: Public API
    
    func startListening() {
        let parameters = NWParameters.tcp
        parameters.allowLocalEndpointReuse = true
        self.listener = try! NWListener(using: parameters, on: NWEndpoint.Port(integerLiteral: port))
        self.listener.stateUpdateHandler = { state in print("Listener stateUpdateHandler: \(state)") }
        self.listener.newConnectionHandler = { [weak self] in self?.establishNewConnection($0) }
        self.listener.start(queue: .main)
    }
    
    func stopListening() {
        listener.cancel()
        connection?.cancel()
    }
    
    // MARK: Private API
    
    private func establishNewConnection(_ newConnection: NWConnection) {
        connection = newConnection
        debugPrint("📞 New connection: \(String(describing: connection.endpoint)) establish")
        connection.stateUpdateHandler = { [weak self] state in
            guard let self = self else { return }
            debugPrint("Connection stateUpdateHandler: \(state)")
            switch state {
            case .ready:
                debugPrint("Connection: start receiving ✅")
                self.receive(on: self.connection)
            default: break
            }
        }
        self.connection.start(queue: .main)
    }
    
    private func receive(on connection: NWConnection) {
        connection.receive(minimumIncompleteLength: 1, maximumLength: maxLength, completion: { [weak self] content, context, isCompleted, error in
            guard let self = self else { return }
            if let frame = content {
                self.dataReceivedHandler?(frame)
            }
            self.receive(on: connection)
        })
    }
    
}
