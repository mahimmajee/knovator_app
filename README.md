# knovator_app

App to call Api for posts and see description of that post.

# Provider State Management
This project is using Provider as state management. To achieve the ListTile color change,
timer and showing lists of post and detail screen, Provider is being used.

# Visibility Detector
When we call the API there is a timer on the right side of the List. This timer runs only 
when that particular ListTile is visible on the screen. This is achieved using a package 
called visibility_detector.I have wrapped the ListTile inside the visibility_detector 
widget. What it does is it checks if that particular widget is visible, even if a fraction of it 
is visible then it triggers the toggle timer function that I have made which in turn runs
the timer of the respective ListTile.

# Local Storage
To achieve Local Storage I have used Hive. I open two boxes in the main screen, for PostList and the
posts itself. Then I have made functions in postviewmodel that checks if the data is present in local storage.
If yes, then I take data from there and update the local storage in the background. If not,
then I directly call the function in viewmodel that is used for triggering the api and storing the data.

# To run the app
To run the app simply install the apk, and the timer will run. Random timers are used like 
10,20 and 25 by using Random(). If you click on a ListTile it will turn white and open the description
page of the ListTile.
