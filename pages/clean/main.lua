require "import"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.app.*"
import "com.google.android.material.card.MaterialCardView"
import "com.google.android.material.button.MaterialButton"
import "androidx.recyclerview.widget.*"
import "java.io.File"
import "android.text.format.Formatter"

UiManager=activity.UiManager
Colors=UiManager.Colors


--颜色配置
强调色=Colors.getColorAccent()
主色=Colors.getColorPrimary()
主文本色=Colors.getTextColorPrimary()
副文本色=Colors.getTextColorSecondary()
窗体背景色=Colors.getWindowBackground()


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
      cardBackgroundColor=主色;--卡片颜色
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
      backgroundColor=强调色;--背景颜色
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
  cardBackgroundColor=主色;--卡片颜色
  cardElevation="0dp";--卡片阴影
  radius="5dp";--卡片圆角
  id="card";--设置控件ID
  {
    CheckBox;--复选控件
    layout_width="fill";--控件宽度
    layout_height="fill";--控件高度
    text="";--显示文字
    textSize="16sp";--文字大小
    textColor=主文本色;--文字颜色
    layout_margin="10dp";--控件外边距
    id="check";--设置控件ID
    clickable=false;
    focusable=false;
  };
};


adp=LuaRecyclerAdapter(activity,item).setClickViewId("card")
recycler.setLayoutManager(LinearLayoutManager(activity))
recycler.setAdapter(adp)

external_files_dir=activity.getExternalFilesDir(nil).toString()--获取外部数据目录
external_chche_dir=activity.getExternalCacheDir().toString()--获取外部缓存目录
data_dir=activity.getDataDir().toString()--获取数据目录

data={
  {title="应用崩溃记录",dir=external_files_dir.."/crash"},
  {title="SVG 图片缓存",dir=external_files_dir.."/svg"},
  {title="Glide 图片加载缓存",dir=data_dir.."/cache/image_manager_disk_cache"},
  {title="WebView 存储数据",dir=data_dir.."/app_webview"},
  {title="WebView 缓存信息",dir=data_dir.."/cache/WebView"},
  {title="其他缓存",dir=external_chche_dir},
}


function get_dir_size(dir)--获取目录的大小
  local size=0
  local list_file=File(dir).listFiles()--列出所有子项
  if(list_file)then--如果子项存在
    for k,v in ipairs(luajava.astable(list_file)) do
      if(v.isDirectory())then
        --如果子项是文件夹就递归获取大小
        size=size+get_dir_size(v.toString())
       else
        --如果子项是文件就加上它的大小
        size=size+v.length()
      end
    end
  end
  return size
end

function delete_dir(dir)--删除目录
  local file=File(dir)
  local list_file=file.listFiles()--列出所有子项
  if(list_file)then--如果子项存在
    for k,v in ipairs(luajava.astable(list_file)) do
      if(v.isDirectory())then
        --如果子项是文件夹就递归删除
        delete_dir(v.toString())
       else
        --如果子项是文件就直接删除
        v.delete()
      end
    end
  end
end


function update_cache_list()
  --更新RecyclerView
  adp.clear()
  for k,v in ipairs(data)
    local size=Formatter.formatFileSize(activity,get_dir_size(v.dir))
    adp.add{check=v.title.."（"..size.."）"}
  end
end
update_cache_list()

adp.onItemClick=function(adapter,item_view,view,pos)
  local check=view.getChildAt(0)
  check.setChecked(not check.checked)
  local size=0
  for i=0,adp.getItemCount()-1 do
    local check2=recycler.getChildAt(i).getChildAt(0)
    if(check2.checked)then
      local current=get_dir_size(data[i+1].dir)
      size=size+current
    end
  end
  clean.setText("确定清理".."（"..Formatter.formatFileSize(activity,size).."）")
end

clean.onClick=function()
  for i=0,adp.getItemCount()-1
    local check=recycler.getChildAt(i).getChildAt(0)
    if(check.checked)then
      --如果勾选了就清理
      delete_dir(data[i+1].dir)
      check.setChecked(false)--清理完成，把勾取消
    end
  end
  update_cache_list()
  clean.setText("确定清理（0B）")
end
