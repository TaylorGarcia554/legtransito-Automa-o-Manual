# Enrollment and Messaging Automation
This project was created to automate a manual enrollment and messaging process, which was slow and error-prone. The initial solution was developed in Python and later migrated to Flutter, using Dart to provide a more user-friendly interface.

## Problem Context
The manual process involved the following steps:

 - Constantly switching browser tabs to copy data (name, email, CPF, etc.) from a ChatGuru conversation. 
 - Creating and editing users on the EAD platform.
 - Updating user information, such as CPF and password.
 - Finalizing the enrollment and sending 4 messages with specific data, including the user's email and password.
 - Repeating the process for each new user.
This flow was inefficient and time-consuming, primarily due to the repetitive manual actions and the need to switch between tabs.

## Developed Solution
The Flutter-based solution allows for:

 - Entering all client data on a single screen.
 - Selecting whether or not to send the confirmation message (sometimes only a payment link is needed, so the message isn't required).
 - Automatically sending the data to the EAD platform API, registering or updating the user.
 - If the user already exists, the system updates the provided information.
 - Connecting to the ChatGuru API to send automated messages with the registered email and password.
 - Executing an automated ChatGuru dialogue (a series of chatbot messages) after enrollment.
 - Automatically filling out additional fields in ChatGuru, eliminating the need for manual editing.

## Technologies Used
 - Python: Initial solution to automate the process (focused on logic and API integration).
 - Flutter/Dart: Migration to a more user-friendly solution with a graphical interface.
 - APIs: Integration with EAD platform and ChatGuru APIs.
 - Future.wait: Optimization of parallel requests, significantly improving performance.

## Key Learnings
During the development of this project, I gained knowledge in:

 - API Handling: Managing different types of data, such as strings and integers, depending on the API request.
 - Data Transfer between APIs: Understanding how to pass data from one platform to another efficiently.
 - Request Optimization: Using Future.wait in Flutter to send multiple requests simultaneously, boosting system efficiency.
 - Flutter Development: Building a functional and responsive interface, as well as working with Dart’s specific features.

## How to Use
 - Clone this repository.
 - Configure API keys for the EAD platform and ChatGuru.
 - Input client data into the interface and select the desired actions.
 - The system will handle the rest, from enrolling users in the EAD platform to sending messages via ChatGuru.
