Aroma Swift Client
==============================================

[<img src="https://raw.githubusercontent.com/RedRoma/aroma/develop/Graphics/Logo.png" width="300">](http://aroma.redroma.tech/)
## The Official Swift and iOS Client to Aroma


# CocoaPods

Aroma provides easy integration with CocoaPods.

## Add RedRoma Repository

In order to use Aroma, add the **RedRoma™** Spec repo to your `Podfile`.

```xml
source 'https://github.com/RedRoma/CocoaSpecs.git'
```

## Add the Pod
After adding the **RedRoma™** Repo, add the following line to your `Podfile`.

```xml
pod 'AromaSwiftClient', '1.0'
```

>### Latest Release
For the latest release, use the following line instead
```xml
pod 'AromaSwiftClient', :git => 'https://github.com/RedRoma/aroma-swift-client.git', :branch => 'develop'
```

# API

## Import the Module
Add the following import statement wherever you use the Aroma Client.

```js
import AromaSwiftClient
```

## Setup the Token

Before you can send messages to Aroma, be sure to set the Application `Token` given when the App was provisioned from within the app.

>The Token should look something like this:
```
abcdefgh-1234-474c-ae46-1234567890ab
```

Put this in your `AppDelegate` when the Application Loads.

```js
AromaClient.TOKEN_ID = "abcdefgh-1234-474c-ae46-1234567890ab"
```

## Send a Message

```js
AromaClient.beginWithTitle("Operation Failed")
    .addBody("Details: \(error)")
    .addLine(2)
    .addBody("For User \(user)")
    .withPriority(.LOW)
    .send()
```

# Best Practices

### Send Important Messages
>Try to only Send messages that are actually interesting. You don't want to bombard Aroma with too many diagnostic messages that are better suited for Logging.

### Set the Urgency
>Set an Urgency to each message. Think of Urgency like you would a Log Severity Level. Using them allows you and your team to know just how important a message is.

# Project Source
Additional info on the Swift Client can be found by visiting the [GitHub project](https://github.com/RedRoma/aroma-swift-client).
