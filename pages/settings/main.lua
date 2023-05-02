require "import"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.app.*"
import "com.google.android.material.card.MaterialCardView"
import "com.google.android.material.switchmaterial.SwitchMaterial"
import "com.google.android.material.textfield.*"
import "androidx.recyclerview.widget.*"
import "android.graphics.Typeface"
import"com.google.android.material.dialog.MaterialAlertDialogBuilder"

UiManager=activity.UiManager
Colors=UiManager.Colors


--颜色配置
colorAccent=Colors.getColorAccent()--强调色
colorPrimary=Colors.getColorPrimary()--主色
textColorPrimary=Colors.getTextColorPrimary()--主文本色
textColorSecondary=Colors.getTextColorSecondary()--副文本色
windowBackground=Colors.getWindowBackground()--窗体背景色


layout=
{
  ScrollView;--纵向滑动控件
  layout_width="fill";--布局宽度
  layout_height="fill";--布局高度
  --verticalScrollBarEnabled=false;--隐藏纵向滑条
  overScrollMode=View.OVER_SCROLL_NEVER,--隐藏圆弧阴影
  {
    LinearLayout;--线性控件
    orientation="vertical";--布局方向
    layout_width="fill";--布局宽度
    layout_height="fill";--布局高度
    gravity="center|top";--重力
    --左:left 右:right 中:center 顶:top 底:bottom
    id="main";--设置控件ID
  };
};

UiManager.getFragment(0).view.addView(loadlayout(layout))


function add(index)
  if(data[index].viewType==1)then
    main.addView(loadlayout(
    {
      LinearLayout;--线性控件
      orientation="horizontal";--布局方向
      layout_width="fill";--布局宽度
      layout_height="wrap";--布局高度
      {
        TextView;--文本控件
        layout_width="fill";--控件宽度
        layout_height="wrap";--控件高度
        text=data[index].title;--显示文字
        textSize="14sp";--文字大小
        textColor=colorAccent;--文字颜色
        --id="Text";--设置控件ID
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
    }))
  end
  if(data[index].viewType==2)then
    main.addView(loadlayout({
      MaterialCardView;--卡片控件
      layout_width="fill";--卡片宽度
      layout_height="wrap";--卡片高度
      cardBackgroundColor=windowBackground;--卡片颜色
      cardElevation="0dp";--卡片阴影
      radius="5dp";--卡片圆角
      onClick=data[index].click;
      {
        LinearLayout;--线性控件
        orientation="horizontal";--布局方向
        layout_width="fill";--布局宽度
        layout_height="wrap";--布局高度
        gravity="center";--控件内容的重力方向
        --左:left 右:right 中:center 顶:top 底:bottom
        layout_margin="5dp";--控件外边距
        {
          ImageView;--图片控件
          layout_width="25dp";--图片宽度
          layout_height="25dp";--图片高度
          src=data[index].icon;--图片路径
          --id="Image";--设置控件ID
          ColorFilter=colorAccent;--图片着色
          --ColorFilter=Color.BLUE;--设置图片着色
          scaleType="fitXY";--图片拉伸
          layout_gravity="center";--重力
          layout_margin="10dp";--控件外边距
        };
        {
          TextView;--文本控件
          layout_width="fill";--控件宽度
          layout_height="wrap";--控件高度
          text=data[index].title;--显示文字
          textSize="16sp";--文字大小
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
          layout_margin="10dp";--控件外边距
          layout_weight="1";--权重值分配
        };
        {
          SwitchMaterial;--开关控件
          layout_width="wrap";--控件宽度
          layout_height="wrap";--控件高度
          id="check"..index;--设置控件ID
          --text="本文内容";--显示文字
          --textSize="16sp";--文字大小
          --textColor="#333333";--文字颜色
          gravity="center";--重力
          --SwitchMinWidth="0dp";--开关最小宽度
          --SwitchPadding="0dp";--开关与文字的间距
          --showText=true;--开关上是否显示文字
          checked=data[index].check;--代码中设置复选框初始化状态
          --enabled=false ;--设置复选框为灰色,默认不可点击
          clickable=false;--设置复选框为彩色，默认不可点击
          Focusable=false;
          layout_marginRight="10dp";--控件右距
        };
      };
    }))
  end
  if(data[index].viewType==3)then
    main.addView(loadlayout({
      MaterialCardView;--卡片控件
      layout_width="fill";--卡片宽度
      layout_height="wrap";--卡片高度
      cardBackgroundColor=windowBackground;--卡片颜色
      cardElevation="0dp";--卡片阴影
      radius="5dp";--卡片圆角
      onClick=data[index].click;
      {
        LinearLayout;--线性控件
        orientation="horizontal";--布局方向
        layout_width="fill";--布局宽度
        layout_height="wrap";--布局高度
        gravity="center";--控件内容的重力方向
        --左:left 右:right 中:center 顶:top 底:bottom
        layout_margin="5dp";--控件外边距
        {
          ImageView;--图片控件
          layout_width="25dp";--图片宽度
          layout_height="25dp";--图片高度
          src=data[index].icon;--图片路径
          --id="Image";--设置控件ID
          ColorFilter=colorAccent;--图片着色
          --ColorFilter=Color.BLUE;--设置图片着色
          scaleType="fitXY";--图片拉伸
          layout_gravity="center";--重力
          layout_margin="10dp";--控件外边距
        };
        {
          TextView;--文本控件
          layout_width="fill";--控件宽度
          layout_height="wrap";--控件高度
          text=data[index].title;--显示文字
          textSize="16sp";--文字大小
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
          layout_margin="10dp";--控件外边距
        };
      };
    }))
  end
  if(data[index].viewType==4)then
    main.addView(loadlayout({
      LinearLayout;--线性控件
      orientation="horizontal";--布局方向
      layout_width="fill";--布局宽度
      layout_height="wrap";--布局高度
      {
        TextView;--横向分割线
        layout_width="fill";--分割线宽度
        layout_height="2px";--分割线厚度
        layout_gravity="center";--高度居中
        backgroundColor=textColorSecondary;--分割线颜色
        layout_marginTop="10dp";--布局顶距
        layout_marginBottom="10dp";--布局底距
      };
    }))
  end
end


data={
  {viewType=1,title="基本设置"},
  {viewType=2,title="启动时检查更新",icon="cloud_upload",check=activity.getSharedData("autoUpdate"),click=function()
      activity.setSharedData("autoUpdate",not(activity.getSharedData("autoUpdate")))
      check2.checked=activity.getSharedData("autoUpdate")
    end},
  {viewType=2,title="退出时弹窗确认",icon="exit_to_app",check=activity.getSharedData("exitConfirm"),click=function()
      activity.setSharedData("exitConfirm",not(activity.getSharedData("exitConfirm")))
      check3.checked=activity.getSharedData("exitConfirm")
    end},
  {viewType=3,title="启动默认页面",icon="home",click=function()
      local items={"首页","社区","我的"}
      local choose=activity.getSharedData("homePage")
      local dialog=MaterialAlertDialogBuilder(activity)
      .setTitle("深色模式切换")
      .setSingleChoiceItems(items,choose,{onClick=function(v,p)
          choose=p
        end})
      .setPositiveButton("确定",function()
        activity.setSharedData("homePage",choose)
      end)
      .setNegativeButton("取消",nil)
      .show()
    end},
  {viewType=4},
  {viewType=1,title="下载安装"},
  {viewType=2,title="下载完成后自动安装",icon="move_to_inbox",check=activity.getSharedData("autoInstall"),click=function()
      activity.setSharedData("autoInstall",not(activity.getSharedData("autoInstall")))
      check7.checked=activity.getSharedData("autoInstall")
    end},
  {viewType=3,title="下载目录",icon="file_download",click=function()
      local dialog=MaterialAlertDialogBuilder(activity)
      .setTitle("下载目录")
      .setView(loadlayout(
      {
        LinearLayout;--线性控件
        orientation="horizontal";--布局方向
        layout_width="fill";--布局宽度
        layout_height="fill";--布局高度
        gravity="center";--重力
        --左:left 右:right 中:center 顶:top 底:bottom
        {
          TextInputLayout;
          layout_width="fill";--控件宽度
          layout_height="wrap";--控件高度
          Hint="请输入下载目录";--编辑框内容为空时提示文字
          id="input";--设置控件ID
          layout_margin="20dp";--控件外边距
          layout_marginTop="10dp";--控件顶距
          layout_marginBottom="10dp";--控件底距
          {
            TextInputEditText;
            layout_width="fill";--控件宽度
            layout_height="fill";--控件高度
            id="edit";--设置控件ID
            text=activity.getSharedData("downloadPath");--显示文字
            textSize="16sp";--本文大小
            textColor=textColorPrimary;--本文颜色
            singleLine=true;--设置单行输入，禁止换行
          };
        };
      }
      ))
      .setPositiveButton("确定",function()
        activity.setSharedData("downloadPath",edit.text)
      end)
      .setNegativeButton("取消",nil)
      .show()
    end},
  {viewType=3,title="图片下载目录",icon="image",click=function()
      local dialog=MaterialAlertDialogBuilder(activity)
      .setTitle("图片下载目录")
      .setView(loadlayout(
      {
        LinearLayout;--线性控件
        orientation="horizontal";--布局方向
        layout_width="fill";--布局宽度
        layout_height="fill";--布局高度
        gravity="center";--重力
        --左:left 右:right 中:center 顶:top 底:bottom
        {
          TextInputLayout;
          layout_width="fill";--控件宽度
          layout_height="wrap";--控件高度
          Hint="请输入图片下载目录";--编辑框内容为空时提示文字
          id="input";--设置控件ID
          layout_margin="20dp";--控件外边距
          layout_marginTop="10dp";--控件顶距
          layout_marginBottom="10dp";--控件底距
          {
            TextInputEditText;
            layout_width="fill";--控件宽度
            layout_height="fill";--控件高度
            id="edit";--设置控件ID
            text=activity.getSharedData("imagePath");--显示文字
            textSize="16sp";--本文大小
            textColor=textColorPrimary;--本文颜色
            singleLine=true;--设置单行输入，禁止换行
          };
        };
      }
      ))
      .setPositiveButton("确定",function()
        activity.setSharedData("imagePath",edit.text)
      end)
      .setNegativeButton("取消",nil)
      .show()
    end},
  {viewType=4},
  {viewType=1,title="更多设置"},
  {viewType=3,title="清理缓存",icon="delete",click=function()
      activity.newActivity("clean")
    end},
}

for i=1,#data do
  add(i)
end