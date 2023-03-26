require "import"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.app.*"
import "android.content.Context"
import "android.graphics.Typeface"
import "net.fusion64j.core.ui.UiManager"
import "net.fusion64j.core.util.FusionUtil"
import "com.google.android.material.card.MaterialCardView"
import "androidx.core.widget.NestedScrollView"
import "androidx.viewpager.widget.ViewPager"
import "androidx.recyclerview.widget.*"
import "com.androlua.LuaRecyclerAdapter"
import "com.bumptech.glide.*"
import "com.caverock.androidsvg.SVGImageView"
import "android.content.Intent"
import "android.net.Uri"
import "java.io.File"
import "java.util.ArrayList"
import "net.fusion64j.core.ui.adapter.BasePagerAdapter"
import "json"
import "update"--检查更新模块

UiManager=activity.UiManager
Colors=UiManager.Colors


--颜色配置
强调色=Colors.getColorAccent()
主色=Colors.getColorPrimary()
主文本色=Colors.getTextColorPrimary()
副文本色=Colors.getTextColorSecondary()
窗体背景色=Colors.getWindowBackground()


--服务器域名
server="https://linguang.top/"


--初始化设置
if(activity.getSharedData("自动更新")==nil)then
  activity.setSharedData("自动更新",true)
end
if(activity.getSharedData("自动安装")==nil)then
  activity.setSharedData("自动安装",true)
end
if(activity.getSharedData("下载目录")==nil)then
  activity.setSharedData("下载目录","/sdcard/Download/")
end
if(activity.getSharedData("图片下载目录")==nil)then
  activity.setSharedData("图片下载目录","/sdcard/Pictures/")
end


--深色模式
local androidR=luajava.bindClass "android.R"
local systemDarkMode=activity.getSystemService(Context.UI_MODE_SERVICE).getNightMode()==UiModeManager.MODE_NIGHT_YES
if systemDarkMode~=UiManager.getThemeConfig().isNightMode()
  if systemDarkMode newThemeName="Night.json" else newThemeName="Default_Light.json" end
  activity.getLoader().updatePageConfig()
  FusionUtil.changeTheme(activity.getLoader().getProjectDir().getAbsolutePath(),newThemeName)
  FusionUtil.setNightMode(systemDarkMode)
  activity.finish()
  activity.newActivity(activity.getLoader().getPageName())
  activity.overridePendingTransition(androidR.anim.fade_in,androidR.anim.fade_out)
end


-- @param data 侧滑栏列表的全部数据
-- @param recyclerView 侧滑栏列表控件
-- @param listIndex 点击的列表索引（点击的是第几个列表）
-- @param clickIndex 点击的项目索引（点击的第几个项目）
function onDrawerListItemClick(data,recyclerView,listIndex,itemIndex)
  --侧滑栏列表的数据是二维结构，所以需要先获取到点击项目所在列表的数据
  local listData = data.get(listIndex);
  --获取到所在列表的数据后获取点击项目的数据
  local itemData = listData.get(itemIndex);
  --最后获取到点击的项目的标题
  local itemTitle = itemData.getTitle();
  switch itemTitle
   case "首页"
    UiManager.viewPager.setCurrentItem(0)
    UiManager.drawerLayout.closeDrawer(3)
   case "社区"
    UiManager.viewPager.setCurrentItem(1)
    UiManager.drawerLayout.closeDrawer(3)
   case "我的"
    UiManager.viewPager.setCurrentItem(2)
    UiManager.drawerLayout.closeDrawer(3)
   case "应用提单"
    进入子页面("web",{"https://jinshuju.net/f/vcoCgZ"})
   case "下载管理"
    进入子页面("download")
   case "设置"
    进入子页面("settings")
  end
end

-- @param title 点击的菜单标题
-- @description 顶栏菜单项目点击回调事件
function onMenuItemClick(title)
  switch title
   case "搜索"
    进入子页面("search")
  end
end


--第一页布局
page1Layout=--常规框架
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
    id="page1Loading";--设置控件ID
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
      id="page1Progress";--设置控件ID
    };
    {
      TextView;--文本控件
      layout_width="fill";--控件宽度
      layout_height="wrap";--控件高度
      text="获取中……";--显示文字
      textSize="16sp";--文字大小
      textColor=主文本色;--文字颜色
      id="page1Message";--设置控件ID
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
    NestedScrollView;--纵向滑动控件
    layout_width="fill";--布局宽度
    layout_height="fill";--布局高度
    verticalScrollBarEnabled=false;--隐藏纵向滑条
    overScrollMode=View.OVER_SCROLL_NEVER,--隐藏圆弧阴影
    id="page1Normal";--设置控件ID
    {
      LinearLayout;--线性控件
      orientation="vertical";--布局方向
      layout_width="fill";--布局宽度
      layout_height="fill";--布局高度
      gravity="center|top";--重力
      --左:left 右:right 中:center 顶:top 底:bottom
      layout_margin="10dp";--控件外边距
      {
        ViewPager;--滑动视图
        layout_width="fill";--布局宽度
        layout_height="165dp";--布局高度
        id="page1Images";--设置控件ID
        layout_margin="10dp";--控件外边距
      };
      {
        RecyclerView;
        layout_width="fill";--宽度
        layout_height="fill";--高度
        id="page1Recycler";
        verticalScrollBarEnabled=false;--隐藏滑条
        overScrollMode=View.OVER_SCROLL_NEVER,--隐藏圆弧阴影
      };
    };
  };
};

--添加第一页布局
UiManager.getFragment(0).view.addView(loadlayout(page1Layout))


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
      textColor=主文本色;--文字颜色
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
    background=窗体背景色;--控件背景
  };
};

--添加第二页布局
UiManager.getFragment(1).view.addView(loadlayout(page2Layout))


--第三页布局
page3Layout=--常规框架
{
  NestedScrollView;--纵向滑动控件
  layout_width="fill";--布局宽度
  layout_height="fill";--布局高度
  --verticalScrollBarEnabled=false;--隐藏纵向滑条
  --overScrollMode=View.OVER_SCROLL_NEVER,--隐藏圆弧阴影
  {
    LinearLayout;--线性控件
    orientation="vertical";--布局方向
    layout_width="fill";--布局宽度
    layout_height="fill";--布局高度
    layout_margin="10dp";--控件外边距
    {
      MaterialCardView;--卡片控件
      layout_width="fill";--卡片宽度
      layout_height="wrap";--卡片高度
      cardBackgroundColor=主色;--卡片颜色
      layout_margin="10dp";--卡片边距
      cardElevation="0dp";--卡片阴影
      radius="5dp";--卡片圆角
      {
        LinearLayout;--线性控件
        orientation="horizontal";--布局方向
        layout_width="fill";--布局宽度
        layout_height="fill";--布局高度
        gravity="center";--控件内容的重力方向
        --左:left 右:right 中:center 顶:top 底:bottom
        layout_margin="10dp";--控件外边距
        {
          ImageView;--图片控件
          layout_width="80dp";--图片宽度
          layout_height="80dp";--图片高度
          src="../icon.png";--图片路径
          --id="Image";--设置控件ID
          --ColorFilter="";--图片着色
          --ColorFilter=Color.BLUE;--设置图片着色
          scaleType="fitXY";--图片拉伸
          layout_gravity="center";--重力
        };
        {
          LinearLayout;--线性控件
          orientation="vertical";--布局方向
          layout_width="fill";--布局宽度
          layout_height="fill";--布局高度
          gravity="center";--控件内容的重力方向
          --左:left 右:right 中:center 顶:top 底:bottom
          {
            TextView;--文本控件
            layout_width="fill";--控件宽度
            layout_height="wrap";--控件高度
            text="粼光应用商店";--显示文字
            textSize="20sp";--文字大小
            textColor=主文本色;--文字颜色
            --id="Text";--设置控件ID
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
            text="优雅有质量";--显示文字
            textSize="14sp";--文字大小
            textColor=副文本色;--文字颜色
            --id="Text";--设置控件ID
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
            TextView;--文本控件
            layout_width="fill";--控件宽度
            layout_height="wrap";--控件高度
            text="当前版本："..versionName.."("..versionCode..")";--显示文字
            textSize="14sp";--文字大小
            textColor=副文本色;--文字颜色
            --id="Text";--设置控件ID
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
        };
      };
    };
    {
      LinearLayout;--线性控件
      orientation="horizontal";--布局方向
      layout_width="fill";--布局宽度
      layout_height="wrap";--布局高度
      gravity="center";--控件内容的重力方向
      --左:left 右:right 中:center 顶:top 底:bottom
      {
        MaterialCardView;--卡片控件
        layout_width="43%w";--卡片宽度
        layout_height="wrap";--卡片高度
        cardBackgroundColor=主色;--卡片颜色
        layout_margin="10dp";--卡片边距
        cardElevation="0dp";--卡片阴影
        radius="5dp";--卡片圆角
        id="page3Upload";--设置控件ID
        {
          LinearLayout;--线性控件
          orientation="vertical";--布局方向
          layout_width="fill";--布局宽度
          layout_height="fill";--布局高度
          gravity="center|left";--控件内容的重力方向
          --左:left 右:right 中:center 顶:top 底:bottom
          layout_margin="10dp";--控件外边距
          {
            ImageView;--图片控件
            layout_width="35dp";--图片宽度
            layout_height="35dp";--图片高度
            src="cloud_done";--图片路径
            --id="Image";--设置控件ID
            ColorFilter=副文本色;--图片着色
            --ColorFilter=Color.BLUE;--设置图片着色
            --scaleType="fitXY";--图片拉伸
            layout_margin="2dp";--控件外边距
          };
          {
            TextView;--文本控件
            layout_width="wrap";--控件宽度
            layout_height="wrap";--控件高度
            text="应用提单";--显示文字
            textSize="18sp";--文字大小
            textColor=主文本色;--文字颜色
            --id="Text";--设置控件ID
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
            TextView;--文本控件
            layout_width="wrap";--控件宽度
            layout_height="wrap";--控件高度
            text="上传/更新应用";--显示文字
            textSize="12sp";--文字大小
            textColor=副文本色;--文字颜色
            --id="Text";--设置控件ID
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
        };
      };
      {
        MaterialCardView;--卡片控件
        layout_width="43%w";--卡片宽度
        layout_height="wrap";--卡片高度
        cardBackgroundColor=主色;--卡片颜色
        layout_margin="10dp";--卡片边距
        cardElevation="0dp";--卡片阴影
        radius="5dp";--卡片圆角
        id="page3Download";--设置控件ID
        {
          LinearLayout;--线性控件
          orientation="vertical";--布局方向
          layout_width="fill";--布局宽度
          layout_height="fill";--布局高度
          gravity="center|left";--控件内容的重力方向
          --左:left 右:right 中:center 顶:top 底:bottom
          layout_margin="10dp";--控件外边距
          {
            ImageView;--图片控件
            layout_width="35dp";--图片宽度
            layout_height="35dp";--图片高度
            src="file_download";--图片路径
            --id="Image";--设置控件ID
            ColorFilter=副文本色;--图片着色
            --ColorFilter=Color.BLUE;--设置图片着色
            --scaleType="fitXY";--图片拉伸
            layout_margin="2dp";--控件外边距
          };
          {
            TextView;--文本控件
            layout_width="wrap";--控件宽度
            layout_height="wrap";--控件高度
            text="下载管理";--显示文字
            textSize="18sp";--文字大小
            textColor=主文本色;--文字颜色
            --id="Text";--设置控件ID
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
            TextView;--文本控件
            layout_width="wrap";--控件宽度
            layout_height="wrap";--控件高度
            text="查看已下载的应用";--显示文字
            textSize="12sp";--文字大小
            textColor=副文本色;--文字颜色
            --id="Text";--设置控件ID
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
        };
      };
    };
    {
      MaterialCardView;--卡片控件
      layout_width="fill";--卡片宽度
      layout_height="wrap";--卡片高度
      cardBackgroundColor=主色;--卡片颜色
      layout_margin="10dp";--卡片边距
      cardElevation="0dp";--卡片阴影
      radius="5dp";--卡片圆角
      layout_gravity="center";--重力
      --左:left 右:right 中:center 顶:top 底:bottom
      {
        RecyclerView;
        layout_width="fill";--宽度
        layout_height="fill";--高度
        id="page3Recycler1";
        verticalScrollBarEnabled=false;--隐藏滑条
        overScrollMode=View.OVER_SCROLL_NEVER,--隐藏圆弧阴影
      };
    };
    {
      MaterialCardView;--卡片控件
      layout_width="fill";--卡片宽度
      layout_height="wrap";--卡片高度
      cardBackgroundColor=主色;--卡片颜色
      layout_margin="10dp";--卡片边距
      cardElevation="0dp";--卡片阴影
      radius="5dp";--卡片圆角
      layout_gravity="center";--重力
      --左:left 右:right 中:center 顶:top 底:bottom
      {
        RecyclerView;
        layout_width="fill";--宽度
        layout_height="fill";--高度
        id="page3Recycler2";
        verticalScrollBarEnabled=false;--隐藏滑条
        overScrollMode=View.OVER_SCROLL_NEVER,--隐藏圆弧阴影
      };
    };
  };
};

--添加第三页布局
UiManager.getFragment(2).view.addView(loadlayout(page3Layout))


local page1Group=
{
  LinearLayout;--线性控件
  orientation="vertical";--布局方向
  layout_width="fill";--布局宽度
  layout_height="wrap";--布局高度
  gravity="center";--重力
  --左:left 右:right 中:center 顶:top 底:bottom
  {
    TextView;--文本控件
    layout_width="fill";--控件宽度
    layout_height="wrap";--控件高度
    text="";--显示文字
    textSize="18sp";--文字大小
    textColor=主文本色;--文字颜色
    id="title";--设置控件ID
    --singleLine=true;--设置单行输入
    --ellipsize="end";--多余文字用省略号显示
    --start 开始 middle 中间 end 结尾
    Typeface=Typeface.DEFAULT_BOLD;--字体
    --textIsSelectable=true;--文本可复制
    --style="?android:attr/buttonBarButtonStyle";--点击特效
    gravity="center|left";--重力
    --左:left 右:right 中:center 顶:top 底:bottom
    layout_marginLeft="7.5dp";--控件左距
  };
  {
    MaterialCardView;--卡片控件
    layout_width="fill";--卡片宽度
    layout_height="wrap";--卡片高度
    cardBackgroundColor=主色;--卡片颜色
    layout_margin="10dp";--卡片边距
    cardElevation="0dp";--卡片阴影
    radius="10dp";--卡片圆角
    layout_gravity="center";--重力
    --左:left 右:right 中:center 顶:top 底:bottom
    {
      RecyclerView;
      layout_width="fill";--宽度
      layout_height="wrap";--高度
      id="recycler";
      verticalScrollBarEnabled=false;--隐藏滑条
      overScrollMode=View.OVER_SCROLL_NEVER,--隐藏圆弧阴影
    };
  };
};

local page1App=
{
  MaterialCardView;--卡片控件
  layout_width="fill";--卡片宽度
  layout_height="wrap";--卡片高度
  cardBackgroundColor=主色;--卡片颜色
  cardElevation="0dp";--卡片阴影
  radius="5dp";--卡片圆角
  id="card";--设置控件ID
  {
    LinearLayout;--线性控件
    orientation="vertical";--布局方向
    layout_width="fill";--布局宽度
    layout_height="wrap";--布局高度
    padding="7.5dp";--控件内边距
    gravity="center|top";--重力
    --左:left 右:right 中:center 顶:top 底:bottom
    {
      MaterialCardView;--卡片控件
      layout_width="60dp";--卡片宽度
      layout_height="60dp";--卡片高度
      cardBackgroundColor=主色;--卡片颜色
      layout_margin="5dp";--卡片边距
      cardElevation="2dp";--卡片阴影
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
      TextView;--文本控件
      layout_width="fill";--控件宽度
      layout_height="wrap";--控件高度
      text="";--显示文字
      textSize="14sp";--文字大小
      textColor=主文本色;--文字颜色
      id="name";--设置控件ID
      --singleLine=true;--设置单行输入
      --ellipsize="end";--多余文字用省略号显示
      --start 开始 middle 中间 end 结尾
      --Typeface=Typeface.DEFAULT;--字体
      --textIsSelectable=true;--文本可复制
      --style="?android:attr/buttonBarButtonStyle";--点击特效
      gravity="center";--重力
      --左:left 右:right 中:center 顶:top 底:bottom
      layout_margin="2dp";--控件外边距
    };
  };
};

--加载布局
page1Normal.setVisibility(View.GONE)
page1Images.setVisibility(View.GONE)
page1Loading.setVisibility(View.VISIBLE)


--获取首页应用列表
Http.get(server.."index.json",nil,"UTF-8",nil,function(code,content,cookie,header)
  if(code==200 and content)then
    --获取成功
    xpcall(function()
      page1Normal.setVisibility(View.VISIBLE)
      page1Loading.setVisibility(View.GONE)
      --解析json
      local jsontext=json.decode(content)
      --首页分类的适配器
      local page1Adp=LuaRecyclerAdapter(activity,jsontext.apps,page1Group).setAdapterInterface({
        onBindViewHolder=function(holder,position)
          local view=holder.tag--获取组的view
          local info=jsontext.apps[position+1]--获取组的信息
          view.title.setText(info.name)
          --首页每个应用的适配器
          local adp=LuaRecyclerAdapter(activity,info.items,page1App).setAdapterInterface({
            onBindViewHolder=function(holder2,position2)
              local view2=holder2.tag--获取应用的view
              local info2=jsontext.apps[position+1].items[position2+1]--获取应用的信息
              view2.name.setText(info2.name)
              --判断应用图标是不是svg
              if(info2.img:find".svg")then
                --如果是svg，判断是否有缓存
                local file=activity.getExternalFilesDir(nil).toString().."/svg/"..info2.name..".svg"
                if(File(file).exists())then
                  --如果已经缓存过了，就直接加载
                  view2.svg.setImageURI(Uri.fromFile(File(file)))
                 else
                  --如果没有缓存，就先缓存
                  Http.download(server..info2.img,file,function(a)
                    --缓存完毕，加载图片
                    view2.svg.setImageURI(Uri.fromFile(File(file)))
                  end)
                end
               else
                --如果不是svg就直接用Glide加载
                Glide.with(activity).load(server..info2.img).into(view2.icon)
              end
              view2.card.onClick=function()
                进入子页面("app",{info2.url})
              end
            end
          })
          view.recycler.setLayoutManager(GridLayoutManager(activity,4))
          view.recycler.setAdapter(adp)
        end
      })
      page1Recycler.setLayoutManager(LinearLayoutManager(activity))
      page1Recycler.setAdapter(page1Adp)
    end,function(error)end)
   else
    --获取失败
    page1Progress.setVisibility(View.GONE)
    page1Message.setText("获取失败 ("..code..")")
  end
end)


--获取首页轮播图
Http.get(server.."index.html",nil,"UTF-8",nil,function(code,content,cookie,header)
  if(code==200 and content)then
    --获取成功
    xpcall(function()
      page1Images.setVisibility(View.VISIBLE)
      local list=ArrayList()
      for k in content:match([[轮播图 感谢学神之女(.-)轮播的内容可以是图片]]):gmatch("<img(.-)>") do
        local image=k:match([[src="(.-)"]])--获取图片链接
        local url=k:match("'(.-)'")--获取跳转链接
        --如果图片链接没有域名就加上
        if(image and not(image:find("://")))then
          image=server..image
        end
        --如果跳转链接没有域名就加上
        if(url and not(url:find("://")))then
          url=server..url
        end
        local imageLayout=
        {
          MaterialCardView;--卡片控件
          layout_width="fill";--卡片宽度
          layout_height="wrap";--卡片高度
          cardBackgroundColor=主色;--卡片颜色
          cardElevation="0dp";--卡片阴影
          radius="5dp";--卡片圆角
          onClick=function()
            if(url)then
              进入子页面("web",{url})
            end
          end;
          {
            ImageView;--图片控件
            layout_width="fill";--图片宽度
            layout_height="wrap";--图片高度
            src=image;--图片路径
            --id="Image";--设置控件ID
            --ColorFilter="";--图片着色
            --ColorFilter=Color.BLUE;--设置图片着色
            scaleType="fitCenter";--图片拉伸
            layout_gravity="center";--重力
          };
        };
        list.add(loadlayout(imageLayout))
      end
      local adp=BasePagerAdapter(list)
      page1Images.setAdapter(adp)
      --自动轮播
      local ti=Ticker()
      ti.Period=5000
      ti.onTick=function()
        if page1Images.getCurrentItem()==adp.getCount()-1 then
          --如果已经是最后一张了就显示第一张
          page1Images.setCurrentItem(0,true)
         else
          --否则就显示下一张
          page1Images.setCurrentItem(page1Images.getCurrentItem()+1,true)
        end
      end
      ti.start()
    end,function(error)end)
   else
    --获取失败
    弹出消息("轮播图获取失败("..code..")")
  end
end)


--论坛
page2Web.loadUrl("https://bwcxlg.top/")
page2Web.removeView(page2Web.getChildAt(0))--去除进度条
page2Web.setVisibility(View.INVISIBLE)--将WebView设置为隐藏，能看见下面的加载进度条
page2Loading.setVisibility(View.VISIBLE)
page2Web.setWebViewClient({
  shouldOverrideUrlLoading=function(view,url)
    --Url即将跳转
    if not(url:find("bwcxlg.top")) then
      进入子页面("web",{url})
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


local page3Item=
{
  MaterialCardView;--卡片控件
  layout_width="fill";--卡片宽度
  layout_height="wrap";--卡片高度
  cardBackgroundColor=主色;--卡片颜色
  cardElevation="0dp";--卡片阴影
  radius="5dp";--卡片圆角
  id="card";--设置控件ID
  {
    LinearLayout;--线性控件
    orientation="horizontal";--布局方向
    layout_width="fill";--布局宽度
    layout_height="fill";--布局高度
    gravity="center";--控件内容的重力方向
    --左:left 右:right 中:center 顶:top 底:bottom
    layout_margin="5dp";--控件外边距
    layout_marginLeft="10dp";--控件左距
    layout_marginRight="10dp";--控件右距
    {
      ImageView;--图片控件
      layout_width="30dp";--图片宽度
      layout_height="30dp";--图片高度
      --src="";--图片路径
      id="icon";--设置控件ID
      ColorFilter=副文本色;--图片着色
      --ColorFilter=Color.BLUE;--设置图片着色
      --scaleType="fitXY";--图片拉伸
      layout_margin="5dp";--控件外边距
      padding="2dp";--控件内边距
    };
    {
      TextView;--文本控件
      layout_width="fill";--控件宽度
      layout_height="wrap";--控件高度
      text="";--显示文字
      textSize="16sp";--文字大小
      textColor=主文本色;--文字颜色
      id="title";--设置控件ID
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
  };
};

page3Data1={
  {icon=activity.loader.getImagePath("QQ.png"),title="QQ官方一群",click=function()
      xpcall(function()
        local url="mqqapi://card/show_pslcard?card_type=group&uin=424033580"
        activity.startActivity(Intent(Intent.ACTION_VIEW,Uri.parse(url)))
      end,function(e)
        弹出消息("打开QQ失败，请确认是否已安装QQ/TIM")
      end)
    end},
  {icon=activity.loader.getImagePath("QQ.png"),title="QQ官方二群",click=function()
      xpcall(function()
        local url="mqqapi://card/show_pslcard?card_type=group&uin=452547525"
        activity.startActivity(Intent(Intent.ACTION_VIEW,Uri.parse(url)))
      end,function(e)
        弹出消息("打开QQ失败，请确认是否已安装QQ/TIM")
      end)
    end},
  {icon=activity.loader.getImagePath("qqpindao.png"),title="QQ频道",click=function()
      进入子页面("web",{"https://pd.qq.com/s/avu5s08ka"})
    end},
  {icon=activity.loader.getImagePath("commercial.png"),title="Telegram频道",click=function()
      xpcall(function()
        local url="tg://resolve?domain=linguang_a"
        activity.startActivity(Intent(Intent.ACTION_VIEW,Uri.parse(url)))
      end,function(e)
        弹出消息("打开Telegram失败，请确认是否已安装Telegram")
      end)
    end},
  {icon=activity.loader.getImagePath("telegram.png"),title="Telegram群组",click=function()
      xpcall(function()
        local url="tg://resolve?domain=lgtg_1"
        activity.startActivity(Intent(Intent.ACTION_VIEW,Uri.parse(url)))
      end,function(e)
        弹出消息("打开Telegram失败，请确认是否已安装Telegram")
      end)
    end},
  {icon=activity.loader.getImagePath("web"),title="官网",click=function()
      进入子页面("web",{"https://linlight.cn/"})
    end},
  {icon=activity.loader.getImagePath("favorite"),title="赞助",click=function()
      进入子页面("web",{server.."money/"})
    end},
  {icon=activity.loader.getImagePath("github.png"),title="github",click=function()
      进入子页面("web",{"https://github.com/jibukeshi/linguang_app"})
    end},
}
page3Adp1=LuaRecyclerAdapter(activity,page3Data1,page3Item)
page3Recycler1.setLayoutManager(LinearLayoutManager(activity))
page3Recycler1.setAdapter(page3Adp1)
page3Adp1.onItemClick=function(adapter,itemView,view,pos)
  load(page3Data1[pos+1].click)
end

page3Data2={
  {icon=activity.loader.getImagePath("cloud_upload"),title="检查更新",click=function()
      Http.get(节点域名.."linguang/update.json",nil,"UTF-8",nil,function(code,content,cookie,header)
        xpcall(function()
          local jsontext=json.decode(content)
          local version=jsontext.version
          local versioncode=jsontext.versioncode
          local date=jsontext.date
          local size=jsontext.size
          local data=jsontext.data
          local url=jsontext.url
          if(versioncode>versionCode)then
            更新弹窗(versionName,versionCode,version,versioncode,date,size,data,url)
           else
            弹出消息("当前已是最新版本")
          end
        end,function(error)
          弹出消息("检查更新失败("..code..")")
        end)
      end)
    end},
  {icon=activity.loader.getImagePath("update"),title="历史更新",click=function()
      进入子页面("web",{节点域名.."/linguang/history.html"})
    end},
  {icon=activity.loader.getImagePath("person"),title="联系作者",click=function()
      xpcall(function()
        local url="mqqapi://card/show_pslcard?uin=3290712646"
        activity.startActivity(Intent(Intent.ACTION_VIEW,Uri.parse(url)))
      end,function(e)
        弹出消息("打开QQ失败，请确认是否已安装QQ/TIM")
      end)
    end},
  {icon=activity.loader.getImagePath("share"),title="分享应用",click=function()
      分享文本("粼光应用商店 - 优雅有质量 "..server)
    end},
  {icon=activity.loader.getImagePath("settings"),title="应用设置",click=function()
      进入子页面("settings")
    end},
}
page3Adp2=LuaRecyclerAdapter(activity,page3Data2,page3Item)
page3Recycler2.setLayoutManager(LinearLayoutManager(activity))
page3Recycler2.setAdapter(page3Adp2)
page3Adp2.onItemClick=function(adapter,itemView,view,pos)
  load(page3Data2[pos+1].click)
end

page3Upload.onClick=function()
  进入子页面("web",{"https://jinshuju.net/f/vcoCgZ"})
end
page3Download.onClick=function()
  进入子页面("download")
end


--使用须知
if not(activity.getSharedData("使用须知"))then
  local dialog=AlertDialog.Builder(this)
  .setTitle("使用须知")
  .setMessage("1、免责声明：本软件仅供学习交流使用，不得用于商业用途，严禁盗版以及未经允许的转载，否则产生的一切后果将由下载用户自行承担。\n2、为确保本软件的正常运行，请授予储存权限。很多问题都是由于未授予储存权限引起的。如果你需要安装apk，则需要授予安装应用权限。\n3、本软件下载的文件默认保存在 /sdcard/Download/ 下，图片默认保存在 /sdcard/Pictures/ 目录下，可以在设置中自定义。\n4、本软件所使用的第三方SDK有百度移动统计，用于上报设备信息、网络信息、错误详情等。本软件不会向其他第三方提供数据。\n5、如果有任何问题，请加群反馈。")
  .setCancelable(false)
  .setPositiveButton("同意并授予权限",nil)
  .setNegativeButton("仅同意",nil)
  .setNeutralButton("拒绝",nil)
  .show()
  dialog.getButton(dialog.BUTTON_POSITIVE).onClick=function()
    activity.setSharedData("使用须知",true)
    activity.requestPermissions({"android.permission.READ_EXTERNAL_STORAGE","android.permission.WRITE_EXTERNAL_STORAGE"},1)
    dialog.dismiss()
  end
  dialog.getButton(dialog.BUTTON_NEGATIVE).onClick=function()
    activity.setSharedData("使用须知",true)
    dialog.dismiss()
  end
  dialog.getButton(dialog.BUTTON_NEUTRAL).onClick=function()
    activity.moveTaskToBack(true)
  end
end


--URL scheme
local scheme=activity.getIntent().getStringExtra("SchemeData")
if(scheme~=nil)then
  if(scheme:find("linguang://home/"))then
    UiManager.viewPager.setCurrentItem(0)
  end
  if(scheme:find("linguang://forum/"))then
    UiManager.viewPager.setCurrentItem(1)
  end
  if(scheme:find("linguang://my/"))then
    UiManager.viewPager.setCurrentItem(2)
  end
  if(scheme:find("linguang://search/"))then
    进入子页面("search")
  end
  if(scheme:find("linguang://apps/"))then
    进入子页面("app",{scheme:match("linguang://(.+)")..".html"})
  end
end


--自动更新
节点列表={"https://weibox.ml/","https://weibox.cf/","https://weibox.eu.org/"}
function 自动更新(选择)
  Http.get(节点列表[选择].."linguang/update.json",nil,"UTF-8",nil,function(code,content,cookie,header)
    if(code==200 and content)then
      节点域名=节点列表[选择]
      local jsontext=json.decode(content)
      local version=jsontext.version
      local versioncode=jsontext.versioncode
      local date=jsontext.date
      local size=jsontext.size
      local data=jsontext.data
      local url=jsontext.url
      if(activity.getSharedData("自动更新") and versioncode>versionCode)then
        更新弹窗(versionName,versionCode,version,versioncode,date,size,data,url)
      end
     else
      if(选择~=#节点列表)then
        弹出消息(选择.."号接口连接失败("..code..")，切换为"..(选择+1).."号接口")
        自动更新(选择+1)
       else
        弹出消息(选择.."号接口连接失败("..code..")，所有接口都无法连接")
      end
    end
  end)
end
自动更新(1)


--百度移动统计
if(activity.getPackageName()=="com.weibox.linguang")then
  import "com.baidu.mobstat.StatService"
  StatService()
  .setAppKey("950b1c201c")
  .start(this)
end