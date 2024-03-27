# GetALift Development Report

Welcome to the documentation pages of the GetALift!

You can find here details about the GetALift, from a high-level vision to low-level implementation decisions, a kind of Software Development Report, organized by type of activities: 

* [Business modeling](#Business-Modelling) 
  * [Product Vision](#Product-Vision)
  * [Elevator Pitch](#Elevator-pitch)
* [Requirements](#Requirements)
  * [Domain model](#Domain-model)
* [Architecture and Design](#Architecture-And-Design)
  * [Logical architecture](#Logical-Architecture)
  * [Physical architecture](#Physical-Architecture)

Contributions are expected to be made exclusively by the initial team, but we may open them to the community, after the course, in all areas and topics: requirements, technologies, development, experimentation, testing, etc.

Please contact us!

Thank you!

Henrique Marques (up202208752@fe.up.pt), Francisco Moura (up202208750@fe.up.pt), Diogo Faria (up202205201@fe.up.pt), Miguel Mateus (up202206944@fe.up.pt), Ilaha Rahmanzade (up202311893@fe.up.pt)

---
## Business Modelling

### Product Vision

To make travelling affordable and unique.

### Elevator Pitch

This app is for travelers, that see themselves struggling with the high costs of travelling and are searching for a cheaper and more sustainable solution. GetALift is designed to enable users to communicate between themselves to arrange trips, where you could either be a driver or a passenger, making an even split of all costs for all participants of the trip. Why not use the already know companies to travel?  Unlike companies like Uber and Bolt, GetALift allows to make longer trips much more affordable and more enjoyable, since you get to meet lots of new people. Our product distinguishes itself by the eco-friendly and more economic approach to an overcrowded market, that’s greener in every way possible.


## Requirements

In this section, you should describe all kinds of requirements for your module: functional and non-functional requirements.


### Domain model


 <p align="center" justify="center">
  <img src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC01T4/blob/main/domainModelling.png"/>
</p>


## Architecture and Design

### Logical architecture
The Frontend Application component is responsible for user interface functionalities, while the Backend Services handle business logic and interact with the database. Additionally, the Backend Services facilitate communication with the Rating and Review System to manage user feedback and with the Reporting Service to handle reports of undesirable behavior.

![LogicalView](https://user-images.githubusercontent.com/9655877/160585416-b1278ad7-18d7-463c-b8c6-afa4f7ac7639.png)

### Physical architecture
User's Device: Represents the user's mobile device running the mobile app.
Application Server: Hosts both the frontend and backend components of the application, including the database.
Database Server: Represents the server hosting the database, responsible for storing and managing persistent data required by the application.
Communication flows from the mobile app to the frontend application hosted on the Application Server. The frontend application interacts with the backend services also hosted on the Application Server. The backend services communicate bidirectionally with the Database Server for data storage and retrieval operations.
![DeploymentView](https://user-images.githubusercontent.com/9655877/160592491-20e85af9-0758-4e1e-a704-0db1be3ee65d.png)
