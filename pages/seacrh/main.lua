require "import"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.app.*"
import "android.graphics.Typeface"
import "net.fusion64j.core.ui.UiManager"
import "com.google.android.material.card.MaterialCardView"
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


--服务器配置
server="https://cdn.bwcxlg.top/"


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
    RecyclerView;
    layout_width="fill";--宽度
    layout_height="fill";--高度
    id="recycler";
    verticalScrollBarEnabled=false;--隐藏滑条
    overScrollMode=View.OVER_SCROLL_NEVER,--隐藏圆弧阴影
    layout_margin="10dp";--控件外边距
  };
};


UiManager.getFragment(0).view.addView(loadlayout(layout))


item=
{
  MaterialCardView;--卡片控件
  layout_width="fill";--卡片宽度
  layout_height="wrap";--卡片高度
  cardBackgroundColor=windowBackground;--卡片颜色
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
      cardBackgroundColor=colorPrimary;--卡片颜色
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
      textColor=textColorPrimary;--文字颜色
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

data={}
adp=LuaRecyclerAdapter(activity,data,item).setAdapterInterface({
  onBindViewHolder=function(holder,position)
    local view=holder.tag
    view.name.setText(data[position+1].name)
    --判断应用图标是不是svg
    if(data[position+1].img:find".svg")then
      --如果是svg，判断是否有缓存
      local file=activity.getExternalFilesDir(nil).toString().."/svg/"..data[position+1].name..".svg"
      if(File(file).exists())then
        --如果已经缓存过了，就直接加载
        view.svg.setImageURI(Uri.fromFile(File(file)))
       else
        --如果没有缓存，就先缓存
        Http.download(server..data[position+1].img,file,function(a)
          --缓存完毕，加载图片
          view.svg.setImageURI(Uri.fromFile(File(file)))
        end)
      end
     else
      Glide.with(activity).load(server..data[position+1].img).into(view.icon)
    end
    view.card.onClick=function()
      activity.newActivity("app",{data[position+1].url})
    end
  end
})
recycler.setLayoutManager(GridLayoutManager(activity,4))
recycler.setAdapter(adp)


function Get()
  --开始获取
  recycler.setVisibility(View.GONE)
  loading.setVisibility(View.VISIBLE)
  progress.setVisibility(View.VISIBLE)
  message.setText("获取中……").onClick=function()end
  Http.get(server.."index.json",nil,"UTF-8",nil,function(code,content,cookie,header)
    if(code==200 and content)then
      --获取成功
      recycler.setVisibility(View.VISIBLE)
      loading.setVisibility(View.GONE)
      --解析json
      jsontext=json.decode(content)
      for i=1,#jsontext.apps do
        --热门应用会有重复，不要加载
        if not(jsontext.apps[i].name=="热门应用")then
          for j=1,#jsontext.apps[i].items do
            table.insert(data,{
              name=jsontext.apps[i].items[j].name,
              url=jsontext.apps[i].items[j].url,
              img=jsontext.apps[i].items[j].img
            })
          end
        end
      end
      adp.notifyDataSetChanged()
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

-- @param keyword 搜索栏输入的文本
-- @description 顶栏搜索功能回调事件
function onSearchEvent(keyword)
  table.clear(data)
  for i=1,#jsontext.apps do
    if not(jsontext.apps[i].name=="热门应用")then
      for j=1,#jsontext.apps[i].items do
        if(string.lower(jsontext.apps[i].items[j].name):match(string.lower(keyword)))then
          table.insert(data,{
            name=jsontext.apps[i].items[j].name,
            url=jsontext.apps[i].items[j].url,
            img=jsontext.apps[i].items[j].img
          })
        end
      end
    end
  end
  --adp.notifyDataSetChanged()--这个有bug，图片不会更新，必须用下面的
  recycler.setAdapter(adp)
end