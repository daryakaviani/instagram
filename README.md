# Project 4 - *Instagram*

**Instagram** is a photo sharing app using Parse as its backend.

Time spent: **40** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can sign up to create a new account using Parse authentication
- [x] User can log in and log out of his or her account
- [x] The current signed in user is persisted across app restarts
- [x] User can take a photo, add a caption, and post it to "Instagram"
- [x] User can view the last 20 posts submitted to "Instagram"
- [x] User can pull to refresh the last 20 posts submitted to "Instagram"
- [x] User can tap a post to view post details, including timestamp and caption.

The following **optional** features are implemented:

- [x] Run your app on your phone and use the camera to take the photo
- [x] Style the login page to look like the real Instagram login page.
- [x] Style the feed to look like the real Instagram feed.
- [x] User can use a tab bar to switch between all "Instagram" posts and posts published only by the user. AKA, tabs for Home Feed and Profile
- [x] User can load more posts once he or she reaches the bottom of the feed using infinite scrolling.
- [x] Show the username and creation time for each post
- [x] After the user submits a new post, show a progress HUD while the post is being uploaded to Parse
- User Profiles:
  - [x] Allow the logged in user to add a profile photo
  - [x] Display the profile photo with each post
  - [x] Tapping on a post's username or profile photo goes to that user's profile page
- [x] User can comment on a post and see all comments for each post in the post details screen.
- [x] User can like a post and see number of likes for each post in the post details screen.
- [x] Implement a custom camera view.

The following **additional** features are implemented:

- [x] Redesigned the assets of the the application to be compatible with Dark Mode.

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. I would love to learn more about PFRelations which I used for likes. I feel like they are super versatile and promising for my personal application.
2. I want to become better at using Stack Views for autolayout, which I am still struggling to incorporate!

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://g.recordit.co/A3FTKW0N3A.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with RecordIt.

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [Parse](https://parseplatform.org/) - customizable backend
- [DateTools](https://github.com/MatthewYork/DateTools) - calculates the time ago from now
- [MBProgressHUD](https://github.com/jdg/MBProgressHUD) - activity indicators
- [IQKeyboardManager](https://github.com/hackiftekhar/IQKeyboardManager) - pushes views up with the keyboard

## Notes

I needed create a new Heroku app because the quota limit for my original one was far too low, preventing me from posting higher resolution images.

## License

    Copyright 2020 Darya Kaviani

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
