import "android.webkit.WebChromeClient"
import "android.webkit.WebViewClient"
import "android.webkit.DownloadListener"

local html=[[
<!doctype html>
<html>
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" id="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://unpkg.com/@waline/client@v2/dist/waline.css">
  </head>
  <body>
    <div id="waline"></div>
    <script>
  Fancybox.bind("#waline-comment .vcontent img");
</script>
    <script type="module">
    import { init } from "https://unpkg.com/@waline/client@v2/dist/waline.mjs";
    init({
      el: "#waline",
      login: "force",
      copyright: false,
      search: false,
      emoji: [
      "https://gcore.jsdelivr.net/gh/GamerNoTitle/ValineCDN@master/Coolapk/",
      "//unpkg.com/@waline/emojis@latest/bmoji/",
    ],
      serverURL: "https://comment.linlight.cn",
      imageUploader: function (file) {
      let formData = new FormData();
      let headers = new Headers();
      formData.append("file", file);
      headers.append("Authorization", "Bearer 6|kgIHE28US46VCUKD6K0ZX820ZJ2WflDubYEFDuCu");
      headers.append("Accept", "application/json");
      return fetch("https://img.bibiu.cc/api/v1/upload", {
        method: "POST",
        headers: headers,
        body: formData,
      })
        .then((resp) => resp.json())
        .then((resp) => resp.data.links.url);
    },
    });
  </script>
  </body>
</html>
]]
comment.loadDataWithBaseURL(serverUrl..url,html,"text/html","UTF-8",nil)
comment.removeView(comment.getChildAt(0))
comment.setWebViewClient({
  shouldOverrideUrlLoading=function(view,url)
    --Url即将跳转
    activity.newActivity("web",{serverUrl,url})
    return true
  end,
  onPageStarted=function(view,url,favicon)
    --网页开始加载
  end,
  onPageFinished=function(view,url)
    --网页加载完成
  end
})
comment.setWebChromeClient(luajava.override(WebChromeClient,{
  onShowFileChooser=function(a,view,valueCallback,fileChooserParams)
    uploadFile=valueCallback
    local intent=fileChooserParams.createIntent()
    activity.startActivityForResult(intent,1)
    return true
  end
}))

--上传文件回调
onActivityResult=function(requestCode,resultCode,intent)
  local Activity=import "android.app.Activity"
  local Uri=import "android.net.Uri"
  if(resultCode==Activity.RESULT_CANCELED)then
    uploadFile.onReceiveValue(nil)
    return
  end
  if(uploadFile==nil or type(uploadFile)=="number")then
    return
  end
  if(resultCode==Activity.RESULT_OK and intent~=nil)then
    local dataString=intent.getDataString()
    if(dataString~=nil)then
      local results=Uri[1]
      results[0]=Uri.parse(dataString)
      uploadFile.onReceiveValue(results)
    end
  end
end