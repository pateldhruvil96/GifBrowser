# GifBrowser
Let’s build a GIF Browser, which talks to giphy’s /trending endpoint and presents the results in a nice grid layout of your choice.
API used:https://developers.giphy.com/dashboard/?create=true
Demo link: https://youtu.be/F4t_WzzjsYo
Features:
-Created tableView for loading all the gifs
-Called giphyAPI(Limit:25) and showing 10 gif’s
-CocoPods used: 
  1)Kingfisher(for converting URL to gifs)
  2)Alamofire(for calling API)
  3)SwiftyJSON(for parsing JSON)
-Added nice animation while tapping start button
-Made some changes in navigationBar(UI related)
-Architecture used: MVC(Mode View Controller)
-Added offline functionality and supports portrait & landscape functionality
-When user taps on gifs new view controller opens consisting of GIF title and GIF 
