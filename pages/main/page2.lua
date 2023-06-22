import "android.webkit.WebChromeClient"
import "android.webkit.WebViewClient"
import "android.webkit.DownloadListener"

--第二页布局，就一个LuaWebView，但是不能用FA2自带的因为有bug
page2Layout=--常规框架
{
  FrameLayout;--帧布局
  layout_width="fill";--布局宽度
  layout_height="fill";--布局高度
  {
    LinearLayout;--线性控件
    orientation="vertical";--布局方向
    layout_width="fill";--布局宽度
    layout_height="fill";--布局高度
    gravity="center";--控件内容的重力方向
    --左:left 右:right 中:center 顶:top 底:bottom
    layout_margin="10dp";--控件外边距
    id="page2Loading";--设置控件ID
    {
      ProgressBar;--进度条控件
      layout_width="wrap";--布局宽度
      layout_height="wrap";--布局高度
      --Max="";--设置最大进度
      --Progress="";--设置当前进度
      --SecondaryProgress="";--设置第二进度
      --indeterminate=false;--设置是否为不明确进度进度条,true为明确
      --indeterminate=false;--模糊模式,true为开启
      --style="?android:attr/progressBarStyleLarge";--超大号圆形风格
      --style="?android:attr/progressBarStyleSmall";--小号风格
      --style="?android:attr/progressBarStyleSmallTitle";--标题型风格
      --style="?android:attr/progressBarStyleHorizontal";--长形进度条
      id="page2Progress";--设置控件ID
    };
    {
      TextView;--文本控件
      layout_width="fill";--控件宽度
      layout_height="wrap";--控件高度
      text="获取中……";--显示文字
      textSize="16sp";--文字大小
      textColor=textColorPrimary;--文字颜色
      id="page2Message";--设置控件ID
      --singleLine=true;--设置单行输入
      --ellipsize="end";--多余文字用省略号显示
      --start 开始 middle 中间 end 结尾
      --Typeface=Typeface.DEFAULT;--字体
      --textIsSelectable=true;--文本可复制
      --style="?android:attr/buttonBarButtonStyle";--点击特效
      gravity="center";--重力
      --左:left 右:right 中:center 顶:top 底:bottom
      layout_margin="5dp";--控件外边距
    };
  };
  {
    LuaWebView;--浏览器控件
    layout_width="fill";--浏览器宽度
    layout_height="fill";--浏览器高度
    id="page2Web";--控件ID
    background=windowBackground;--控件背景
  };
};

--添加第二页布局
UiManager.getFragment(1).view.addView(loadlayout(page2Layout))


page2Web.loadUrl("https://bwcxlg.top/")
page2Web.removeView(page2Web.getChildAt(0))--去除进度条
page2Web.setVisibility(View.INVISIBLE)--将WebView设置为隐藏，能看见下面的加载进度条
page2Loading.setVisibility(View.VISIBLE)
page2Web.setWebViewClient({
  shouldOverrideUrlLoading=function(view,url)
    --Url即将跳转
    if not(url:find("bwcxlg.top")) then
      activity.newActivity("web",{url})
      return true
    end
    --判断加载的链接是http/s还是scheme
    if not(url:find("^https?://"))then
      --给scheme创建一个intent
      local intent=Intent(Intent.ACTION_VIEW,Uri.parse(url))
      --判断有没有对应的应用能打开这个scheme
      if(intent.resolveActivity(activity.getPackageManager())==nil)then
        Toast.makeText(activity,"没有可以用于打开的应用",Toast.LENGTH_SHORT).show()
       else
        activity.startActivity(intent)
      end
      return true
    end
    return false
  end,
  onPageStarted=function(view,url,favicon)
    --网页开始加载
  end,
  onPageFinished=function(view,url)
    --网页加载完成
    page2Web.setVisibility(View.VISIBLE)
    page2Loading.setVisibility(View.GONE)
  end
})

page2Web.setWebChromeClient(luajava.override(WebChromeClient,{
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