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


--获取主页面传递过来的链接和主站域名
serverUrl,url=...


-- @param title 点击的菜单标题
-- @description 顶栏菜单项目点击回调事件
function onMenuItemClick(title)
  switch title
   case "分享应用"
    import "androidx.core.app.ShareCompat"
    ShareCompat.IntentBuilder.from(activity).setText(serverUrl..url).setType("text/plain").startChooser()
   case "复制链接"
    import "android.content.Context"
    activity.getSystemService(Context.CLIPBOARD_SERVICE).setText(serverUrl..url)
    Toast.makeText(activity,"链接已复制到剪贴板",Toast.LENGTH_SHORT).show()
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


function Get()
  --开始获取
  normal.setVisibility(View.GONE)
  loading.setVisibility(View.VISIBLE)
  downloadCard.setVisibility(View.GONE)
  progress.setVisibility(View.VISIBLE)
  message.setText("获取中……").onClick=function()end
  Http.get(serverUrl..url,nil,"UTF-8",nil,function(code,content,cookie,header)
    if(code==200 and content)then
      --获取成功

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
        table.insert(预览图,{image=serverUrl.."apps/"..k})
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
          Http.download(serverUrl.."apps/"..应用图标,file,function(a)
            --缓存完毕，加载图片
            svg.setImageURI(Uri.fromFile(File(file)))
          end)
        end
       else
        Glide.with(activity).load(serverUrl.."apps/"..应用图标).into(icon)
      end
      name.setText(应用名称)
      version.setText(应用版本.."  "..评分数据[3].."  "..评分数据[1])
      button.setText("下载 ("..应用大小..")")
      slogan.setText(应用简介)
      description.setText(应用介绍)
      update.setText(更新日志)
      information.setText(应用信息)
      permission.setText(应用权限)

      imagesAdp=LuaRecyclerAdapter(activity,预览图,imagesLayout).setClickViewId("card")
      images.setLayoutManager(LinearLayoutManager(activity,LinearLayoutManager.HORIZONTAL,false))
      images.setAdapter(imagesAdp)
      imagesAdp.onItemClick=function(adapter,itemView,view,pos)
        local 应用图片={}
        for k in content:match([[<div style="white(.-)</div>]]):gmatch([[<img src="(.-)" style="border]]) do
          table.insert(应用图片,serverUrl.."apps/"..k)
        end
        table.insert(应用图片,{page=pos+1})
        activity.startFusionActivity("images",Bundle().putString("key",json.encode(应用图片)))
      end

      下载链接=serverUrl..content:match("'/(.-)'")
      下载目录=activity.getSharedData("downloadPath")
      下载文件=content:match("'/(.-)'"):match(".+/(.+)$")

      button.onClick=function()
        download(下载链接,下载目录,下载文件)
        downloadCard.setVisibility(View.VISIBLE)
        button.setText("下载中")
        button.onClick=function() end
      end

      if(File(下载目录..下载文件).exists())then
        button.setText("立即安装")
        button.onClick=function()
          install(下载目录..下载文件)
        end
      end

     else
      --获取失败
      progress.setVisibility(View.GONE)
      message.setText("获取失败 ("..code..")").onClick=function()
        Get()
      end
    end
  end)
end

Get()


import "comment"--应用评论
import "download"--下载与安装