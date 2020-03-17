# jitsi_meet

Jitsi Meet Plugin for Flutter. Supports Android and iOS platforms.

"Jitsi Meet is an open-source (Apache) WebRTC JavaScript application that uses Jitsi Videobridge to provide high quality, secure and scalable video conferences." 

Find more information about Jitsi Meet [here](https://github.com/jitsi/jitsi-meet)

## Getting Started

### Android
Jitsi Meet's SDK AndroidManifest.xml will conflict with your project, namely 
the applicatoin:label field. To counter that, go into 
`android/app/src/main/AndroidManifest.xml` and add the tools library
and `tools:replace="android:label"` to the application tag.

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="yourpackage.com"
    xmlns:tools="http://schemas.android.com/tools"> <!-- Add this -->
    <application 
        tools:replace="android:label"  
        android:name="your.application.name"
        android:label="My Application"
        android:icon="@mipmap/ic_launcher">
```

### Code

```dart
_joinMeeting() async {
    try {
      var options = JitsiMeetingOptions()
        ..room = "myroom" // Required, spaces will be trimmed
        ..subject = "Meeting with Gunschu"
        ..userDisplayName = "My Name"
        ..userEmail = "myemail@email.com"
        ..audioOnly = true
        ..audioMuted = true
        ..videoMuted = true;

      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      debugPrint("error: $error");
    }
  }
```

### JitsiMeetingOptions

| Field           | Required  | Default   | Description |
| --------------- | --------- | --------- | ----------- |
| room            | Yes       | N/A              | Unique room name that will be appended to serverURL. Valid characters: alphanumeric, dashes, and underscores. |
| subject         | No        | $room            | Meeting name displayed at the top of the meeting.  If null, defaults to room name where dashes and underscores are replaced with spaces and first characters are capitalized. |
| userDisplayName | No        | "Fellow Jitster" | User's display name |
| userEmail       | No        | none             | User's email address |
| audioOnly       | No        | false            | Start meeting without video. Can be turned on in meeting. |
| audioMuted      | No        | false            | Start meeting with audio muted. Can be turned on in meeting. |
| videoMuted      | No        | false            | Start meeting with video muted. Can be turned on in meeting. |
| serverURL       | N/A       | meet.jitsi.si    | *Not yet implemented*. <br /> Specify your own hosted server. Defaults to Jitsi Meet's servers. |
| userAvatarURL   | N/A       | none             | *Not yet implemented*. User's avatar URL. |
| token           | N/A       | none             | *Not yet implemented*. JWT token used for authentication. |

### JitsiMeetingResponse

| Field           | Type    | Description |
| --------------- | ------- | ----------- |
| isSuccess       | bool    | Success indicator. |
| message         | String  | Success message or error as a String. |
| error           | dynamic | Optional, only exists if isSuccess is false. The error object. |

### Title bar
When Jitsi Meet is opening, the title bar will reflect: 
* For Android: the `android:label` tag in the AndroidManifest.xml in <application>
* For iOS: the `Bundle name` in Info.plist

## Contributing
Send a pull request with as much information as possible clearly 
describing the issue or feature. Try to keep changes small and 
for one issue at a time.
