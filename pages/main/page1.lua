import "com.google.android.material.card.MaterialCardView"
import "androidx.core.widget.NestedScrollView"
import "androidx.viewpager.widget.ViewPager"
import "androidx.recyclerview.widget.*"
import "com.androlua.LuaRecyclerAdapter"
import "com.bumptech.glide.*"
import "com.caverock.androidsvg.SVGImageView"

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
      textColor=textColorPrimary;--文字颜色
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
    textColor=textColorPrimary;--文字颜色
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
    cardBackgroundColor=colorPrimary;--卡片颜色
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
  cardBackgroundColor=colorPrimary;--卡片颜色
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


function GetApplist()--获取首页应用列表
  page1Normal.setVisibility(View.GONE)
  page1Images.setVisibility(View.GONE)
  page1Loading.setVisibility(View.VISIBLE)
  page1Progress.setVisibility(View.VISIBLE)
  page1Message.setText("获取中……").onClick=function()end
  
  Http.get(serverUrl.."index.json",nil,"UTF-8",nil,function(code,content,cookie,header)
    if(code==200 and content)then
      --获取成功
      page1Normal.setVisibility(View.VISIBLE)
      page1Loading.setVisibility(View.GONE)
      --解析json
      local jsontext=json.decode(content)
      --首页分类的适配器
      local page1Adp=LuaRecyclerAdapter(activity,jsontext.apps,page1Group).setAdapterInterface({
        onBindViewHolder=function(holder,position)
          local groupView=holder.tag--获取组的view
          local groupInfo=jsontext.apps[position+1]--获取组的信息
          groupView.title.setText(groupInfo.name)
          --首页每个应用的适配器
          local adp=LuaRecyclerAdapter(activity,groupInfo.items,page1App).setAdapterInterface({
            onBindViewHolder=function(holder2,position2)
              local appView=holder2.tag--获取应用的view
              local appInfo=jsontext.apps[position+1].items[position2+1]--获取应用的信息
              appView.name.setText(appInfo.name)
              --判断应用图标是不是svg
              if(appInfo.img:find".svg")then
                --如果是svg，判断是否有缓存
                local file=activity.getExternalFilesDir(nil).toString().."/svg/"..appInfo.name..".svg"
                if(File(file).exists())then
                  --如果已经缓存过了，就直接加载
                  appView.svg.setImageURI(Uri.fromFile(File(file)))
                 else
                  --如果没有缓存，就先缓存
                  Http.download(serverUrl..appInfo.img,file,function(a)
                    --缓存完毕，加载图片
                    appView.svg.setImageURI(Uri.fromFile(File(file)))
                  end)
                end
               else
                --如果不是svg就直接用Glide加载
                Glide.with(activity).load(serverUrl..appInfo.img).into(appView.icon)
              end
              appView.card.onClick=function()
                activity.newActivity("app",{serverUrl,appInfo.url})
              end
            end
          })
          groupView.recycler.setLayoutManager(GridLayoutManager(activity,4))
          groupView.recycler.setAdapter(adp)
        end
      })
      page1Recycler.setLayoutManager(LinearLayoutManager(activity))
      page1Recycler.setAdapter(page1Adp)
     else
      --获取失败
      page1Progress.setVisibility(View.GONE)
      page1Message.setText("获取失败 ("..code..")").onClick=function()
        GetApplist()
      end
    end
  end)

  --获取首页轮播图
  Http.get(serverUrl.."index.html",nil,"UTF-8",nil,function(code,content,cookie,header)
    xpcall(function()
      page1Images.setVisibility(View.VISIBLE)
      local list=ArrayList()
      for k in content:match([[轮播图 感谢学神之女(.-)轮播的内容可以是图片]]):gmatch("<img(.-)>") do
        local image=k:match([[src="(.-)"]])--获取图片链接
        local url=k:match("'(.-)'")--获取跳转链接
        --如果图片链接没有域名就加上
        if(image and not(image:find("://")))then
          image=serverUrl..image
        end
        --如果跳转链接没有域名就加上
        if(url and not(url:find("://")))then
          url=serverUrl..url
        end
        local imageLayout=
        {
          MaterialCardView;--卡片控件
          layout_width="fill";--卡片宽度
          layout_height="wrap";--卡片高度
          cardBackgroundColor=colorPrimary;--卡片颜色
          cardElevation="0dp";--卡片阴影
          radius="5dp";--卡片圆角
          onClick=function()
            if(url)then
              activity.newActivity("web",{serverUrl,serverUrl,url})
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
      page1Images.setAdapter(BasePagerAdapter(list))
      --自动轮播
      local ti=Ticker()
      ti.Period=5000
      ti.onTick=function()
        if(page1Images.getCurrentItem()==list.size()-1)then
          --如果已经是最后一张了就显示第一张
          page1Images.setCurrentItem(0,true)
         else
          --否则就显示下一张
          page1Images.setCurrentItem(page1Images.getCurrentItem()+1,true)
        end
      end
      ti.start()
      --退出应用停止轮播
      function onDestroy()
        ti.stop()
      end
    end,function(e)
      page1Images.setVisibility(View.GONE)
      Toast.makeText(activity,"轮播图获取失败("..code..")",Toast.LENGTH_SHORT)
    end)
  end)

end


