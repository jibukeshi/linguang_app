require "import"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.app.*"
import "android.webkit.WebChromeClient"
import "android.webkit.WebViewClient"
import "android.webkit.DownloadListener"
import"com.google.android.material.dialog.MaterialAlertDialogBuilder"

UiManager=activity.UiManager
Colors=UiManager.Colors
webView=UiManager.currentFragment.webView


--颜色配置
colorAccent=Colors.getColorAccent()--强调色
colorPrimary=Colors.getColorPrimary()--主色
textColorPrimary=Colors.getTextColorPrimary()--主文本色
textColorSecondary=Colors.getTextColorSecondary()--副文本色
windowBackground=Colors.getWindowBackground()--窗体背景色


--获取主页面传递过来的链接
url=...

if(url:find("linguang.top/apps/") or url:find("linguang.top//apps/"))then
  activity.newActivity("app",{url:match("linguang.top/(.+)")})
  activity.finish()
 elseif(url=="https://linguang.top/" or url=="https://linguang.top/index.html")then
  activity.newActivity("main")
  activity.finish()
 else
  webView.loadUrl(url)
end


-- @param title 点击的菜单标题
-- @description 顶栏菜单项目点击回调事件
function onMenuItemClick(title)
  switch title
   case "后退"
    webView.goBack()
   case "前进"
    webView.goForward()()
   case "刷新"
    webView.reload()
   case "分享"
    import "androidx.core.app.ShareCompat"
    ShareCompat.IntentBuilder.from(activity).setText(webView.getUrl()).setType("text/plain").startChooser()
   case "复制链接"
    import "android.content.Context"
    activity.getSystemService(Context.CLIPBOARD_SERVICE).setText(webView.getUrl())
    Toast.makeText(activity,"链接已复制到剪贴板",Toast.LENGTH_SHORT).show()
   case "外部打开"
    import "android.content.Intent"
    import "android.net.Uri"
    local intent=Intent("android.intent.action.VIEW",Uri.parse(webView.getUrl()))
    activity.startActivity(intent)
  end
end


webView.setWebViewClient(luajava.override(WebViewClient,{
  shouldOverrideUrlLoading=function(superCall,view,webResourceRequest)
    --即将开始加载事件
    --返回true则拦截本次加载
    --拦截加载建议在这里操作
    local url=webResourceRequest.getUrl().toString()
    if(url:find("linguang.top/apps/") or url:find("linguang.top//apps/"))then
      activity.newActivity("app",{url:match("linguang.top/(.+)")})
      if not(webView.canGoBack())then
        activity.finish()
      end
      return true
     elseif(url=="https://linguang.top/" or url=="https://linguang.top/index.html")then
      activity.newActivity("main")
      if not(webView.canGoBack())then
        activity.finish()
      end
      return true
    end
    import "android.content.Intent"
    import "android.net.Uri"
    --判断加载的链接是http/s还是scheme
    if not(url:find("^https?://"))then
      local dialog=MaterialAlertDialogBuilder(activity)
      .setTitle("是否打开外部应用")
      .setMessage(url)
      .setPositiveButton("打开",function()
        --给scheme创建一个intent
        local intent=Intent(Intent.ACTION_VIEW,Uri.parse(url))
        --判断有没有对应的应用能打开这个scheme
        if(intent.resolveActivity(activity.getPackageManager())==nil)then
          Toast.makeText(activity,"没有可以用于打开的应用",Toast.LENGTH_SHORT).show()
         else
          activity.startActivity(intent)
        end
      end)
      .setNegativeButton("取消",nil)
      .show()
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
    local sslErr={
      [4]="SSL_DATE_INVALID\n证书的日期无效",
      [1]="SSL_EXPIRED\n证书已过期",
      [2]="SSL_IDMISMATCH\n主机名称不匹配",
      [5]="SSL_INVALID\n发生一般性错误",
      [6]="SSL_MAX_ERROR\n此常量在API级别14中已弃用。此常数对于使用SslError API不是必需的，并且可以从发行版更改为发行版。",
      [0]="SSL_NOTYETVALID\n证书尚未生效",
      [3]="SSL_UNTRUSTED\n证书颁发机构不受信任"
    }
    local dialog=MaterialAlertDialogBuilder(activity)
    .setTitle("安全警告")
    .setMessage(sslError.getUrl().." 的SSL证书有问题，错误详情：\n"..sslErr[sslError.getPrimaryError()])
    .setPositiveButton("继续",function()
      --忽略错误
      sslErrorHandler.proceed()
    end)
    .setNegativeButton("取消",function()
      --取消加载(这是默认行为)
      sslErrorHandler.cancel()
    end)
    .show()
    return true
  end,
  onReceivedHttpError=function(superCall,view,webResourceRequest,webResourceResponse)
    --请求返回HTTP错误码时
  end,
  onReceivedError=function(superCall,view,webResourceRequest,webResourceError)
    --页面加载异常事件
  end,
}))

webView.setWebChromeClient(luajava.override(WebChromeClient,{
  onReceivedTitle=function(superCall,view,title)
    --收到网页标题
    UiManager.toolbar.setTitleText(title)
  end,
  onReceivedIcon=function(superCall,view,bitmap)
    --收到网页图标，是个Bitmap对象
  end,
  onProgressChanged=function(superCall,view,progress)
    --网页加载进度变化
  end,
  onShowFileChooser=function(superCall,view,valueCallback,fileChooserParams)
    --上传文件
    import "android.content.Intent"
    uploadFile=valueCallback--保存回调
    --从fileChooserParams里取出Intent对象
    --这里的Intent对象已经设置好了参数
    local intent=fileChooserParams.createIntent()
    activity.startActivityForResult(intent,1)
    return true
  end,
  onShowCustomView=function(superCall,view,callback)
    --重写 WebChromeClient 必须重写这个方法，否则影响视频全屏
    --Android开发者文档：如果这个方法没有被覆盖，WebView 将向网页报告它不支持全屏模式，并且不会接受网页在全屏模式下运行的请求。
    --视频全屏操作会执行这个方法，想要自己做全屏的可以在这里处理
    --callback 对象是 WebChromeClient.CustomViewCallback
    --保存view供之后退出全屏时移除
    customView=view
    --覆盖在根布局上面
    activity.addContentView(view,FrameLayout.LayoutParams(FrameLayout.LayoutParams.MATCH_PARENT,FrameLayout.LayoutParams.MATCH_PARENT))
    --全屏
    activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION|WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS|WindowManager.LayoutParams.FLAG_FULLSCREEN)
    activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_HIDE_NAVIGATION)
    local lp=activity.getWindow().getAttributes()
    lp.layoutInDisplayCutoutMode=WindowManager.LayoutParams.LAYOUT_IN_DISPLAY_CUTOUT_MODE_SHORT_EDGES
    activity.getWindow().setAttributes(lp)
  end,
  onHideCustomView=function(superCall)
    --视频退出全屏触发的方法，重写onShowCustomView必须同时重写这个方法
    --移除view
    customView.getParent().removeView(customView)
    --取消全屏
    activity.getWindow().clearFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION|WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS|WindowManager.LayoutParams.FLAG_FULLSCREEN)
    activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_IMMERSIVE)
    --变量置空
    customView=nil
  end,
}))

--上传文件回调
onActivityResult=function(requestCode,resultCode,intent)
  import "android.app.Activity"
  import "android.net.Uri"
  --如果通过返回键回到应用，就返回空
  if(resultCode==Activity.RESULT_CANCELED)then
    uploadFile.onReceiveValue(nil)
    return
  end
  --如果正常返回但是回调对象不对，就直接结束
  if(uploadFile==nil or type(uploadFile)=="number")then
    return
  end
  --如果返回Intent对象非空
  if(resultCode==Activity.RESULT_OK and intent~=nil)then
    --拿到数据
    local dataString=intent.getDataString()
    if(dataString~=nil)then
      local results=Uri[1]
      results[0]=Uri.parse(dataString)
      uploadFile.onReceiveValue(results)
    end
  end
end

webView.setDownloadListener(DownloadListener{
  onDownloadStart=function(url,userAgent,contentDisposition,mimeType,contentLength)
    -- 监听下载
    import "java.net.URLDecoder"
    import "android.text.format.Formatter"
    import "android.webkit.URLUtil"
    local fileName=URLDecoder.decode(URLUtil.guessFileName(url,contentDisposition,mimeType))
    local size=Formatter.formatFileSize(activity,contentLength)
    local dialog=MaterialAlertDialogBuilder(activity)
    .setTitle("下载文件")
    .setMessage("文件名："..fileName.."\n文件类型："..mimeType.."\n文件大小："..size.."\n下载链接："..url)
    .setPositiveButton("内部下载",function()
      import "android.content.Context"
      import "android.net.Uri"
      import "java.io.File"
      local path=activity.getSharedData("downloadPath")
      local downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE)
      local request=DownloadManager.Request(Uri.parse(url))
      request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE)--设置通知栏的显示
      request.setDestinationUri(Uri.fromFile(File(path,filename)))--设置下载路径
      request.setVisibleInDownloadsUi(true)--下载的文件可以被系统的Downloads应用扫描到并管理
      request.setTitle(fileName)--设置通知栏标题
      request.setDescription(url)--设置通知栏消息
      request.setShowRunningNotification(true)--设置显示下载进度提示
      local downloadId=downloadManager.enqueue(request)
      local downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE)
      local query=DownloadManager.Query()
      local cursor=downloadManager.query(query)
      if(not cursor.moveToFirst())then
        cursor.close()
        return
      end
      Toast.makeText(activity,"开始下载，请前往通知栏查看下载进度",Toast.LENGTH_SHORT).show()
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