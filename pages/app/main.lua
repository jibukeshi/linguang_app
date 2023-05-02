require "import"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.app.*"
import "android.graphics.Typeface"
import "net.fusion64j.core.ui.UiManager"
import "com.google.android.material.card.MaterialCardView"
import "com.google.android.material.button.MaterialButton"
import "androidx.recyclerview.widget.*"
import "com.androlua.LuaRecyclerAdapter"
import "com.bumptech.glide.*"
import "com.caverock.androidsvg.SVGImageView"
import "android.net.Uri"
import "java.io.File"
import "json"

UiManager=activity.UiManager
Colors=UiManager.Colors


--颜色配置
colorAccent=Colors.getColorAccent()--强调色
colorPrimary=Colors.getColorPrimary()--主色
textColorPrimary=Colors.getTextColorPrimary()--主文本色
textColorSecondary=Colors.getTextColorSecondary()--副文本色
windowBackground=Colors.getWindowBackground()--窗体背景色


--获取主页面传递过来的链接
url=...
--服务器配置
server="https://cdn.bwcxlg.top/"


-- @param title 点击的菜单标题
-- @description 顶栏菜单项目点击回调事件
function onMenuItemClick(title)
  switch title
   case "分享应用"
    import "androidx.core.app.ShareCompat"
    ShareCompat.IntentBuilder.from(activity).setText(server..url).setType("text/plain").startChooser()
   case "复制链接"
    import "android.content.Context"
    activity.getSystemService(Context.CLIPBOARD_SERVICE).setText(server..url)
    Toast.makeText(activity,"链接已复制到剪贴板",0).show()
  end
end


layout=--常规框架
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
    id="loading";--设置控件ID
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
      id="progress";--设置控件ID
    };
    {
      TextView;--文本控件
      layout_width="fill";--控件宽度
      layout_height="wrap";--控件高度
      text="获取中……";--显示文字
      textSize="16sp";--文字大小
      textColor=textColorPrimary;--文字颜色
      id="message";--设置控件ID
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
    ScrollView;--纵向滑动控件
    layout_width="fill";--布局宽度
    layout_height="fill";--布局高度
    --verticalScrollBarEnabled=false;--隐藏纵向滑条
    overScrollMode=View.OVER_SCROLL_NEVER,--隐藏圆弧阴影
    id="normal";--设置控件ID
    {
      LinearLayout;--线性控件
      orientation="vertical";--布局方向
      layout_width="fill";--布局宽度
      layout_height="fill";--布局高度
      gravity="center|top";--重力
      --左:left 右:right 中:center 顶:top 底:bottom
      layout_margin="10dp";--控件外边距
      {
        LinearLayout;--线性控件
        orientation="horizontal";--布局方向
        layout_width="fill";--布局宽度
        layout_height="wrap";--布局高度
        gravity="center";--重力
        --左:left 右:right 中:center 顶:top 底:bottom
        {
          MaterialCardView;--卡片控件
          layout_width="100dp";--卡片宽度
          layout_height="100dp";--卡片高度
          cardBackgroundColor=colorPrimary;--卡片颜色
          layout_margin="10dp";--卡片边距
          cardElevation="0dp";--卡片阴影
          radius="5dp";--卡片圆角
          layout_gravity="center";--重力
          --左:left 右:right 中:center 顶:top 底:bottom
          {
            ImageView;--图片控件
            layout_width="fill";--图片宽度
            layout_height="fill";--图片高度
            --src="";--图片路径
            id="icon";--设置控件ID
            --ColorFilter="";--图片着色
            --ColorFilter=Color.BLUE;--设置图片着色
            scaleType="fitXY";--图片拉伸
            layout_gravity="center";--重力
          };
          {
            SVGImageView;--SVG图片控件
            layout_width="fill";--图片宽度
            layout_height="fill";--图片高度
            --src="";--图片路径
            id="svg";--设置控件ID
            --ColorFilter="";--图片着色
            --ColorFilter=Color.BLUE;--设置图片着色
            layout_gravity="center";--重力
          };
        };
        {
          LinearLayout;--线性控件
          orientation="vertical";--布局方向
          layout_width="fill";--布局宽度
          layout_height="wrap";--布局高度
          gravity="center|left";--重力
          --左:left 右:right 中:center 顶:top 底:bottom
          layout_margin="5dp";--控件外边距
          {
            TextView;--文本控件
            layout_width="fill";--控件宽度
            layout_height="wrap";--控件高度
            text="";--显示文字
            textSize="22sp";--文字大小
            textColor=textColorPrimary;--文字颜色
            id="name";--设置控件ID
            --singleLine=true;--设置单行输入
            --ellipsize="end";--多余文字用省略号显示
            --start 开始 middle 中间 end 结尾
            Typeface=Typeface.DEFAULT_BOLD;--字体
            --textIsSelectable=true;--文本可复制
            --style="?android:attr/buttonBarButtonStyle";--点击特效
            gravity="center|left";--重力
            --左:left 右:right 中:center 顶:top 底:bottom
            layout_margin="2dp";--控件外边距
          };
          {
            TextView;--文本控件
            layout_width="fill";--控件宽度
            layout_height="wrap";--控件高度
            text="";--显示文字
            textSize="14sp";--文字大小
            textColor=辅文本色;--文字颜色
            id="version";--设置控件ID
            --singleLine=true;--设置单行输入
            --ellipsize="end";--多余文字用省略号显示
            --start 开始 middle 中间 end 结尾
            --Typeface=Typeface.DEFAULT;--字体
            --textIsSelectable=true;--文本可复制
            --style="?android:attr/buttonBarButtonStyle";--点击特效
            gravity="center|left";--重力
            --左:left 右:right 中:center 顶:top 底:bottom
            layout_margin="2dp";--控件外边距
          };
          {
            MaterialButton;--纽扣控件
            layout_width="wrap";--控件宽度
            layout_height="wrap";--控件高度
            text="下载应用";--显示文字
            textSize="15sp";--文字大小
            textColor=卡片色;--文字颜色
            id="button";--设置控件ID
            backgroundColor=colorAccent;--背景颜色
            gravity="center";--重力
            --左:left 右:right 中:center 顶:top 底:bottom
          };
        };
      };
      {
        MaterialCardView;--卡片控件
        layout_width="fill";--卡片宽度
        layout_height="wrap";--卡片高度
        cardBackgroundColor=colorPrimary;--卡片颜色
        layout_margin="10dp";--卡片边距
        cardElevation="0dp";--卡片阴影
        radius="5dp";--卡片圆角
        layout_gravity="center";--重力
        --左:left 右:right 中:center 顶:top 底:bottom
        id="downloadCard";--设置控件ID
        {
          LinearLayout;--线性控件
          orientation="vertical";--布局方向
          layout_width="fill";--布局宽度
          layout_height="wrap";--布局高度
          gravity="center|left";--重力
          --左:left 右:right 中:center 顶:top 底:bottom
          layout_margin="5dp";--控件外边距
          {
            TextView;--文本控件
            layout_width="fill";--控件宽度
            layout_height="wrap";--控件高度
            text="开始下载";--显示文字
            textSize="14sp";--文字大小
            textColor=辅文本色;--文字颜色
            id="downloadText";--设置控件ID
            --singleLine=true;--设置单行输入
            --ellipsize="end";--多余文字用省略号显示
            --start 开始 middle 中间 end 结尾
            --Typeface=Typeface.DEFAULT;--字体
            --textIsSelectable=true;--文本可复制
            --style="?android:attr/buttonBarButtonStyle";--点击特效
            gravity="center|left";--重力
            --左:left 右:right 中:center 顶:top 底:bottom
            layout_margin="5dp";--控件外边距
          };
          {
            ProgressBar;--进度条控件
            layout_width="fill";--布局宽度
            layout_height="wrap";--布局高度
            --Max="";--设置最大进度
            --Progress="";--设置当前进度
            --SecondaryProgress="";--设置第二进度
            --indeterminate=false;--设置是否为不明确进度进度条,true为明确
            --indeterminate=false;--模糊模式,true为开启
            --style="?android:attr/progressBarStyleLarge";--超大号圆形风格
            --style="?android:attr/progressBarStyleSmall";--小号风格
            --style="?android:attr/progressBarStyleSmallTitle";--标题型风格
            style="?android:attr/progressBarStyleHorizontal";--长形进度条
            id="downloadProgress";--设置控件ID
            layout_margin="5dp";--控件外边距
          };
        };
      };
      {
        MaterialCardView;--卡片控件
        layout_width="fill";--卡片宽度
        layout_height="wrap";--卡片高度
        cardBackgroundColor=colorPrimary;--卡片颜色
        layout_margin="10dp";--卡片边距
        cardElevation="0dp";--卡片阴影
        radius="5dp";--卡片圆角
        layout_gravity="center";--重力
        --左:left 右:right 中:center 顶:top 底:bottom
        {
          ImageView;--图片控件
          layout_width="30dp";--图片宽度
          layout_height="30dp";--图片高度
          src="quote.png";--图片路径
          id="quote";--设置控件ID
          --ColorFilter="";--图片着色
          --ColorFilter=Color.BLUE;--设置图片着色
          scaleType="fitXY";--图片拉伸
          layout_gravity="left|top";--重力
        };
        {
          TextView;--文本控件
          layout_width="fill";--控件宽度
          layout_height="wrap";--控件高度
          text="";--显示文字
          textSize="16sp";--文字大小
          textColor=textColorPrimary;--文字颜色
          id="slogan";--设置控件ID
          --singleLine=true;--设置单行输入
          --ellipsize="end";--多余文字用省略号显示
          --start 开始 middle 中间 end 结尾
          --Typeface=Typeface.DEFAULT;--字体
          --textIsSelectable=true;--文本可复制
          --style="?android:attr/buttonBarButtonStyle";--点击特效
          gravity="center";--重力
          --左:left 右:right 中:center 顶:top 底:bottom
          layout_margin="15dp";--控件外边距
        };
      };
      {
        TextView;--文本控件
        layout_width="fill";--控件宽度
        layout_height="wrap";--控件高度
        text="应用预览";--显示文字
        textSize="18sp";--文字大小
        textColor=textColorPrimary;--文字颜色
        --id="Text";--设置控件ID
        --singleLine=true;--设置单行输入
        --ellipsize="end";--多余文字用省略号显示
        --start 开始 middle 中间 end 结尾
        Typeface=Typeface.DEFAULT_BOLD;--字体
        --textIsSelectable=true;--文本可复制
        --style="?android:attr/buttonBarButtonStyle";--点击特效
        gravity="center|left";--重力
        --左:left 右:right 中:center 顶:top 底:bottom
        layout_margin="10dp";--控件外边距
        layout_marginBottom="5dp";--控件底距
      };
      {
        RecyclerView;
        layout_width="fill";--宽度
        layout_height="wrap";--高度
        id="images";
        --verticalScrollBarEnabled=false;--隐藏滑条
        overScrollMode=View.OVER_SCROLL_NEVER,--隐藏圆弧阴影
      };
      {
        TextView;--文本控件
        layout_width="fill";--控件宽度
        layout_height="wrap";--控件高度
        text="应用介绍";--显示文字
        textSize="18sp";--文字大小
        textColor=textColorPrimary;--文字颜色
        --id="Text";--设置控件ID
        --singleLine=true;--设置单行输入
        --ellipsize="end";--多余文字用省略号显示
        --start 开始 middle 中间 end 结尾
        Typeface=Typeface.DEFAULT_BOLD;--字体
        --textIsSelectable=true;--文本可复制
        --style="?android:attr/buttonBarButtonStyle";--点击特效
        gravity="center|left";--重力
        --左:left 右:right 中:center 顶:top 底:bottom
        layout_margin="10dp";--控件外边距
        layout_marginBottom="0dp";--控件底距
      };
      {
        TextView;--文本控件
        layout_width="fill";--控件宽度
        layout_height="wrap";--控件高度
        text="";--显示文字
        textSize="16sp";--文字大小
        textColor=textColorPrimary;--文字颜色
        id="description";--设置控件ID
        --singleLine=true;--设置单行输入
        --ellipsize="end";--多余文字用省略号显示
        --start 开始 middle 中间 end 结尾
        --Typeface=Typeface.DEFAULT;--字体
        --textIsSelectable=true;--文本可复制
        --style="?android:attr/buttonBarButtonStyle";--点击特效
        gravity="center|left";--重力
        --左:left 右:right 中:center 顶:top 底:bottom
        layout_margin="10dp";--控件外边距
      };
      {
        TextView;--文本控件
        layout_width="fill";--控件宽度
        layout_height="wrap";--控件高度
        text="更新日志";--显示文字
        textSize="18sp";--文字大小
        textColor=textColorPrimary;--文字颜色
        id="updateTitle";--设置控件ID
        --singleLine=true;--设置单行输入
        --ellipsize="end";--多余文字用省略号显示
        --start 开始 middle 中间 end 结尾
        Typeface=Typeface.DEFAULT_BOLD;--字体
        --textIsSelectable=true;--文本可复制
        --style="?android:attr/buttonBarButtonStyle";--点击特效
        gravity="center|left";--重力
        --左:left 右:right 中:center 顶:top 底:bottom
        layout_margin="10dp";--控件外边距
        layout_marginBottom="0dp";--控件底距
      };
      {
        TextView;--文本控件
        layout_width="fill";--控件宽度
        layout_height="wrap";--控件高度
        text="";--显示文字
        textSize="16sp";--文字大小
        textColor=textColorPrimary;--文字颜色
        id="update";--设置控件ID
        --singleLine=true;--设置单行输入
        --ellipsize="end";--多余文字用省略号显示
        --start 开始 middle 中间 end 结尾
        --Typeface=Typeface.DEFAULT;--字体
        --textIsSelectable=true;--文本可复制
        --style="?android:attr/buttonBarButtonStyle";--点击特效
        gravity="center|left";--重力
        --左:left 右:right 中:center 顶:top 底:bottom
        layout_margin="10dp";--控件外边距
      };
      {
        TextView;--文本控件
        layout_width="fill";--控件宽度
        layout_height="wrap";--控件高度
        text="应用信息";--显示文字
        textSize="18sp";--文字大小
        textColor=textColorPrimary;--文字颜色
        --id="Text";--设置控件ID
        --singleLine=true;--设置单行输入
        --ellipsize="end";--多余文字用省略号显示
        --start 开始 middle 中间 end 结尾
        Typeface=Typeface.DEFAULT_BOLD;--字体
        --textIsSelectable=true;--文本可复制
        --style="?android:attr/buttonBarButtonStyle";--点击特效
        gravity="center|left";--重力
        --左:left 右:right 中:center 顶:top 底:bottom
        layout_margin="10dp";--控件外边距
        layout_marginBottom="0dp";--控件底距
      };
      {
        TextView;--文本控件
        layout_width="fill";--控件宽度
        layout_height="wrap";--控件高度
        text="";--显示文字
        textSize="16sp";--文字大小
        textColor=textColorPrimary;--文字颜色
        id="information";--设置控件ID
        --singleLine=true;--设置单行输入
        --ellipsize="end";--多余文字用省略号显示
        --start 开始 middle 中间 end 结尾
        --Typeface=Typeface.DEFAULT;--字体
        --textIsSelectable=true;--文本可复制
        --style="?android:attr/buttonBarButtonStyle";--点击特效
        gravity="center|left";--重力
        --左:left 右:right 中:center 顶:top 底:bottom
        layout_margin="10dp";--控件外边距
      };
      {
        TextView;--文本控件
        layout_width="fill";--控件宽度
        layout_height="wrap";--控件高度
        text="应用权限";--显示文字
        textSize="18sp";--文字大小
        textColor=textColorPrimary;--文字颜色
        --id="Text";--设置控件ID
        --singleLine=true;--设置单行输入
        --ellipsize="end";--多余文字用省略号显示
        --start 开始 middle 中间 end 结尾
        Typeface=Typeface.DEFAULT_BOLD;--字体
        --textIsSelectable=true;--文本可复制
        --style="?android:attr/buttonBarButtonStyle";--点击特效
        gravity="center|left";--重力
        --左:left 右:right 中:center 顶:top 底:bottom
        layout_margin="10dp";--控件外边距
        layout_marginBottom="0dp";--控件底距
      };
      {
        TextView;--文本控件
        layout_width="fill";--控件宽度
        layout_height="wrap";--控件高度
        text="";--显示文字
        textSize="16sp";--文字大小
        textColor=textColorPrimary;--文字颜色
        id="permission";--设置控件ID
        --singleLine=true;--设置单行输入
        --ellipsize="end";--多余文字用省略号显示
        --start 开始 middle 中间 end 结尾
        --Typeface=Typeface.DEFAULT;--字体
        --textIsSelectable=true;--文本可复制
        --style="?android:attr/buttonBarButtonStyle";--点击特效
        gravity="center|left";--重力
        --左:left 右:right 中:center 顶:top 底:bottom
        layout_margin="10dp";--控件外边距
      };
      {
        TextView;--文本控件
        layout_width="fill";--控件宽度
        layout_height="wrap";--控件高度
        text="应用评论";--显示文字
        textSize="18sp";--文字大小
        textColor=textColorPrimary;--文字颜色
        --id="Text";--设置控件ID
        --singleLine=true;--设置单行输入
        --ellipsize="end";--多余文字用省略号显示
        --start 开始 middle 中间 end 结尾
        Typeface=Typeface.DEFAULT_BOLD;--字体
        --textIsSelectable=true;--文本可复制
        --style="?android:attr/buttonBarButtonStyle";--点击特效
        gravity="center|left";--重力
        --左:left 右:right 中:center 顶:top 底:bottom
        layout_margin="10dp";--控件外边距
        layout_marginBottom="0dp";--控件底距
      };
      {
        LuaWebView;--浏览器控件
        layout_width="fill";--浏览器宽度
        layout_height="fill";--浏览器高度
        id="comment";--控件ID
        background=windowBackground;--控件背景
      };
    };
  };
};


UiManager.getFragment(0).view.addView(loadlayout(layout))


normal.setVisibility(View.GONE)
loading.setVisibility(View.VISIBLE)
downloadCard.setVisibility(View.GONE)

Http.get(server..url,nil,"UTF-8",nil,function(code,content,cookie,header)
  xpcall(function()
    normal.setVisibility(View.VISIBLE)
    loading.setVisibility(View.GONE)

    local 换行=[[

]]

    页面标题=content:match("<title>(.-)</title>")
    应用图标=content:match([[<table id="apphead"(.-)</td>]]):match([[<img src="(.-)" style="border]])
    应用名称=content:match("size:23px(.-)</p>"):match([[left:10px;}">(.+)]])
    应用简介=content:match("size:15px(.-)</p>"):match([[left:10px;}">(.+)]])
    --判断有没有更新日志
    xpcall(function()
      更新日志=content:match("本次更新</p>(.-)</p>"):match([[;" >(.+)]]):gsub(换行,""):gsub("<br>","\n")
    end,function(error)
      updateTitle.setVisibility(View.GONE)
      update.setVisibility(View.GONE)
    end)
    应用介绍=content:match("应用介绍</p>(.-)</p>"):match([[;">(.+)]]):gsub(换行,""):gsub("<br>","\n")
    应用信息=content:match("应用信息</p>(.-)</p>"):match([[;" >(.+)]]):gsub(换行,""):gsub("<br>","\n")
    应用权限=content:match("所需权限</p>(.-)</p>"):match([[;" >(.+)]]):gsub(换行,""):gsub("<br>","\n")
    应用版本=content:match("当前版本：(.-)<br>")
    应用大小=content:match("应用大小：(.-)<br>")
    预览图={}
    评分数据={}
    for k in content:match([[<div style="white(.-)</div>]]):gmatch([[<img src="(.-)" style="border]]) do
      table.insert(预览图,{image=server.."apps/"..k})
    end
    for k in content:gmatch([[<div align="center"style="float: left;width:33.3(.-)</div>]]) do
      table.insert(评分数据,k:match("height:80(.-)</p>"):match([[;">(.+)]]))
      table.insert(评分数据,k:match("height:10(.-)</p>"):match([[;">(.+)]]))
    end

    UiManager.toolbar.setTitleText(页面标题)
    --判断应用图标是不是svg
    if(应用图标:find".svg")then
      --如果是svg，判断是否有缓存
      local file=activity.getExternalFilesDir(nil).toString().."/svg/"..应用名称..".svg"
      if(File(file).exists())then
        --如果已经缓存过了，就直接加载
        svg.setImageURI(Uri.fromFile(File(file)))
       else
        --如果没有缓存，就先缓存
        Http.download(server.."apps/"..应用图标,file,function(a)
          --缓存完毕，加载图片
          svg.setImageURI(Uri.fromFile(File(file)))
        end)
      end
     else
      Glide.with(activity).load(server.."apps/"..应用图标).into(icon)
    end
    name.setText(应用名称)
    version.setText(应用版本.."  "..评分数据[3].."  "..评分数据[1])
    button.setText("下载 ("..应用大小..")")
    slogan.setText(应用简介)
    description.setText(应用介绍)
    update.setText(更新日志)
    information.setText(应用信息)
    permission.setText(应用权限)

    local imagesLayout=
    {
      LinearLayout;--线性控件
      orientation="vertical";--布局方向
      layout_width="wrap";--布局宽度
      layout_height="wrap";--布局高度
      {
        MaterialCardView;--卡片控件
        layout_width="wrap";--卡片宽度
        layout_height="wrap";--卡片高度
        layout_margin="5dp";--卡片边距
        cardBackgroundColor=colorPrimary;--卡片颜色
        cardElevation="0dp";--卡片阴影
        radius="5dp";--卡片圆角
        id="card";--设置控件ID
        {
          ImageView;--图片控件
          layout_width="wrap";--图片宽度
          layout_height="200dp";--图片高度
          --src="";--图片路径
          id="image";--设置控件ID
          --ColorFilter="";--图片着色
          --ColorFilter=Color.BLUE;--设置图片着色
          scaleType="fitCenter";--图片拉伸
          layout_gravity="center";--重力
        };
      };
    };

    imagesAdp=LuaRecyclerAdapter(activity,预览图,imagesLayout).setClickViewId("card")
    images.setLayoutManager(LinearLayoutManager(activity,LinearLayoutManager.HORIZONTAL,false))
    images.setAdapter(imagesAdp)
    imagesAdp.onItemClick=function(adapter,itemView,view,pos)
      local 应用图片={}
      for k in content:match([[<div style="white(.-)</div>]]):gmatch([[<img src="(.-)" style="border]]) do
        table.insert(应用图片,server.."apps/"..k)
      end
      table.insert(应用图片,{page=pos+1})
      activity.startFusionActivity("images",Bundle().putString("key",json.encode(应用图片)))
    end

    下载链接=server..content:match("'/(.-)'")
    下载目录=activity.getSharedData("下载目录")
    if(下载目录:find("/sdcard"))then
      下载目录2=下载目录:match("/sdcard(.+)")
     elseif(下载目录:find("/storage/emulated/0"))then
      下载目录2=下载目录:match("/storage/emulated/0(.+)")
     else
      下载目录2=下载目录
    end
    下载文件=content:match("'/(.-)'"):match(".+/(.+)$")

    button.onClick=function()
      下载监听(下载链接,下载目录2,下载文件)
      downloadCard.setVisibility(View.VISIBLE)
      button.setText("下载中")
      button.onClick=function() end
    end

    if(File(下载目录..下载文件).exists())then
      button.setText("立即安装")
      button.onClick=function()
        安装应用(下载目录..下载文件)
      end
    end

  end,function(e)
    progress.setVisibility(View.GONE)
    message.setText("获取失败 ("..code..")")
  end)
end)


--应用评论
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
comment.loadDataWithBaseURL(server..url,html,"text/html","UTF-8",nil)
comment.removeView(comment.getChildAt(0))
comment.setWebViewClient({
  shouldOverrideUrlLoading=function(view,url)
    --Url即将跳转
    activity.newActivity("web",{url})
    return true
  end,
  onPageStarted=function(view,url,favicon)
    --网页开始加载
  end,
  onPageFinished=function(view,url)
    --网页加载完成
  end
})


function 下载监听(url,path,filename)
  import "android.content.Context"
  import "android.net.Uri"
  import "android.service.voice.VoiceInteractionSession$Request"
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
  local ti=Ticker()
  ti.Period=10--刷新频率
  ti.onTick=function()
    local cursor = downloadManager.query(query)
    if(not cursor.moveToFirst())then
      cursor.close()
      return
    end
    local id=cursor.getLong(cursor.getColumnIndex(DownloadManager.COLUMN_ID))--下载id
    local status=cursor.getInt(cursor.getColumnIndex(DownloadManager.COLUMN_STATUS))--下载请求的状态
    local totalSize=cursor.getLong(cursor.getColumnIndex(DownloadManager.COLUMN_TOTAL_SIZE_BYTES))--下载文件的总字节大小
    local downloadedSoFar=cursor.getLong(cursor.getColumnIndex(DownloadManager.COLUMN_BYTES_DOWNLOADED_SO_FAR))--已下载的字节大小
    local fileName=cursor.getLong(cursor.getColumnIndex(DownloadManager.COLUMN_LOCAL_FILENAME))--文件名 string类型
    local fileUri=cursor.getLong(cursor.getColumnIndex(DownloadManager.COLUMN_LOCAL_URI))--下载链接 string类型
    local title=cursor.getLong(cursor.getColumnIndex(DownloadManager.COLUMN_TITLE))--下载标题 string类型
    local function 转换(a)
      if(a>=1024*1024 and a<=(1024*1024*1024)-1)then
        s=(a/1024)/1024
        s=string.format('%.2f', s).."MB"
       elseif(a>=1024 and a<=(1024*1024)-1)then
        s=a/1024
        s=string.format('%.2f', s).."KB"
       elseif(a<=1023)then
        s=string.format('%.2f', a).."K"
       elseif(a>=1024*1024*1024)then
        s=a/(1024*1024*1024)
        s=string.format('%.2f', s).."GB"
      end
      return s
    end
    if(downloadId and downloadId==id and totalSize and totalSize>0)then
      switch status
        --下载暂停
       case DownloadManager.STATUS_PAUSED
        local reason=cursor.getInt(cursor.getColumnIndex(DownloadManager.COLUMN_REASON))
        switch reason
         case DownloadManager.PAUSED_QUEUED_FOR_WIFI
          reasonName="等待WiFi"
         case DownloadManager.PAUSED_WAITING_FOR_NETWORK
          reasonName="等待连接"
         case DownloadManager.PAUSED_WAITING_TO_RETRY
          reasonName="由于重重原因导致下载暂停，等待重试"
         case DownloadManager.PAUSED_UNKNOWN
          reasonName="未知问题Unknown"
        end
        downloadText.setText("下载暂停，"..reasonName)
        --正在下载
       case DownloadManager.STATUS_RUNNING
        downloadText.setText("已下载"..转换(downloadedSoFar).."，共"..转换(totalSize).."，"..string.format('%.2f',(downloadedSoFar/totalSize*100)).."%")
        downloadProgress.setProgress(tointeger(downloadedSoFar/totalSize*100))
        --下载完成
       case DownloadManager.STATUS_SUCCESSFUL
        downloadText.setText("下载完成")
        downloadProgress.setProgress(100)
        if(activity.getSharedData("自动安装"))then
          安装应用("/sdcard"..path..filename)
        end
        button.setText("立即安装")
        button.onClick=function()
          安装应用("/sdcard"..path..filename)
        end
        cursor.close()
        ti.stop()
        --下载失败
       case DownloadManager.STATUS_FAILED
        local reason=cursor.getInt(cursor.getColumnIndex(DownloadManager.COLUMN_REASON))
        switch reason
         case DownloadManager.ERROR_CANNOT_RESUME
          reasonName="不能够继续，由于一些其他原因"
         case DownloadManager.ERROR_DEVICE_NOT_FOUND
          reasonName="外部存储设备没有找到"
         case DownloadManager.ERROR_FILE_ALREADY_EXISTS
          reasonName="要下载的文件已经存在了，要想重新下载需要删除原来的文件"
         case DownloadManager.ERROR_FILE_ERROR
          reasonName="可能由于SD卡原因导致了文件错误"
         case DownloadManager.ERROR_HTTP_DATA_ERROR
          reasonName="在Http传输过程中出现了问题。"
         case DownloadManager.ERROR_INSUFFICIENT_SPACE
          reasonName="由于SD卡空间不足造成的。"
         case DownloadManager.ERROR_TOO_MANY_REDIRECTS
          reasonName="这个Http有太多的重定向，导致无法正常下载"
         case DownloadManager.ERROR_UNHANDLED_HTTP_CODE
          reasonName="无法获取http出错的原因，比如说远程服务器没有响应"
         case DownloadManager.ERROR_UNKNOWN
          reasonName="未知问题Unknown"
        end
        downloadText.setText("下载失败，"..reasonName)
        cursor.close()
        ti.stop()
      end
    end
  end
  ti.start()
end

function 安装应用(path)
  --检查储存和安装应用权限
  if(activity.getPackageManager().canRequestPackageInstalls() and activity.checkSelfPermission("android.permission.READ_EXTERNAL_STORAGE")==0)then
    --如果有权限就安装
    import "android.content.Intent"
    import "android.content.FileProvider"
    local intent=Intent("android.intent.action.VIEW").addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
    local uri=FileProvider.getUriForFile(activity,activity.getPackageName()..".FileProvider",File(path))
    intent.setDataAndType(uri,"application/vnd.android.package-archive")
    activity.startActivity(intent)
   else
    --如果没有权限就申请
    Toast.makeText(activity,"需要给予安装与存储读取权限",0).show()
    import "android.content.Intent"
    import "android.provider.Settings"
    import "android.net.Uri"
    activity.startActivity(Intent(Settings.ACTION_MANAGE_UNKNOWN_APP_SOURCES,Uri.parse("package:"..activity.getPackageName())))
    activity.requestPermissions({"android.permission.READ_EXTERNAL_STORAGE","android.permission.WRITE_EXTERNAL_STORAGE"},1)
  end
end