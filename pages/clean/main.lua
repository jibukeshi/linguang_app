require "import"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.app.*"
import "com.google.android.material.card.MaterialCardView"
import "com.google.android.material.button.MaterialButton"
import "androidx.recyclerview.widget.*"
import "androidx.core.widget.NestedScrollView"
import "java.io.File"
import "android.text.format.Formatter"

UiManager=activity.UiManager
Colors=UiManager.Colors


--颜色配置
colorAccent=Colors.getColorAccent()--强调色
colorPrimary=Colors.getColorPrimary()--主色
textColorPrimary=Colors.getTextColorPrimary()--主文本色
textColorSecondary=Colors.getTextColorSecondary()--副文本色
windowBackground=Colors.getWindowBackground()--窗体背景色


layout=--常规框架
{
  ScrollView;--纵向滑动控件
  layout_width="fill";--布局宽度
  layout_height="fill";--布局高度
  verticalScrollBarEnabled=false;--隐藏纵向滑条
  overScrollMode=View.OVER_SCROLL_NEVER,--隐藏圆弧阴影
  {
    LinearLayout;--线性控件
    orientation="vertical";--布局方向
    layout_width="fill";--布局宽度
    layout_height="fill";--布局高度
    gravity="center|top";--重力
    --左:left 右:right 中:center 顶:top 底:bottom
    layout_margin="10dp";--控件外边距
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
        layout_height="wrap";--高度
        id="recycler";
        verticalScrollBarEnabled=false;--隐藏滑条
        overScrollMode=View.OVER_SCROLL_NEVER,--隐藏圆弧阴影
      };
    },
    {
      MaterialButton;--纽扣控件
      layout_width="fill";--控件宽度
      layout_height="wrap";--控件高度
      text="确定清理（0B）";--显示文字
      textSize="15sp";--文字大小
      textColor=卡片色;--文字颜色
      id="clean";--设置控件ID
      backgroundColor=colorAccent;--背景颜色
      gravity="center";--重力
      --左:left 右:right 中:center 顶:top 底:bottom
      layout_margin="10dp";--控件外边距
      padding="20dp";--控件内边距
    };
  },
}

UiManager.getFragment(0).view.addView(loadlayout(layout))


item=
{
  MaterialCardView;--卡片控件
  layout_width="fill";--卡片宽度
  layout_height="wrap";--卡片高度
  cardBackgroundColor=colorPrimary;--卡片颜色
  cardElevation="0dp";--卡片阴影
  radius="5dp";--卡片圆角
  id="card";--设置控件ID
  {
    CheckBox;--复选控件
    layout_width="fill";--控件宽度
    layout_height="fill";--控件高度
    text="";--显示文字
    textSize="16sp";--文字大小
    textColor=textColorPrimary;--文字颜色
    layout_margin="10dp";--控件外边距
    id="check";--设置控件ID
    clickable=false;
    focusable=false;
  };
};


externalFilesDir=activity.getExternalFilesDir(nil).toString()--获取外部数据目录
externalCacheDir=activity.getExternalCacheDir().toString()--获取外部缓存目录
dataDir=activity.getDataDir().toString()--获取数据目录

data={
  {title="应用崩溃记录",dir=externalFilesDir.."/crash",check=true},
  {title="SVG 图片缓存",dir=externalFilesDir.."/svg",check=true},
  {title="Glide 图片加载缓存",dir=dataDir.."/cache/image_manager_disk_cache",check=true},
  {title="WebView 缓存",dir=dataDir.."/cache/WebView",check=true},
  {title="WebView 存储数据",dir=dataDir.."/app_webview",check=false},
  {title="其他缓存",dir=externalCacheDir,check=true},
}

function GetDirSize(dir)--获取目录的大小
  local size=0
  local listFile=File(dir).listFiles()--列出所有子项
  if(listFile)then--如果子项存在
    for key,value in ipairs(luajava.astable(listFile)) do
      if(value.isDirectory())then
        --如果子项是文件夹就递归获取大小
        size=size+GetDirSize(value.toString())
       else
        --如果子项是文件就加上它的大小
        size=size+value.length()
      end
    end
  end
  return size
end

function DeleteDir(dir)--删除目录
  local file=File(dir)
  local listFile=file.listFiles()--列出所有子项
  if(listFile)then--如果子项存在
    for key,value in ipairs(luajava.astable(listFile)) do
      if(value.isDirectory())then
        --如果子项是文件夹就递归删除
        DeleteDir(value.toString())
       else
        --如果子项是文件就直接删除
        value.delete()
      end
    end
  end
end

function UpdateList(view,position)--更新列表
  --获取当前项大小
  local size=Formatter.formatFileSize(activity,GetDirSize(data[position+1].dir))
  view.check.setText(data[position+1].title.."（"..size.."）")
  view.check.setChecked(data[position+1].check)
  --获取总大小
  local total=0
  for i=1,#data do
    --遍历所有项目
    if(data[i].check)then
      --如果勾选了就加上
      local current=GetDirSize(data[i].dir)
      total=total+current
    end
  end
  local size=Formatter.formatFileSize(activity,total)
  clean.setText("确定清理".."（"..size.."）")
end

adp=LuaRecyclerAdapter(activity,data,item).setAdapterInterface({
  onBindViewHolder=function(holder,position)
    local view=holder.tag
    UpdateList(view,position)
    view.card.onClick=function()
      data[position+1].check=not(data[position+1].check)
      UpdateList(view,position)
    end
  end
})
recycler.setLayoutManager(LinearLayoutManager(activity))
recycler.setAdapter(adp)

clean.onClick=function()
  for i=1,#data do
    if(data[i].check)then
      --如果勾选了就清理
      DeleteDir(data[i].dir)
    end
  end
  adp.notifyDataSetChanged()
  Toast.makeText(activity,"清理成功",Toast.LENGTH_SHORT).show()
end
