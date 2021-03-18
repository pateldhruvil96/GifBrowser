# GifBrowser
Let’s build a GIF Browser, which talks to giphy’s /trending endpoint and presents the results in a nice grid layout of your choice.</br>
API used:https://developers.giphy.com/dashboard/?create=true </br>
Demo link: https://youtu.be/F4t_WzzjsYo </br>
Features: </br>
-Created tableView for loading all the gifs </br>
-Called giphyAPI(Limit:25) and showing 10 gif’s </br>
-CocoPods used: </br>
  1)Kingfisher(for converting URL to gifs)</br>
  2)Alamofire(for calling API)</br>
  3)SwiftyJSON(for parsing JSON)</br>
-Added nice animation while tapping start button</br>
-Made some changes in navigationBar(UI related)</br>
-Architecture used: MVC(Mode View Controller)</br>
-Added offline functionality and supports portrait & landscape functionality</br>
-When user taps on gifs new view controller opens consisting of GIF title and GIF </br>
