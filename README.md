# Rank Everything

The Flutter project for '_Rank Everything_', a social experiment where users rank completely arbitrary things! Made in the Material 3 style.

## Features

Currently planned features outline a very simple app.

- Navigate between the Dashboard, Stats and Settings pages
- Dashboard
  - Display and choose between two arbitrary things
  - See percentage estimate of how much the general public agrees with you on choosing a thing
- Settings
  - Theme (System/Light/Dark)
  - Color (System/Custom)
  - Adult content filtering (Shown/Hidden/Blurred)
- Stats
  - Browse rankings of things
  - Filter by search query
  - Filter by category
  - Sort by either 10 best or 10 worst
  - Submit a thing through a modal opened on this page

## Setting Up

To run this app in a development environment, you must first have Flutter installed on your system. For help getting started with Flutter development, view the [online documentation](https://flutter.dev/docs), which offers tutorials, samples, guidance on mobile development, and a full API reference.

Frontend is a standard Flutter app with no extra requirements. If you already have Flutter installed, running is as simple as `flutter run`.

## Roadmap

### Current Plans
- Complete the app according to the feature list, assuming the app will be deployed on Android
- Make the app functional on web, with width changing layout
- I currently have a simple stateless atlas backend but plan to switch to using php as a backend hosted on my own VPS with Portainer + Watchtower using DockerHub and GitHub actions for good CI/CD
- A seperate 'distribution' project will be made closer to release, which will contain a GitHub pages deployment, accessible via the _woukie.net_ domain, this will contain a web version of the app, along with a project show-off page

### If I had the time and money
- Load images of things from the Google or Bing search api rather than requiring users to find links to images themselves (costs loads o money ;-;)
- Distribute on ios ($100 YEARLY developer fee is crazy, also I need a mac)
- Email verification with an account system in order to prevent spam and mass delete based on submitter (time constraint)
- Moderator app for manually reviewing submissions, resolving reports and flagging/resolving frequently skipped things (also a time issue)
