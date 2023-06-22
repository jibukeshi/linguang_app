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
      cardBackgroundColor=colorPrimary;--卡片颜色
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
            layout_margin="2dp";--控件外边距
          };
          {
            TextView;--文本控件
            layout_width="fill";--控件宽度
            layout_height="wrap";--控件高度
            text="优雅有质量";--显示文字
            textSize="14sp";--文字大小
            textColor=textColorSecondary;--文字颜色
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
            textColor=textColorSecondary;--文字颜色
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
        cardBackgroundColor=colorPrimary;--卡片颜色
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
            ColorFilter=textColorSecondary;--图片着色
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
            textColor=textColorPrimary;--文字颜色
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
            textColor=textColorSecondary;--文字颜色
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
        cardBackgroundColor=colorPrimary;--卡片颜色
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
            src="favorite";--图片路径
            --id="Image";--设置控件ID
            ColorFilter=textColorSecondary;--图片着色
            --ColorFilter=Color.BLUE;--设置图片着色
            --scaleType="fitXY";--图片拉伸
            layout_margin="2dp";--控件外边距
          };
          {
            TextView;--文本控件
            layout_width="wrap";--控件宽度
            layout_height="wrap";--控件高度
            text="赞助";--显示文字
            textSize="18sp";--文字大小
            textColor=textColorPrimary;--文字颜色
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
            text="赞助粼光，支持开发";--显示文字
            textSize="12sp";--文字大小
            textColor=textColorSecondary;--文字颜色
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
      cardBackgroundColor=colorPrimary;--卡片颜色
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
      cardBackgroundColor=colorPrimary;--卡片颜色
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


local page3Item=
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
      ColorFilter=textColorSecondary;--图片着色
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
      textColor=textColorPrimary;--文字颜色
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
        Toast.makeText(activity,"打开QQ失败，请确认是否已安装QQ/TIM",Toast.LENGTH_SHORT).show()
      end)
    end},
  {icon=activity.loader.getImagePath("QQ.png"),title="QQ官方二群",click=function()
      xpcall(function()
        local url="mqqapi://card/show_pslcard?card_type=group&uin=452547525"
        activity.startActivity(Intent(Intent.ACTION_VIEW,Uri.parse(url)))
      end,function(e)
        Toast.makeText(activity,"打开QQ失败，请确认是否已安装QQ/TIM",Toast.LENGTH_SHORT).show()
      end)
    end},
  {icon=activity.loader.getImagePath("qqpindao.png"),title="QQ频道",click=function()
      activity.newActivity("web",{"https://pd.qq.com/s/avu5s08ka"})
    end},
  {icon=activity.loader.getImagePath("commercial.png"),title="Telegram频道",click=function()
      xpcall(function()
        local url="tg://resolve?domain=linguang_a"
        activity.startActivity(Intent(Intent.ACTION_VIEW,Uri.parse(url)))
      end,function(e)
        Toast.makeText(activity,"打开Telegram失败，请确认是否已安装Telegram",Toast.LENGTH_SHORT).show()
      end)
    end},
  {icon=activity.loader.getImagePath("telegram.png"),title="Telegram群组",click=function()
      xpcall(function()
        local url="tg://resolve?domain=lgtg_1"
        activity.startActivity(Intent(Intent.ACTION_VIEW,Uri.parse(url)))
      end,function(e)
        Toast.makeText(activity,"打开Telegram失败，请确认是否已安装Telegram",Toast.LENGTH_SHORT).show()
      end)
    end},
  {icon=activity.loader.getImagePath("group_add"),title="反馈交流",click=function()
      activity.newActivity("web",{server.."chat.html"})
    end},
  {icon=activity.loader.getImagePath("web"),title="官网",click=function()
      activity.newActivity("web",{"https://linlight.cn/"})
    end},
  {icon=activity.loader.getImagePath("github.png"),title="github",click=function()
      activity.newActivity("web",{"https://github.com/jibukeshi/linguang_app"})
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
        if(code==200 and content)then
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
            Toast.makeText(activity,"当前已是最新版本",Toast.LENGTH_SHORT).show()
          end
         else
          Toast.makeText(activity,"检查更新失败("..code..")",Toast.LENGTH_SHORT).show()
        end
      end)
    end},
  {icon=activity.loader.getImagePath("update"),title="历史更新",click=function()
      activity.newActivity("web",{节点域名.."/linguang/history.html"})
    end},
  {icon=activity.loader.getImagePath("person"),title="联系作者",click=function()
      xpcall(function()
        local url="mqqapi://card/show_pslcard?uin=3290712646"
        activity.startActivity(Intent(Intent.ACTION_VIEW,Uri.parse(url)))
      end,function(e)
        Toast.makeText(activity,"打开QQ失败，请确认是否已安装QQ/TIM",Toast.LENGTH_SHORT).show()
      end)
    end},
  {icon=activity.loader.getImagePath("share"),title="分享应用",click=function()
      import "androidx.core.app.ShareCompat"
      ShareCompat.IntentBuilder.from(activity).setText("粼光应用商店 - 优雅有质量 "..server).setType("text/plain").startChooser()分享文本("粼光应用商店 - 优雅有质量 "..server)
    end},
  {icon=activity.loader.getImagePath("settings"),title="应用设置",click=function()
      activity.newActivity("settings")
    end},
}
page3Adp2=LuaRecyclerAdapter(activity,page3Data2,page3Item)
page3Recycler2.setLayoutManager(LinearLayoutManager(activity))
page3Recycler2.setAdapter(page3Adp2)
page3Adp2.onItemClick=function(adapter,itemView,view,pos)
  load(page3Data2[pos+1].click)
end

page3Upload.onClick=function()
  activity.newActivity("web",{"https://jinshuju.net/f/vcoCgZ"})
end
page3Download.onClick=function()
  activity.newActivity("web",{server.."money/"})
end
