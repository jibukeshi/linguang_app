require "import"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.app.*"
import "com.google.android.material.card.MaterialCardView"
import "com.google.android.material.button.MaterialButton"
import "androidx.recyclerview.widget.*"

UiManager=activity.UiManager
Colors=UiManager.Colors


--颜色配置
强调色=Colors.getColorAccent()
主色=Colors.getColorPrimary()
主文本色=Colors.getTextColorPrimary()
副文本色=Colors.getTextColorSecondary()
窗体背景色=Colors.getWindowBackground()


layout=
--[[{
  RecyclerView;
  layout_width="fill";--宽度
  layout_height="fill";--高度
  id="recycler";
  verticalScrollBarEnabled=false;--隐藏滑条
  overScrollMode=View.OVER_SCROLL_NEVER,--隐藏圆弧阴影
};--]]
{
  LinearLayout;--线性控件
  orientation="vertical";--布局方向
  layout_width="fill";--布局宽度
  layout_height="fill";--布局高度
  gravity="center";--控件内容的重力方向
  --左:left 右:right 中:center 顶:top 底:bottom
  id="page3_none";--设置控件ID
  {
    TextView;--文本控件
    layout_width="wrap";--控件宽度
    layout_height="wrap";--控件高度
    text="当前版本使用系统下载管理";--显示文字
    textSize="18sp";--文字大小
    textColor=主文本色;--文字颜色
    --id="Text";--设置控件ID
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
  {
    TextView;--文本控件
    layout_width="wrap";--控件宽度
    layout_height="wrap";--控件高度
    text="请前往系统下载管理器";--显示文字
    textSize="14sp";--文字大小
    textColor=副文本色;--文字颜色
    --id="Text";--设置控件ID
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

UiManager.getFragment(0).view.addView(loadlayout(layout))

--[[
item=
{
  LinearLayout;--线性控件
  orientation="horizontal";--布局方向
  layout_width="fill";--布局宽度
  layout_height="wrap";--布局高度
  gravity="center";--重力
  --左:left 右:right 中:center 顶:top 底:bottom
  padding="7.5dp";--控件内边距
  {
    LinearLayout;--线性控件
    orientation="vertical";--布局方向
    layout_width="fill";--布局宽度
    layout_height="wrap";--布局高度
    gravity="center";--重力
    --左:left 右:right 中:center 顶:top 底:bottom
    layout_margin="5dp";--控件外边距
    layout_weight="1";--权重值分配
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
      layout_margin="2dp";--控件外边距
    };
    {
      TextView;--文本控件
      layout_width="fill";--控件宽度
      layout_height="wrap";--控件高度
      text="";--显示文字
      textSize="12sp";--文字大小
      textColor=副文本色;--文字颜色
      id="subtitle";--设置控件ID
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
  {
    MaterialCardView;--卡片控件
    layout_width="wrap";--卡片宽度
    layout_height="wrap";--卡片高度
    cardBackgroundColor=窗体背景色;--卡片颜色
    cardElevation="0dp";--卡片阴影
    radius="5dp";--卡片圆角
    id="delete";--设置控件ID
    {
      TextView;--文本控件
      layout_width="wrap";--控件宽度
      layout_height="wrap";--控件高度
      text="删除";--显示文字
      textSize="14sp";--文字大小
      textColor=副文本色;--文字颜色
      --id="Text";--设置控件ID
      --singleLine=true;--设置单行输入
      --ellipsize="end";--多余文字用省略号显示
      --start 开始 middle 中间 end 结尾
      --Typeface=Typeface.DEFAULT;--字体
      --textIsSelectable=true;--文本可复制
      --style="?android:attr/buttonBarButtonStyle";--点击特效
      gravity="center";--重力
      --左:left 右:right 中:center 顶:top 底:bottom
      layout_margin="10dp";--控件外边距
    };
  };
  {
    MaterialButton;--纽扣控件
    layout_width="70dp";--控件宽度
    layout_height="wrap";--控件高度
    text="安装";--显示文字
    textSize="15sp";--文字大小
    textColor=卡片色;--文字颜色
    id="install";--设置控件ID
    backgroundColor=强调色;--背景颜色
    gravity="center";--重力
    --左:left 右:right 中:center 顶:top 底:bottom
  };
};


data={}
for k in each(activity.getApplicationContext().getSharedPreferences("下载管理",0).getAll().entrySet()) do
  table.insert(data,{title=k.getKey(),subtitle=k.getValue()})
end

adp=LuaRecyclerAdapter(activity,data,item).setAdapterInterface(LuaRecyclerAdapter.AdapterInterface{
  onBindViewHolder=function(holder,position)
    local view=holder.getTag()
    import "java.io.File"
    if(File(data[position+1].subtitle).exists())then
      view.delete.onClick=function()
        LuaUtil.rmDir(File(data[position+1].subtitle))
        activity.getApplicationContext().getSharedPreferences("下载管理",0).edit().remove(data[position+1].title).apply()
      end
      view.install.onClick=function()
        dinstall(data[position+1].subtitle)
      end
     else
      install.setText("已删除")
      view.delete.onClick=function()
        activity.getApplicationContext().getSharedPreferences("下载管理",0).edit().remove(data[position+1].title).apply()
      end
      view.install.onClick=nil
    end
  end
})
recycler.setLayoutManager(LinearLayoutManager(activity))
recycler.setAdapter(adp)

function dinstall(path)
  import "android.content.Intent"
  local intent=Intent("android.intent.action.VIEW")
  intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
  import "android.content.FileProvider"
  import "java.io.File"
  local contentUri=FileProvider.getUriForFile(activity,activity.getPackageName()..".FileProvider",File(path))
  intent.setDataAndType(contentUri,"application/vnd.android.package-archive")
  activity.startActivity(intent)
end--]]