# jitsi_meet_web

A Jitsi Web implementation

## Getting Started

This project implements a Jistis Plugin for WEB using JitsiMeetExternalAPI. You can find more information in https://jitsi.github.io/handbook/docs/dev-guide/dev-guide-iframe.


The plugin allows you to insert a meeting in a flutter web project, this first version has the following characteristics:
* Set the meeting view as a child for a flutter component allowing sizing the meeting section
* Set configurations according to Jitsi documentation, except `onload` callback
* Set listeners to meeting events
* Send commands to meetting

To implement you need to include Jitsi Js library in the index.html of web section
```javascript
<script src="https://meet.jit.si/external_api.js" type="application/javascript"></script>
```

Examaple:
```html
<body>
  <!-- This script installs service_worker.js to provide PWA functionality to
       application. For more information, see:
       https://developers.google.com/web/fundamentals/primers/service-workers -->
  <script>
    if ('serviceWorker' in navigator) {
      window.addEventListener('load', function () {
        navigator.serviceWorker.register('/flutter_service_worker.js');
      });
    }
  </script>
  <script src="https://meet.jit.si/external_api.js" type="application/javascript"></script>
  <script src="main.dart.js" type="application/javascript"></script>
</body>
</html>
```


See usage example in jitsi_meet plugin

Hosted example  on firebase

https://jitsiflutter.web.app/#/

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
