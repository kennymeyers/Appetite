# Appetite

### Steps to Run the App

1. Clone the repository
2. Press the run button

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

First I listed out the requirements:

1. Recipe should show its name, photo and cuisine type (at the minimum)
2. The app should allow users to refresh the list at any time
3. The app should be one screen
4. Don’t store the recipe data; don’t use HTTP cache;
5. Unit tests
6. Recipe is malformed disregard; If it’s empty, display an empty state
7. Load images only when needed in the UI to avoid unnecessary bandwidth consumption.

I focused to make sure I displayed competence with those tasks. Who are we without our tasks, I ask. I spent some time making the list look nice, but I spent even more time making sure I had some nice simple tests to show off that displayed all the necessites of testing: DI, unit and providing gatekeepers so nobody accidentally breaks things.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

Total 4-5 hours.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

Yes, this whole app is a tradeoff. On time. On features. On testing.

The utlimate tradeoff is how I want to present myself. Should I build the image caching mechanism or use a prebuilt library. Will showing how well I know NSCache give me bonus points or will the expediency of using a tried and trued library that’s well supported for higher velocity be valued more.  It’s unknowable until you’re in an org but I tend to favor shipping.

The other tradeoffs were mostly about time considering the scope was so small. I could add YouTube videos, etc. make the app more “appy” with fun states.

Tests could be more comprehensive. Right now I’m using straight up URLSession to that endpoint, which actually gives me more accurate test but obviously has a networking and resource cost on the cloudfront endpoint. The next move would be creating fixtures and my own URLProtocol to mock network responses.

I used Nuke to load async images but that is giving up some control of the caching mechanisms. That being said, it’s a very mature library with a small footprint and popular support so it’s my belief they’ve encountered more weird edge cases than I have.

I could very much go on and on about the tradeoffs.

I tried to minimalize the code footprint for readability but I could use modules to separate the model/networking from the ui, helpful for things like widgets and app clips.

I used a List which handles view re-use (and much to my irritation seems to be the only one in SwiftUI) to handle the memory and image loading issues.

### Weakest Part of the Project: What do you think is the weakest part of your project?

- The networking implementation could be more robust with better http status code handling
- The UI is very boring and could use some more interactivity to make it pleasant.
- The models and fetching could be modularized
- More tests, always more tests

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?
- [https://github.com/kean/Nuke](https://github.com/kean/Nuke): Asynchronous Image loader that handles caching.


### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

You look great today.
