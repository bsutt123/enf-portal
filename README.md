# ENF Portal

[Deployed Application](https://radiant-plateau-85733.herokuapp.com) ( you can sign in with the username bsutt123@gmail.com and password to get admin access)

This Ruby on Rails application was designed to help a Summer Camp manage their camps activites online. As such, a lot of the decisions were specific to the way that this camp runs in particular and should not be applied to a general application.

## Intention
There is a massive amount of structuring and planning that has to occur at any summer camp. There are lots different classes all with different students throughout the day, and there has to be a flexible system to know where students are at all times for safety concerns. Currently, the summer camp I attended uses 3-4 adminstrators whose main job is to simply track and plan classes and trips and make sure that they have the resources that they need to have a successful outing. Much of this jobs role is to manually check for complications that will negatively affect the trip (like there isn't a van that can fit all the students, not enough counselors on campus to maintain ratios, etc...). It was my intention to give these adminstrators better tools to track students, classes, trips, and everything on campus such that they could have more time to do what is most important, which is interact and teach the campers new and fun skills. It does this by making counselors fill out Trip Requests online through the portal, and then the adminstrators can use the tools to quickly assess problems and approve or deny the trip.

## Key Model Definitions

If you want to try and understand the code and whats its doing, it all starts with the models and what they represent. There are enough models and they are interconnected enough that I'm going to go over the broad structure of what each model does.

Small note on a convention I followed for join tables. Often, a particular model might have information that persists year to year and information that is important only within the context of a particular session. When you see a combination like SessionCamper, it means that it is all the Campers information which is important for that particular Session, such as Cabin, Classes, etc... This convention is followed heavily throughout the code and is needed to really understand how everything is connected

* Session: A Session is a set of days, and almost all models have an existence within the context of a particular session
* Counselor: An adult who teaches classes and has a cabin
* Camper: a child who attends classes and has a cabin
* Cabin: Cabins are a collection of SessionCampers and SessionCounselors (because the Cabin only exists within the context of a Session)
* Classes: Classes are also a collection of SessionCampers (students) and SessionsCounselors (instructors)
* Trips: Trips are off campus outings which are take by a Class or a Cabin
* Vans: Vans are assigned to Trips to allow them to go off campus and can't overlap with other trips

Obivously, this is a very broad definition of each model, and you can get a feel for the complexity from this graph of the database connections...

![database](erd.jpg)

## Using the Application

To use the application, the administrators have to add you as a User, which will restrict access to the information to only authorized individuals. If you want to visit the test site, then you can use:

#### Admin User
* username: bsutt123@gmail.com
* password: password

#### Standard User
* username: standard@example.com
* password: password

The application data that you see is all fake data that has been automatically seeded. 

The entire app really consists of CRUD for all the models that make up what it means to run a camp. Administrators are in charge of creating the models for:

* Sessions
* Campers
* Counselors
* Classes
* Cabins
* Vans

All of these models need to be created for each session, which does represent a significant time investment. However, because the camp already needs to create all of these things in their system by hand (such as assigning students to classes on index cards), it doesn't necessarily represent more time invested, just time invested in different things.

Once the framework of models is created a for a session, the main model creation is a Trip. Trips are off campus outings taken by a Class or Cabin which need to be carefully tracked and executed. Trips are made by the counselors, then approved by administrators. 

The real benefit to the system is that because of the framework of models and data storage behind the application, it becomes much easier to provide on demand information to the administrators while running the camp and approving trips. Because everything is tracked, here is just a couple of the great additional features that can be much more easily implemented and used:

* Can query the system to find out if a student if off campus on a trip easily if they aren't in another class
* Confirm that no students have medical allergies to the food that has been requested
* Easily determine if the trip has all the resources it requires (drivers, vans, lifegaurds, food, etc...)
* Know how many trips are off campus at any given time, and plan accordingly for all campus meals

The amount of data that becomes available at the fingertips of the administrators increases exponential, and because the system is built on models that reflect the real world, its simple to continue adding models and incorporating them into the current features (for things not implemented like Days Off assignment or Trip Scaffolding)

## Future Work

Future Work for the project includes:

* Creating a more exhaustive test suite
* Refactoring the Code to use the Fat Model Skinny Controller coding paradigm
* Implement data cacheing to increase performance
* Take some components that need more dynamic actions and implement them using Vue instances

## Running Locally

If you want to download and run the project locally, you can fork or clone the repository and pull it down to your machine. You'll need to install the dependencies

```bash
bundle install
```
and because this application uses postgres for development and production, you will have to add your local postgres username and password to the database configuration so that the databases can be created. Once you have that part set up, you can run the app by setup the database and then serving

```bash
rails db:setup
rails s
```

## Thanks

A special thanks to the Rails team, because the amount of thoughtful documentatio that they made for thier framework is astounding. The number of times that I thought I had a completely unique problem that they had already solved using an awesome method or model definition was really great.

[Formtastic](https://github.com/justinfrench/formtastic) as used heavily to implement the forms in a reasonable fashion, and this gem is fantastic you are trying to make complicated forms in Rails simple again.

Along the lines of forms [Cocoon](https://github.com/nathanvda/cocoon) was a fantastic gem that I used to give forms a bit of dynamic javascript without having to delve deep in jquery myself, which was a huge benefit for the application

