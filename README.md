# knovator_app

App to call Api for posts and see description of that post.

# Bloc State Management
This project is using Bloc as state management. To achieve the ListTile color change,
timer and showing lists of post and detail screen, Bloc is being used. First I made three files,
PostEvent, PostState and PostBloc. PostEvent gives the event that will be triggered, PostState
gives the State of the variables that will change and state of the app will change accordingly 
and PostBloc inBetween utilizes both file to communicate between them to show the state change.

# Tile Color Change
The _changeTileColor function in PostBloc handles the ChangeTileColor event, allowing the 
color of a specific tile in the postList to be updated. When triggered, it creates a new 
copy of the postList to maintain immutability, modifies the tileColor property of the 
specified item, and then emits the updated state using the copywith method. This ensures 
the UI reflects the color change seamlessly while preserving the integrity of the state 
management.

# Visibility Detector
When we call the API there is a timer on the right side of the List. This timer runs only 
when that particular ListTile is visible on the screen. This is achieved using a package 
called visibility_detector.I have wrapped the ListTile inside the visibility_detector 
widget. What it does is it checks if that particular widget is visible, even if a fraction of it 
is visible then it triggers the toggle timer function that I have made which in turn runs
the timer of the respective ListTile.The timer functionality in PostBloc allows each list 
item to have an independent countdown timer, managed via a timers map (Map<int, Timer>). 
The timerStreamController broadcasts updates for each timer index, ensuring real-time UI 
updates. Timers are started with _startTimer, which creates a periodic timer that emits the
index every second, and stopped with _stopTimer, which cancels and removes the timer to 
prevent duplication. State transitions are handled immutably using the copywith method to 
update the post list. Proper resource management is ensured by canceling all active timers 
and closing the StreamController when the Bloc is closed, preventing memory leaks and 
ensuring efficient operation.

# Local Storage
To achieve Local Storage I have used Hive. I open two boxes in the main screen, for PostList and the
posts itself. Then I have made functions in PostBloc that checks if the data is present in local storage.
If yes, then I take data from there and update the local storage in the background. If not,
then I go to else part that is used for triggering the api and storing the data.

# To run the app
To run the app simply install the apk, and the timer will run. Random timers are used like 
10,20 and 25 by using Random(). If you click on a ListTile it will turn white and open the description
page of the ListTile.
