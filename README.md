# IPTV FOR TVOS

Quick little project to play live tv on my Apple TV. The existing apps on the app store were all lacking and paid.

The project makes use of [TVVLCKit](https://github.com/PopcornTimeTV/TVVLCKit) for a higher support rate.

## Configuration
This project uses  [CocoaPods](http://cocoapods.org/). Build instructions:
``` bash
$ git clone https://github.com/PopcornTimeTV/PopcornTimeTV.git
$ cd PopcornTimeTV/
$ pod repo update; pod install
$ open PopcornTime.xcworkspace
```
All what is left to do is specify the IPTV playlist url. Create a constants.swift which is git ignored (because the url is secret) and compile.

In a later stage the playlist URL can be saved within the app itself.

## Screenshots
![screenshot](https://d1ro8r1rbfn3jf.cloudfront.net/ms_126350/MLuQOkCmhCaYLdsaD24KR2j4462c1E/Apple%2BTV%2B1080p%2B%25E2%2580%2593%2BtvOS%2B10.2%2B%252814W260%2529%2B2017-04-02%2B20-42-33.png?Expires=1491245389&Signature=XT7bex6ANAYJxPh4b~RotdkCFklxou9VTYIdQmg989BJPGtogFUbGTDYP4YvwldCXKNsJALK-4DkN~FXtrE~foI08tSDePtB3XGyF1eeu6mJHr1Gk46Pjs~qBSzEn~s5iwxLbGgazxpQIWpy322IeolMUmfb9w~QcgLIJWUPzq0gDgK8KVhmjJ8fNTOhGlcicxdJEphLYGoWDfKgjPiZyijVLJV3U3TVlzQKSy1gr2M-MgK2y6TlXHIDs6PUPw6u5A1w4S5zdw6Oue9OxsKeAYDp9h-vaY5dubDaN-vmnN1IyeRVzY5KJhNJkzm79P24c~RUSWMl~s5Yd7dZ8JfZHA__&Key-Pair-Id=APKAJHEJJBIZWFB73RSA)

##License
GNU gpl-3.0