# EasyConference

**Semester 4 Course Project | Mobile Application**

EasyConference is a mobile-based platform that allows users to register for conferences via the app, and it simplifies the process for conference organizers to manage participants and events. This project was developed as part of a course project in Semester 4.

## Features

- **Conference Registration:** Users can register for conferences directly through the mobile application.
- **User Management:** Organizers can log in to manage participants, including presenters, reviewers, and judges.
- **Conference Oversight:** Organizers can create and manage conferences, add participants, and review their details.
- **Data Persistence:** All user registration data is stored in an SQLite database.

## Technologies Used

- **Front-End:** Flutter (Dart)
- **Back-End:** SQLite
- **IDE:** Visual Studio Code, Android Studio

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/fatihahashhar/easyconference.git
   cd easyconference

2. Install Dependencies

    ```bash
    flutter pub get

3. Run the app

    ```bash
    flutter run

## How It Works

**For Users:**
- Users can register for a conference using the mobile application.
- After registration, their details are stored in the app's SQLite database.
- Users can log in to the platform and manage their conferences.
- Features include adding participants, assigning roles (presenter, reviewer, judge), and overseeing event details.

## Future Enhancements
**Notifications:** 
- Add push notifications to remind users about upcoming conferences.
**Cloud Database Integration:** 
- Implement cloud-based storage for larger conferences.
**Multi-language Support:** 
- Add support for additional languages.
