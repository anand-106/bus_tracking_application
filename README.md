# Bus Tracking Application

This repository contains two Flutter applications designed to track the location of buses in real-time. Initially implemented for a college bus system, this model can be scaled to a state-level transport system like KSRTC. The two applications are:

1. **Driver App**: Allows bus drivers to send their location updates.
2. **User App**: Enables users to select a bus route and view the bus's real-time location on a map.

Both applications use Firebase Realtime Database to update and retrieve the location data in real-time.

## Table of Contents

- [Features](#features)
- [Technologies Used](#technologies-used)
- [Driver App](#driver-app)
- [User App](#user-app)
- [Screenshots](#screenshots)
- [Contributing](#contributing)

## Features

### Driver App
- Real-time location updates sent to Firebase.
- Simple and intuitive user interface for ease of use.

### User App
- Selection of bus routes to track.
- Real-time bus location updates displayed on a map.
- Map integration for visualizing bus routes and locations.

## Technologies Used

- Flutter
- Dart
- Firebase Realtime Database
- Mapbox Maps API
- Firebase Authentication

## Driver App

The Driver App is designed for bus drivers to send their current location to the Firebase Realtime Database.

### Key Features

- **Location Updates:** The app captures the driver's current location and updates it in real-time to Firebase.

## User App

The User App allows passengers to select a bus route and view the bus's current location on a map.

### Key Features

- **Select Route:** Users can select a bus route to track.
- **Real-Time Tracking:** The bus's real-time location is displayed on a map, updating dynamically as the bus moves.

## Screenshots

### Driver App
![Driver App Screenshot](https://github.com/anand-106/bus_tracking_application/blob/main/screenshots/bus_driver_ss1.jpg)
![Driver App Screenshot](https://github.com/anand-106/bus_tracking_application/blob/main/screenshots/bus_driver_ss2.jpg)

### User App
![User App Screenshot](https://github.com/anand-106/bus_tracking_application/blob/main/screenshots/bus_tracking_ss1.jpg)
![User App Screenshot](https://github.com/anand-106/bus_tracking_application/blob/main/screenshots/bus_tracking_ss2.jpg)

## Contributing

Contributions are welcome! Please fork the repository and create a pull request with your changes.

1. Fork the repository.
2. Create a new branch: `git checkout -b feature-branch`
3. Make your changes and commit them: `git commit -m 'Add some feature'`
4. Push to the branch: `git push origin feature-branch`
5. Submit a pull request.


Feel free to reach out if you have any questions or need further assistance!

Happy coding! 🚀
