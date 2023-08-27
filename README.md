# Enemy Loss Tracker

Enemy Loss Tracker is an iOS application developed as a test task for the MacPaw Bootcamp programme for the position of Junior macOS/iOS Software Engineer. The purpose of the app is to display data on russian losses during the russian invasion of Ukraine

## Project Details

- **Xcode Version:** 14.3
- **Programming Languages:** Swift
- **User Interface:** Built using UIKit programmatically

## Screens

1. **SplashView Screen:** The initial screen that users see when they start the application. It's used for application initialization.

2. **Losses Screen:** This screen displays the total losses of enemy military equipment and personnel based on data received on a specific date.

3. **Equipment Losses Screen:** This screen lists military equipment losses. It provides search functionality and allows users to view detailed information about selected equipment categories.

4. **Equipment Losses Detail View:** This screen opens when a specific row is selected on the Equipment Losses screen. It provides additional information about the loss of a particular piece of equipment, such as model, manufacturer, and total loss amount.

5. **Donations Screen:** This screen displays a list of charitable contributions or donors. It allows users to interact with individual donors, navigate to detailed information, or visit the donor's website.

## Data Source

The application fetches data from the repository [https://github.com/MacPaw/2022-Ukraine-Russia-War-Dataset/tree/main/data](https://github.com/MacPaw/2022-Ukraine-Russia-War-Dataset/tree/main/data) using the URLSession class. Core Data framework is used to store and manage the downloaded data, which is then decoded and processed.

## Technologies Used

- **URLSession**: Interacting with external resources (APIs, JSON files, etc.).
- **Core Data**: Storing and managing downloaded data.
- **Grand Central Dispatch (GCD)**: Controlling parallel and asynchronous task processing.
- **MVC Design Pattern**: Organizing the application's architecture.
- **Singleton Pattern**: Managing global data and functionality.
- **Unit Testing**: Creating unit tests for various components of the application.
- **Apple Human Interface Guidelines**: Designing the user interface according to Apple's guidelines.

## Preview
<div align="center">
     <img src = "https://github.com/demenkoeugene/EnemyMilitaryLossTracker/blob/dfc1f932ae0260d79e551a8a76ec8b6e11d71217/2023-08-27%2022.57.41.gif" width = "40%">
</div>


## Next Steps

The future improvements for the application include:

- Enhancing the UI components for a better user experience.
- Adding more advanced features to equipment models.
- Developing comprehensive unit and UI tests.
- Improving overall application performance.
- Displaying more detailed analytics on losses.

## Preparing for App Store Submission

Before publishing the app to the App Store, the following steps need to be taken:

1. **Localisation:** Implement localization to support multiple languages.
2. **Optimisation:** Optimize code, reduce memory usage, and minimize load times.
3. **Security Measures:** Implement security measures to protect user data and ensure compliance with privacy policies.
4. **Apple Developer Account:** Sign up for an Apple developer account.
5. **App Store Connect Configuration:** Create an app ID and configure necessary App Store Connect settings.
6. **Meta-Data:** Fill in metadata information for the app.
7. **Review Guidelines:** Review Apple's App Store review guidelines to ensure compliance.
8. **Verification Process:** Go through Apple's app verification process.

By following these steps, the app will be prepared for submission to the App Store, ensuring a smooth and successful launch.

# <p align="center">Слава Україні!🇺🇦</p>
