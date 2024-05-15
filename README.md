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
* [Project management](#Project-Management)
  * [Sprint 1](#Sprint-1)
  * [Sprint 2](#Sprint-2)
  * [Sprint 3](#Sprint-3)
      * [Sprint review](#Sprint-review)
      * [Sprint retrospective](#Sprint-retrospective)


Contributions are expected to be made exclusively by the initial team, but we may open them to the community, after the course, in all areas and topics: requirements, technologies, development, experimentation, testing, etc.

Please contact us!

Thank you!

Henrique Marques (up202208752@fe.up.pt), Francisco Moura (up202208750@fe.up.pt), Diogo Faria (up202205201@fe.up.pt), Miguel Mateus (up202206944@fe.up.pt), Ilaha Rahmanzade (up202311893@fe.up.pt)

---
## Business Modelling

### Product Vision

Imagine an innovative mobile app designed to revolutionize the way people travel by fostering eco-consciousness, social interaction, and cost savings. That is GetALift, an app that connects travelers with similar destinations, enabling them to join forces to reduce their carbon footprint and expenses while enjoying enriching social experiences along the way.

### Elevator Pitch

This app is for travelers, that see themselves struggling with the high costs of travelling and are searching for a cheaper and more sustainable solution. GetALift is designed to enable users to communicate between themselves to arrange trips, where you could either be a driver or a passenger, making an even split of all costs for all participants of the trip. Why not use the already know companies to travel?  Unlike companies like Uber and Bolt, GetALift allows to make longer trips much more affordable and more enjoyable, since you get to meet lots of new people. Our product distinguishes itself by the eco-friendly and more economic approach to an overcrowded market, that’s greener in every way possible.


## Requirements

In this section, you should describe all kinds of requirements for your module: functional and non-functional requirements.


### Domain model


 <p align="center" justify="center">
  <img src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC01T4/blob/main/docs/domainModelling.png"/>
</p>


## Architecture and Design

### Logical architecture
The Frontend Application component is responsible for user interface functionalities, while the Backend Services handle business logic and interact with the database. Additionally, the Backend Services facilitate communication with the Rating and Review System to manage user feedback and with the Reporting Service to handle reports of undesirable behavior.

![LogicalView](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC01T4/blob/main/docs/logical.png)

### Physical architecture
User's Device: Represents the user's mobile device running the mobile app.
Application Server: Hosts both the frontend and backend components of the application, including the database.
Database Server: Represents the server hosting the database, responsible for storing and managing persistent data required by the application.
Communication flows from the mobile app to the frontend application hosted on the Application Server. The frontend application interacts with the backend services also hosted on the Application Server. The backend services communicate bidirectionally with the Database Server for data storage and retrieval operations.
![DeploymentView](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC01T4/blob/main/docs/deployment.png)


## Project management

### Sprint 1

<div style="text-align: center;">
    <div>Sprint 1 start:</div>
    <img src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC01T4/blob/main/docs/Sprint1%20beginning.jpeg" alt="Sprint1 before" style="width: 100%;">
</div>

<div style="text-align: center;">
    <div>Sprint 1 end:</div>
    <img src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC01T4/blob/main/docs/Sprint1%20final.jpeg" alt="Sprint1 after" style="width: 100%;">
</div>
On this sprint were able to do what we propose ourselves to do, so we think that our estimates on the user_stories were accurate. On another hand, we didn't make the unit tests and we were dividing the work between us by different techonogies, for exemple the features and the tests were assigned to different persons on the same feature. To sum up, the next sprint we have to conclude tests and we will divide the work by feature that we think is a better option to coordinate it between us.


### Sprint 2

<div style="text-align: center;">
    <div>Sprint 2 start:</div>
    <img src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC01T4/blob/main/docs/Sprint2%20before.png" alt="Sprint2 before" style="width: 100%;">
</div>

<div style="text-align: center;">
    <div>Sprint 2 end:</div>
    <img src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC01T4/blob/main/docs/Sprint2%20after.png" alt="Sprint2 after" style="width: 100%;">
</div>

On this sprint we were able to do what we propose ourselves to do, so we think that our estimates on the user_stories were accurate and we divide the work more evenly, each person had one user_story and that person had to do everything related to that user_story (tests, dart code, etc...). on another hand, we didn't use branches for each feature, we did work only with the main branch and our tests were not working correctly with the firebase implemented. To sum up, the next sprint we have to conclude the tests and we will try to use more branches when working in the user_stories so we are more organized.


### Sprint 3


<div style="text-align: center;">
    <div>Sprint 3 start:</div>
    <img src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC01T4/blob/main/docs/Start_Sprint3.png" alt="Sprint3 before" style="width: 100%;">
</div>

<div style="text-align: center;">
    <div>Sprint 3 end:</div>
    <img src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC01T4/blob/main/docs/End_Sprint3.png" alt="Sprint3 after" style="width: 100%;">
</div>


### Sprint review

Various pages on the app become easier to use, for exemple the home page. Futhermore, now there is a chat room which makes easier to talk with the driver and discuss the details of the trip. On the other hand, the serach trip page still need a little of work as of now is a little 'ugly'.


### Sprint retrospective

### What went well?

As on the other sprint we were able to finnish all of the user_stories that we propose ourselves to do on this Sprint, and that way finnish all of them, which proves that our estimatives were accurate to what seemed essenssial for us to do in the time that we had. Moreover, we had time to already start little adjustaments to the visual of the app.

### What could have gone better?

We were not able to make the tests work, unit or aceptance, because of the way we were setting the sample database.

### Puzzles?

Except the problem with the tests with didn't have nothing that was creating confusion in the resolution of the project.
