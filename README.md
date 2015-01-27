# filmyfilm
Assignment 2 for CodePath 2015s

Rotten Tomatoes client. Learning to make web requests etc

Installation:

Get XCode (Mac only). Clone the project, open in XCode and run. Super simple :)

Hours: 10

Completed Stories:

 * [x]  User can view a list of movies from Rotten Tomatoes. Poster images must be loading asynchronously.
 * [x]  User can view movie details by tapping on a cell.
 * [x]  User sees loading state while waiting for movies API. You can use one of the 3rd party libraries at http://cocoapods.wantedly.com?q=hud.
 * [x]  User sees error message when there's a networking error. You may not use UIAlertView or a 3rd party library to display the error. See this screenshot for what the error message should look like: network error screenshot.
 * [x]  User can pull to refresh the movie list. Guide: Using UIRefreshControl
 *   Add a tab bar for Box Office and DVD. (optional)
 *   Implement segmented control to switch between list view and grid view (optional)
        Hint: The segmented control should hide/show a UITableView and a UICollectionView
 * [x]  Add a search bar. (optional)
 *  All images fade in (optional)
        Hint: Use the - (void)setImageWithURLRequest:(NSURLRequest *)urlRequest method in AFNetworking. Create an additional category method that has a success block that fades in the image. The image should only fade in if it's coming from network, not cache.
 *  For the large poster, load the low-res image first, switch to high-res when complete (optional)
 *  Customize the highlight and selection effect of the cell. (optional)
 *  Customize the navigation bar. (optional)


GIF walkthrough:

![Video Walkthrough](anim_film.gif)
