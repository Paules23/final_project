# QuestLog

For the final project of the Mobile Devices class, we have created an app that aims to emulate the famous Letterboxd app, which serves as social media for people to post movie reviews, but tailored for video games instead. The name of our app is QuestLog.

## About the project 

To develop this app, we have utilized a Steam API that provides information about games, including names, descriptions, images, developers, publishers, prices, and genres. This is the main API used throughout the application. Additionally, in the explore screen, we use a featured Steam games API that displays the featured games on Steam. Note that this API is non-official.

We have developed it using Flutter and Visual Studio Code.

## Content

The app has 4 screens:
- **Home Screen**: This is the main screen featuring three tabs. The games tab displays a list of random games that can be clicked; doing so navigates to the game screen. The reviews tab's content is a placeholder showing the intended design of an actual reviews tab. Since we haven't integrated an API for logging in, users cannot review games yet. Finally, the lists tab, which will be available soon.
- **Search screen**: This screen includes a list of featured games and a search functionality. In this search bar, we can look up any game available on Steam and navigate to the game screen to like the game or view its specific details.
- **Collection screen**: This screen holds a list of all the liked games.
- **Game screen**: This screen is specific to the game that is clicked and shows an image of the game along with information about it such as a description, genre, price, publisher, and developer. Here, you can also press the like button, which will add that specific game to your collection screen.

## Things to know before using it

- Since all the games that appear are taken randomly from Steam, it is possible that some games with pornographic content may appear, so please be aware.
- Since the featured games are taken from a non-official API, the game IDs cannot be retrieved. Therefore, if you like a game from that list, it will appear as loading indefinitely in the game collection. Also, the descriptions and information are not available. However, you can still enter those games by searching for them in the search bar, and they'll work properly. We decided to leave this feature in, even if it's not working as well as it should because we thought that it was interesting to use different APIs.
- When loading the games on the home screen, the debug console might indicate that some games are not loaded correctly. This happens because on Steam, there are apps that are not games, such as demos, DLCs, or hardware apps. The Steam API does not provide a way to differentiate these using a game ID, so we cannot avoid those apps. However, this does not impact the application's functionality.

## Creators

**Pau Vivas**: github link: https://github.com/Paules23

**Eric Regaloin**: Github Link: https://github.com/RegalonaManda
