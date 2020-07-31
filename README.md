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
2. Open terminal and type: `nc 10.0.1.3(your_device_ip_address) 5000`(port to connect) use 5000, since it's hardcoded in application
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

--- 

It happens on iPhone 6 iOS 12.4.1, iPhone Xs Max iOS 13.3, iPhone 11 Pro iOS 13.5.1

but NOT on iPhone 7 Plus iOS 12.1.4, iPhone 11 iOS 13.5.1.

https://stackoverflow.com/questions/63052894/failedposixerrorcode-address-already-in-use
