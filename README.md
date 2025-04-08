# Aptitude App (Flutter Mini Project)

## 📌 Project Objective
### The Aptitude App is a mobile application built using Flutter and Dart that enables users to:

* Take aptitude tests
* Save and review their test reports
* Visualize performance using interactive graphs
* Authenticate via Firebase (Google, Gmail login supported)

This application is useful for students and job aspirants preparing for competitive exams.

## 📌 Mockups
### Screens:

1.  Login/Register (Firebase Auth with Google)
2.  Home Dashboard
3.  Test Categories
4.  Quiz/Test Interface
5.  Result Summary
6.  Result History
7.  Performance Report (with Charts)

## 📌 Features Overview

<table>
  <tr>
    <th>Features</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>User Auth</td>
    <td>Firebase Auth (Google, Gmail)</td>
  </tr>
  <tr>
    <td>Quiz Module</td>
    <td>Dynamic test-taking feature with MCQs</td>
  </tr>
  <tr>
    <td>Reports</td>
    <td>Stores scores with timestamps</td>
  </tr>
  <tr>
    <td>Visualization</td>
    <td>	Graphs using fl_chart</td>
  </tr>
  <tr>
    <td>Local DB</td>
    <td>SharedPreferences for quick state saving</td>
  </tr>
  <tr>
    <td>External API</td>
    <td>Uses a sample API for fetching random aptitude questions</td>
  </tr>
  <tr>
    <td>Error Handling</td>
    <td>Handled using try-catch and FlutterError.onError</td>
  </tr>
</table>

## 📌 Architecture & Tools

* Flutter (Dart)
* Firebase Auth (Google, Gmail)
* SharedPreferences (Local storage)
* fl_chart (Graphs and visualizations)
* Provider (State Management)
* http (External API calls)

## 📌 Sceenshots

<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/a8ecfc6c-a0c2-46b4-ae23-eaa578dc5655" alt="Sign Up" width="300"></td>
    <td><img src="https://github.com/user-attachments/assets/65d5396c-103a-43a2-ad87-d40ce67dc281" alt="Sign In" width="300"></td>
    <td><img src="https://github.com/user-attachments/assets/0452ba3b-a080-4ea7-9e7a-b8f8e716ea7f" alt="Home Page" width="300"></td>
    <td><img src="https://github.com/user-attachments/assets/cfcef028-1ba4-4d51-806d-1c7e14f28546" alt="Start Test" width="300"></td>
    <td><img src="https://github.com/user-attachments/assets/8c3a88f6-7a36-4b9b-a75b-ed24ba200ce3" alt="Display Question" width="300"></td>
  </tr>
   <tr>
    <td><img src="https://github.com/user-attachments/assets/a06f9fc9-bff4-40e1-aee2-2d6323820f93" alt="Correct Answer" width="300"></td>
    <td><img src="https://github.com/user-attachments/assets/abe86806-3cb6-4ae7-b044-335b8dffa089" alt="Wrong Answer" width="300"></td>
    <td><img src="https://github.com/user-attachments/assets/2044f486-cb34-4c96-95b1-4afa9019bf15" alt="Save Score" width="300"></td>
    <td><img src="https://github.com/user-attachments/assets/59a42899-ac5b-4122-a4c6-5b159e2ea999" alt="Test History" width="300"></td>
    <td><img src="https://github.com/user-attachments/assets/0961b6e1-3680-4850-929b-ac21a62f4005" alt="Progress" width="300"></td>
  </tr>
</table>
