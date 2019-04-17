One Direction
One Direction
Build and Run project-:

Requirements: 
1: Xcode Version 9.3.1  or greater
2: Swift 4

Build-: Simply open project to your Xcode and Build 
on Successful build you can run project

User Login Process-: On Login Screen please provide your name and mobile number with country code for receiving OTP.
Please verify your OTP which you have received in SMS.

1St Screen-: After successful login you will land on the 1st Screen which is a TABController with 4 tabs. This screen has 2 navigation options "Logout"-: for logout and "+" to create new trip see below Section for more details. 
1: 1st tab displays all ongoing trips around sorted by your nearby distances.
2: 2nd tab displays all the trips (ongoing and expired) you have joined or requested to join  called "MyTrips"
3: 3rd tab displays all the joining requests for trips created by you.
4: 4th tab displays all the comments on the trips you have created

2nd Screen-: 2nd screen also a TABController with 3 tabs. Which contains different tabs to display single Trip details which is selected in previous screen.
1: 1st tab displays all details of a selected trip with trip description and trip path steps etc.
2: 2nd tab displays all the joining requests for the current trip.
4: 3rd tab displays all the comments on the current trip and you also add your comment on the trip.


Bellow is snippt how app works-:

This project is based on traveling
The main goal of this project is to provide a platform where anyone create a trip or journey and other can join him.

Here how it works
Creating a trip
1-: Here a user can create a trip by creating a rout on the map between starting location and destination location.
2-: He can also set the time when the trip will starts and when trip will ends.
3-: User can also set number of travelers who can join him on the trip
4-: User can also write details or itinerary for the trip.

Joining a Trip
1-: A user can join any trip from "All Trips" List which is sorted by current location of the user i.e. Nearest appears at the top of the trips.
2-: User can see all the details of a trip by selecting it.

3-: User can request for a seat for the trip by tapping on ticket Direction.
4-: User can see owner information on tapping user name.
5-: After requesting a ticket for the trip a "Ticket Request" can be "Accepted" or "Declined" by user.

Other Features
1-: User can see all his trips in My trips section including his own created trips and and other joined trips.
2-: User can comment on a trip.
3-: User can see latest comments for the trips created by user.
4-: User can see all the booking requests for the trips created by user.
5-: User can see all comments for the selected trip also.
6-: User can see all booking requests for the selected trip also.
7-: Owner can delete his trip from multiple screens.

* A "Booking request" can have atmost 4 states -: "Requested or pending", "Accepted by owner only" , "Deleted" , "Declined by owner only".
* Trip which are expired will not appear in all trips list

Backend is also developed by me in Node.js


This project is based on traveling  
The main goal of this project is to provide a platform where anyone create a trip or journey and other can join him.

Here how it works
Creating a trip
1-: Here a user can create a trip by creating a rout on the map between starting location and destination location.
2-: He can also set the time when the trip will starts and when trip will ends.
3-: User can also set number of travelers who can join him on the trip
4-: User can also write details or itinerary for the trip.

Joining a Trip
1-: A user can join any trip from "All Trips" List which is sorted by current location of the user i.e. Nearest appears at the top of the trips.
2-: User can see all the details of a trip by selecting it.
3-: User can request for a seat for the trip by tapping on ticket Direction.
4-: User can see owner information on tapping user name.
5-: After requesting a ticket for the trip a "Ticket Request" can be "Accepted" or "Declined" by user.

Other Features
1-: User can see all his trips in My trips section including his own created trips and and other joined trips.
2-: User can comment on a trip.
3-: User can see latest comments for the trips created by user.
4-: User can see all the booking requests for the trips created by user.
5-: User can see all comments for the selected trip also.
6-: User can see all booking requests for the selected trip also.
7-: Owner can delete his trip from multiple screens.

* A "Booking request" can have atmost 4 states -: "Requested or pending", "Accepted by owner only" , "Deleted" , "Declined by owner only".
* Trip which are expired will not appear in all trips list

Backend is also developed by me in Node.js
