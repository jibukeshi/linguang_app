require "import"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.app.*"
import "android.webkit.WebChromeClient"
import "android.webkit.WebViewClient"

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
  onReceivedSslError=function(superCall, view, sslErrorHandler, sslError)
    --ssl证书错误处理事件
    --需自行处理，请返回true拦截原事件
    return true
  end,
  onReceivedHttpError=function(superCall, view, webResourceRequest, webResourceResponse)
    --请求返回HTTP错误码时
  end,
  onReceivedError=function(superCall, view, webResourceRequest,webResourceError)
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
