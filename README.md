## Patience - Your Healthcare Navigator

A tool that help patients navigate their healthcare, specifically their hospital visit (as of right now) in order to avoid medical surprise bills.

## Author

Tuan Nguyen and Leilani Hagen

## App

[Playstore](https://play.google.com/store/apps/details?id=com.patienceteam.healthcarenavigator)
[Appstore](https://apps.apple.com/us/app/patience-healthcare-navigator/id1593948581)

## Installation

This flutter app using Flutter 3.0.2, Dart 2.17.3
To clone the app, use this command line

Please clone the main branch to experience our latest updates and working app version:

Using https:

```bash
git clone https://github.com/leilanihagen/patience-healthcare-navigator.git
cd patience-healthcare-navigator
```

Using ssh:

```bash
git clone https://github.com/leilanihagen/patience-healthcare-navigator.git
cd patience-healthcare-navigator
```

After cloning the app, run the following lines.

```bash
flutter clean
flutter pub get
```

## Running

If you are using Visual Code or Android Studio and have Flutter tools installed, press F5, (make sure to have an emulator or Android device connected).
Or run this in command

```bash
flutter run
```

To compile in release mode (make app run smoother than debug mode), run the following command instead

```bash
flutter run --release
```

## Errors, Bugs and TroubleShooting

If you run into an error while running the app, you can contact us via patiencehealthcarenavi@gmail.com

#### or

Create a `New Issue` in our [Our Repository](https://github.com/leilanihagen/patience-healthcare-navigator/issues)

## Feedbacks

We are much appreciate if you can provide your feedback about your experience of this app. Help us fill out [this feedback form](https://docs.google.com/forms/d/e/1FAIpQLSdY0JrIfUcmTRSx81xKdcH3YwXAQcSmUi9lYg9xVIRE3-2rjg/viewform?usp=sf_link)

Your valuable feedbacks will motivate and help us in developing this awesome app.

> Patience's future depend on your feedbacks - Tuan & Leilani

## Side-notes

This project hasn't been tested on IOS, so there is no further instruction for running on IOS device, we don't know any potential error if you run on IOS. We will target this platform in the future.

## Important notes

Note that this project use various calls to our servers, please don't exploit or spam the calls, it will use up our quota or drain our pocket money, which force us to close this project code to public.

## Mission

The goal of this app is to empower any person with a simple set of knowledge and tools for navigating the confusing and expensive healthcare system that we have in the USA. The problem we heard about the most from members of our community was the problem of "surprise medical bills." Therefore, after lots of research and interviews, we largely designed our app and its features around the simple question of "How can we help people avoid surprise bills and out-of-network bills?" Also, have focused our app solely around hospital visits for the time being, because this is the situation we have seen to be the most urgent, but we hope to expand to more areas of healthcare in the future.

## Features

To accomplish the above goals, we have implemented the following features:

#### Dashboard

The dashboard contain walkthroughs of the app and a collection of healthcare-related resources to

#### Guidelines

The user navigates and through our guidelines depending on their situation (i.e. "I'm in the hospital now," "I recently visited the hospital," etc.) and is presented with organized and concise information about things they can do before, during and after hospital stays to avoid surprise bills and manage their healthcare. We are working on adding video summaries to each of our guidelines pages for ease of use and accessibility.

#### Search Services

This feature provides price estimates and medical service details to the user. The user can utilize this both to prepare for upcoming hospital visits by looking at service/procedure price estimates, or to help in emergency/unplanned visit situations when the patient is in the hospital and needs to make a decision about whether to receive a service/procedure. We are working on providing specific service information based on the user's state of residence.

#### Find In-Network Hospitals

This feature allows the user both to locate in-network hospitals near them, and determine whether a hospital they are currently at is in-network or not. This is helpful both in emergency/unplanned visit situations as well as planning for a visit, and helps avoid surprise bills by helping the user avoid expensive out-of-network care. We plan to also develop a feature that allows searching for a specific hospital by name and verifying if it is in-network or out-of-network. IMPORTANT: To use this feature, location services must be turned ON

#### Visit Timelines and Summaries

The visit timeline-based note-taking feature allow patients or their family members/caretakers to take detailed, timestamped notes during and after hospital visits in order to track, manage and more effectively dispute surprise bills; eliminate the errors in the bill in order to avoid excess costs.

## License

[MIT](https://choosealicense.com/licenses/mit/)
