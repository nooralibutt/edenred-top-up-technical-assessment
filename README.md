# Mobile Top Up

This is an assignment task to provide top up services to under banked employees

## Documentation

#### Dependency Injection - Top Up Service

Code has an abstract class named `ITopUpService` which contains abstract methods, which I have mocked currently using `MockTopUpService`. It is serving as a backend service and providing all the mocked data to work with.

#### Top Up Manager

This class contains all the business logic, serving a layer between UI and Data Layer.

#### Inherited Widget - Top Up Manager Provider

In order to access `Top Up Manager` class anywhere in our top up service module, I have used Inherited widget to propogate manager to its dependednt widgets

#### Screens

There are total 3 screens

1. Home Tab Screen
    1. Recharge Tab
    2. History Tab
3. Add Beneficiary Screen
4. Top Up Screen

## Screenshots

Empty Home Page             |  Home Page             |  Add Beneficiary
:-------------------------:|:-------------------------:|:-------------------------:
<img src="/screenshots/empty-home.png" style="height: 400px; width:225px;"/>  |  <img src="/screenshots/home.png" style="height: 400px; width:225px;"/>  |  <img src="/screenshots/add-beneficiary.png" style="height: 400px; width:225px;"/>

Add Beneficiary Success             |  History             |  Top Up
:-------------------------:|:-------------------------:|:-------------------------:
<img src="/screenshots/add-beneficiary-success.png" style="height: 400px; width:225px;"/>  |  <img src="/screenshots/history.png" style="height: 400px; width:225px;"/>  |  <img src="/screenshots/top-up.png" style="height: 400px; width:225px;"/>
