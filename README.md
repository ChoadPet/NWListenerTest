# NWListenerTest

Step to reproduce:
1. Launch iOS application or real device.
2. Press START, you should see this:
```
Listener stateUpdateHandler: waiting(POSIXErrorCode: Network is down)
Listener stateUpdateHandler: ready
"📞 New connection: 10.0.1.5:52052 establish"
"Connection stateUpdateHandler: preparing"
"Connection stateUpdateHandler: ready"
"Connection: start receiving ✅"
```
2. Open terminal and type: `nc 10.0.1.3(your_device_ip_address) 5000`(port to connect)
3. Press STOP, you should see: *(Inbound connection should be close at this point)*
```
Listener stateUpdateHandler: cancelled
"Connection stateUpdateHandler: cancelled"
```
4. Press again START:
```
[] nw_path_evaluator_evaluate NECP_CLIENT_ACTION_ADD error [48: Address already in use]
[] nw_path_create_evaluator_for_listener nw_path_evaluator_evaluate failed
Listener stateUpdateHandler: waiting(POSIXErrorCode: Network is down)
[] nw_listener_start_locked [L2] nw_path_create_evaluator_for_listener failed
Listener stateUpdateHandler: failed(POSIXErrorCode: Address already in use)
```
