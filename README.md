## Fetch

[Sketch](https://drive.google.com/file/d/1jfHRJpVwT6Gruy72wft9Gl0Cb_Lu_FY-/view?usp=sharing)

## Overview

- The idea is to build an application that works similar to Tinder but for dogs. All our team members love dogs and decided to build something that would be catered to the most loyal friend most people have. This mobile application allows the user to sign up using an email ID, sign in using Google and Facebook in order to make a profile for their dogs. The dog profile is then stored on the Firebase server and the preferences submitted are used to show other users. The user can then scroll through other profiles and read more about them. If the user likes it, he/she can chat with the other user using out in-built chat feature. This makes sure that the other user's number of phone number is never revealed to other people. The two users can then chat on our app and even send photos and videos.

- The application also shows a map with all the users marked on it so that the user can see nearby people. The users presented by our app also depend on the preferences one fills out while signing up. These preferences can later be changed and that would allow the displayed users to change as well.

- Hence, we believe that this application would help dog owners to form a close-knit community so that even their dogs can get more friends.

## Design

- Welcome Screen, Dog Information Screens (3), Sign Up Screen, Sign In Screen, Reset Password Screen, User Profile Screens (2),
  Map, Users Table View Controller, User Detailed View Controller, User Chat Screen
  
## Frameworks Used
- Swift MapKit, 
- Swift UI Kit, 
### Cocoa Pods
    - FireBase
        - Various different pods frameworks that can be seen in the podFile. 
    - ProgressHUD
    - SDWebImage
    - Facebook Login core kIt
    - GoogleSignIn

## Features

- Sign-Up by submitting dog information, your email Id and dog's picture
- Sign-In feature using your email and password
- Reset Password feature with the email being sent to your email ID
- Google and Facebook Sign Ins
- Auto-Sign In
- Location Services
- Map View Controller showing nearby users
- Search Bar for looking through Users
- User Profile information that can be edited
- Filtering users based on the preferences
- Chat with other users: send photos and videos
- Firebase

## Instructions To Run

- Navigate to the terminal and run "pod install" before running the program.
- After the installation is done open the file `JCoding.xcworkspace` and run it to see the application

## Team Contributions
  - Himanshu Jain: Firebase Configuration, Chat Feature, Firebase Authentications and getting the user from the database, Basic layout for other view controllers
  - Bilge Tatar- Dog Information View Controllers, Storing User Location, 'Me' View Controller, Filtering Users based on the preferences, Icons used in the App
  - Donald Groh- Map View Controller, Location feature, filtering user features, editing data requesting , and editing "Me" View Controller
  - Emma Helmitch- User's Detailed View Controller, Icon of the App, Ideation'
  
  ## Possible Improvements
  - We discuss this in the video in a fair amount of detail, but the main area that we would improve the way that the application currently runs is through the Sign-In and Sighn-Up pages. Although we have google and facebook authentification, since these frameworks do not provide all the data that we would need to build a user, we would have constructed the application in a little different manner. Possibly in such a way that after creating the dog information, on the email sign in page, there would be the options to sign up with google or facebook rather than having those options where they currenlty are. Additionally we could have a little bit more organized flow of the sign up screens so that you select whether to sign in or sign up early on. 
  
  - In terms of features that we would like to implement, we explain a lot in the video, but really the extent of the features that we would want to implement is unlimited because there would be so many addditional features to get us to the point of being a fully functional and effective application. Please contact us for further elaboration of these possible features. 
