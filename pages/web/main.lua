require "import"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.app.*"
import "android.webkit.WebChromeClient"
import "android.webkit.WebViewClient"
import "android.webkit.DownloadListener"

UiManager=activity.UiManager
Colors=UiManager.Colors


--颜色配置
强调色=Colors.getColorAccent()
主色=Colors.getColorPrimary()
主文本色=Colors.getTextColorPrimary()
副文本色=Colors.getTextColorSecondary()
窗体背景色=Colors.getWindowBackground()


--获取主页面传递过来的链接
url=...

if(url:find("linguang.top/apps/") or url:find("linguang.top//apps/"))then
  进入子页面("app",{url:match("linguang.top/(.+)")})
  退出页面()
 elseif(url=="https://linguang.top/" or url=="https://linguang.top/index.html")then
  进入子页面("main")
  退出页面()
 else
  加载网页(url)
end


-- @param title 点击的菜单标题
-- @description 顶栏菜单项目点击回调事件
function onMenuItemClick(title)
  switch title
   case "后退"
    网页后退()
   case "前进"
    网页前进()
   case "刷新"
    刷新网页()
   case "分享"
    分享文本(获取网址())
   case "复制链接"
    复制文本(获取网址())
    弹出消息("链接已复制到剪贴板")
   case "外部打开"
    import "android.content.Intent"
    import "android.net.Uri"
    activity.startActivity(Intent("android.intent.action.VIEW",Uri.parse(获取网址())))
  end
end

UiManager.currentFragment.webView.setWebViewClient(luajava.override(WebViewClient,{
  shouldOverrideUrlLoading=function(superCall,view,webResourceRequest)
    --即将开始加载事件
    --返回true则拦截本次加载
    --拦截加载建议在这里操作
    local url=webResourceRequest.getUrl().toString()
    if(url:find("linguang.top/apps/") or url:find("linguang.top//apps/"))then
      进入子页面("app",{url:match("linguang.top/(.+)")})
      if not(获取浏览器().canGoBack())then
        退出页面()
      end
      return true
     elseif(url=="https://linguang.top/" or url=="https://linguang.top/index.html")then
      进入子页面("main")
      if not(获取浏览器().canGoBack())then
        退出页面()
      end
      return true
    end
    return false
  end,
  onPageFinished=function(superCall,view,url)
    --页面加载结束事件
  end,
  onPageStarted=function(superCall,view,url,favicon)
    --页面开始加载事件
  end,
  onLoadResource=function(superCall,view,url)
    --页面资源加载监听
    --可通过该方法获取网页上的资源
  end,
  onReceivedSslError=function(superCall,view,sslErrorHandler,sslError)
    --ssl证书错误处理事件
    --需自行处理，请返回true拦截原事件
    return true
  end,
  onReceivedHttpError=function(superCall,view,webResourceRequest,webResourceResponse)
    --请求返回HTTP错误码时
  end,
  onReceivedError=function(superCall,view,webResourceRequest,webResourceError)
    --页面加载异常事件
  end,
}))
UiManager.currentFragment.webView.setWebChromeClient(luajava.override(WebChromeClient,{
  onReceivedTitle=function(superCall,view,title)
    --收到网页标题
    设置标题(title)
  end,
  onReceivedIcon=function(superCall,view,bitmap)
    --收到网页图标，是个Bitmap对象
  end,
  onProgressChanged=function(superCall,view,progress)
    --网页加载进度变化
  end,
}))

UiManager.currentFragment.webView.setDownloadListener(DownloadListener{
  onDownloadStart=function(url,user_agent,contentDisposition,mimeType,content_length)
    -- 监听下载
    import "java.net.URLDecoder"
    import "android.text.format.Formatter"
    import "android.webkit.URLUtil"
    local filename=URLDecoder.decode(URLUtil.guessFileName(url,contentDisposition,mimeType))
    local size=Formatter.formatFileSize(activity,content_length)
    local dialog=AlertDialog.Builder(this)
    .setTitle("下载文件")
    .setMessage("文件名："..filename.."\n文件类型："..mimeType.."\n文件大小："..size.."\n下载链接："..url)
    .setPositiveButton("内部下载",function()
      import "android.content.Context"
      import "android.net.Uri"
      import "android.service.voice.VoiceInteractionSession$Request"
      local path=activity.getSharedData("下载目录")
      if(path:find("/sdcard"))then
        path=path:match("/sdcard(.+)")
      end
      if(path:find("/storage/emulated/0"))then
        path=path:match("/storage/emulated/0(.+)")
      end
      local downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE)
      local request=DownloadManager.Request(Uri.parse(url))
      request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE)--设置通知栏的显示
      request.setDestinationInExternalPublicDir(path,filename)--设置下载路径
      request.setVisibleInDownloadsUi(true)--下载的文件可以被系统的Downloads应用扫描到并管理
      request.setTitle(filename)--设置通知栏标题
      request.setDescription("将下载到"..path)--设置通知栏消息
      request.setShowRunningNotification(true)--设置显示下载进度提示
      local downloadId=downloadManager.enqueue(request)
      local downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE)
      local query=DownloadManager.Query()
      local cursor=downloadManager.query(query)
      if(not cursor.moveToFirst())then
        cursor.close()
        return
      end
      弹出消息("开始下载，请前往通知栏查看下载进度")
    end)
    .setNegativeButton("外部下载",function()
      import "android.content.Intent"
      import "android.net.Uri"
      activity.startActivity(Intent("android.intent.action.VIEW",Uri.parse(url)))
    end)
    .setNeutralButton("取消",nil)
    .show()
  end
})