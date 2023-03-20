--
-- @other 基于 ViewPager无限图片浏览 制作，改动较大。已下原作者信息
--
-- @author FusionApp2公测群（QQ）- jies辰
-- @description ViewPager无限图片浏览
--
-- ******************************************
--
-- 本工程使用LongImageView控件，开源地址:https://github.com/bm-x/PhotoView
-- 示例文件来自
-- QQ：3357212590
-- By Long, 2021-12-12 16:50
--
-- ****基本导入****
require "import"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "com.longdesign.*"

--uiManager
uiManager=activity.getUiManager()

import "android.animation.ObjectAnimator"
function alpha(id,time,i)
  --透明度动画 https://www.jiecs.top/archives/668
  if i then on,off,hide=1,0,8 else on,off,hide=0,1,0 end
  if id.visibility~=hide then
    id.visibility=0
    animation=ObjectAnimator.ofFloat(id, "alpha", {on, off})
    animation.setDuration(tointeger(time))
    animation.start()
    task(tointeger(time),function()
      if i then off,hide=0,8 else off,hide=1,0 end
      id.visibility=hide
      id.alpha=off
    end)
  end
end

function Translation(id,e)--上下动画
  import "android.view.animation.DecelerateInterpolator"
  import "android.view.animation.Animation"
  import "android.animation.ObjectAnimator"
  local function f(e)
    if e=="下" then
      return (id.getY()+id.Height)
     else
      return (id.getY()-id.Height)
    end
  end
  animation = ObjectAnimator.ofFloat(id, "Y",{id.getY(),f(e) })
  animation.setRepeatCount(0)--设置动画重复次
  animation.setRepeatMode(Animation.REVERSE)--
  animation.setInterpolator(DecelerateInterpolator())--设置插值器
  animation.setDuration(400)--设置动画时间
  animation.start()--开始动画
end
local State_of_the_switch=true
function Animationswitch()--上下动画的判断部分。
  activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_HIDE_NAVIGATION|View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY)
  --这个是隐藏虚拟按键。为了适配。点击屏幕中间就隐藏。
  if State_of_the_switch then
    Translation(bottom,"下")
    Translation(top,"上")
    -- activity.window.attributes.layoutInDisplayCutoutMode=1
    import "android.view.WindowManager"
    activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
    State_of_the_switch=false
   else
    Translation(bottom,"上")
    Translation(top,"下")
    import "android.view.WindowManager"
    activity.getWindow().clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
    --activity.window.attributes.layoutInDisplayCutoutMode=2
    State_of_the_switch=true
  end
end
import "android.graphics.Color"
import "android.graphics.Typeface"
import "androidx.viewpager.widget.ViewPager"
import "androidx.recyclerview.widget.*"
import "android.content.res.ColorStateList"
import "layout"
--加载layout
activity.setContentView(loadlayout(layout))

activity.overridePendingTransition(android.R.anim.fade_in,android.R.anim.fade_out)--淡入淡出
if Build.VERSION.SDK_INT >=28 then--系统SDK28以上生效，因为这是安卓9新引入的
  activity.window.attributes.layoutInDisplayCutoutMode=1
end
--设置异形屏幕全屏
activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)
--设置状态栏沉浸
activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION)
--设置导航栏沉浸
activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN)
--浅色状态栏
--activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
--收起状态栏（与状态栏沉浸冲突）
activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_HIDE_NAVIGATION|View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY)
--隐藏虚拟按键


--viewPager适配器
import "net.fusion64j.core.ui.adapter.BasePagerAdapter"
pager_list=ArrayList()
pager_adapter=BasePagerAdapter(pager_list)
view_pager.setAdapter(pager_adapter)


import "com.google.android.material.card.MaterialCardView"
import "com.google.android.material.imageview.ShapeableImageView"

local page_layout={FrameLayout,
  layout_width="fill",
  layout_height="fill",
  {ProgressBar, --加载圈在图片的后面，图片加载完后会自动覆盖在加载圈前面
    layout_height="50dp",
    layout_width="50dp",
    id="Prog",
    layout_gravity="center",
    indeterminateTintList=ColorStateList.valueOf(Color.parseColor(this.uiManager.getColors().colorAccent)),--加载圈的颜色
  },
  {LongImageView,
    layout_height="match",
    layout_width="match",
    visibility=8,
    adjustViewBounds=true, --自适应大小
    id="img",
  },
}


local list_item={
  FrameLayout,
  layout_width="wrap",
  layout_height="match",
  {
    MaterialCardView,
    id="cardview",--设置ID
    layout_marginLeft='5dp';--布局左距
    layout_marginRight='5dp';--布局右距
    layout_width="56dp",
    layout_height="match",
    --strokeWidth="2dp", --边框宽度
    --strokeColor="#03DAC5", --边框颜色
    cardBackgroundColor="#00ffffff",--卡片背景色
    cardElevation="0dp",--卡片阴影强度
    radius="4dp",--卡片圆角幅度
    {
      ShapeableImageView,
      id="iv_1",
      scaleType="centerCrop",
      layout_width="56dp",
      layout_height="match",
    },
  }
}

recycler_view.layoutManager=LinearLayoutManager(activity)
recycler_view.layoutManager.setOrientation(0)--0是横向，1是竖向
local adapter=LuaRecyclerAdapter(activity,{},list_item)
adapter.onItemClick=function(adapter,itemView,view,pos)
  view_pager.setCurrentItem(pos,true)--带动画跳转到指定页数(当前点击)
end

--adapter.clickViewId="iv_1"
adapter.setAdapterInterface(LuaRecyclerAdapter.AdapterInterface{
  onBindViewHolder=function(viewHolder,index)
    if index==view_pager.getCurrentItem() then
      viewHolder.tag.iv_1.alpha=0.6
      viewHolder.tag.cardview.strokeWidth=8
      viewHolder.tag.cardview.strokeColor=Color.parseColor(this.uiManager.getColors().colorAccent)
    end
    view_pager.addOnPageChangeListener(ViewPager.OnPageChangeListener{
      onPageSelected=function(position)
        Quantity.setText((position+1).."/"..pager_adapter.getCount())--设置文字 当前页面/总共页面
        recycler_view.smoothScrollToPosition(position)--平滑移动到当前页面(预览图)
        if index== position then
          viewHolder.tag.iv_1.alpha=0.6--透明度
          viewHolder.tag.cardview.strokeWidth=8--边框宽度
          viewHolder.tag.cardview.strokeColor=Color.parseColor(this.uiManager.getColors().colorAccent)--边框颜色，主题色。
         else
          viewHolder.tag.iv_1.alpha=1
          viewHolder.tag.cardview.strokeWidth=0
        end
      end
    })
  end
})
recycler_view.adapter=adapter
import "com.bumptech.glide.Glide"
import "com.bumptech.glide.request.target.CustomTarget"
import "com.bumptech.glide.signature.MediaStoreSignature"
function loadImg(id,id2,url,k)
  Glide.with(activity)
  .asBitmap()
  --.signature(MediaStoreSignature(tostring(System.currentTimeMillis()),math.random(0,100),os.time()))--缓存有效时间
  .load(url)
  .into(CustomTarget{
    onResourceReady=function(bitmap,transition)
      if id then
        id.setImageBitmap(bitmap)
        alpha(id,250)
        id2.setVisibility(this.uiManager.viewPager.GONE)
        --id.disenable()--禁用缩放和旋转
        --id.disableRotate()--禁用旋转
        id.maxScale=10--最大缩放倍数
        id.onClick=function(v)
          Animationswitch()
        end
      end
    end,
    onLoadFailed=function(bitmap)
      print('图片 '..k.." 加载失败")
    end
  })
end


function addPager(url,k)
  pager_list.add(loadlayout(page_layout))--添加页面
  pager_adapter.notifyDataSetChanged()
  adapter.add({iv_1=url})--添加页面
  loadImg(img,Prog,url,k)
end

--view_pager.setCurrentItem(1,false)


local intent=activity.getIntent()
local Json=intent.getStringExtra("key")--请注意。请不要传入uri路径，否则将会无法使用下面三个功能。我在传入前已经做了转换。详见main文件夹main文件73行
if Json then
  json=require "cjson"
  local ztable=json.decode(Json)
  local page=1
  for k,v in pairs(ztable)
    if v.page then
      page=v.page
     elseif v ~= "" then
      local path=activity.loader.getImagePath(v) --fa2拆包获得的代码。应该是用于判断是否为软件内的图片。否的话，返回空。
      if path ~= nil then
        v = path
      end
      addPager(v,k)
    end
  end
  if page <= pager_adapter.getCount() and page >= 1 then--判断传递过来的页面数据是否指定跳转页面。
    view_pager.setCurrentItem((page-1),true)
    recycler_view.smoothScrollToPosition(page-1)
  end
  Quantity.setText((view_pager.getCurrentItem()+1).."/"..pager_adapter.getCount())--当前页/总共页
 else
  print("没有传递数据哦")
end


--------****以下为底部按钮功能代码****


function 波纹(id,颜色,圆)
  import "android.content.res.ColorStateList"
  local attrsArray = {android.R.attr.selectableItemBackground}
  if 圆 then
    attrsArray = {android.R.attr.selectableItemBackgroundBorderless}
  end
  local typedArray =activity.obtainStyledAttributes(attrsArray)
  local ripple=typedArray.getResourceId(0,0)
  local Pretend=activity.Resources.getDrawable(ripple)
  Pretend.setColor(ColorStateList(int[0].class{int{}},int{颜色}))
  id.setBackground(Pretend.setColor(ColorStateList(int[0].class{int{}},int{颜色})))
end
波纹(Exit,Color.parseColor(this.uiManager.getColors().colorAccent),true)

波纹(Regard,Color.parseColor(this.uiManager.getColors().colorAccent))
波纹(Save_file,Color.parseColor(this.uiManager.getColors().colorAccent))
波纹(Share,Color.parseColor(this.uiManager.getColors().colorAccent))

local Download_List={}--创建一个表。为网络图片准备。下载后本地将本地路径存入
function Share_files(path)--分享文件。这个有问题就不是我的事了。这个是软件自带的手册里面的分享文件。
  import "net.fusionapp.core.MyFileProvider"
  import "java.io.File"
  import "androidx.core.app.ShareCompat"
  Wait.setVisibility(this.uiManager.viewPager.INVISIBLE)--关闭那个圆形框框。
  local file=File(path)
  local uri = MyFileProvider.getUriForFile(activity, MyFileProvider.getAuthor(activity), file)
  --文件的mime类型
  local mimetype = "image/*"
  ShareCompat.IntentBuilder
  .from(activity)
  .setStream(uri)
  .setType(mimetype)
  .startChooser()
end
function getSize_md5(path)--获取文件的各种信息。
  import "java.io.File"
  --字节换算
  function Byte_conversion(size)
    local GB = 1024 * 1024 * 1024;--定义GB的计算常量
    local MB = 1024 * 1024;--定义MB的计算常量
    local KB = 1024;--定义KB的计算常量
    local countResult = ""
    if(size / GB >= 1) then
      --如果当前Byte的值大于等于1GB
      countResult = string.format("%.2f",size / GB).."GB"
      return countResult
     elseif (size / MB >= 1) then
      --如果当前Byte的值大于等于1MB
      countResult = string.format("%.2f",size / MB).."MB"
      return countResult
     elseif (size / KB >= 1) then
      --如果当前Byte的值大于等于1KB
      countResult = string.format("%.2f",size / KB).."KB"
      return countResult
     else
      countResult = size.."B"
      return countResult
    end
  end
  local size=Byte_conversion(File(tostring(path)).length()).."（"..File(tostring(path)).length().."）"
  local bm=loadbitmap(path)
  if bm then
    width = bm.getWidth()
    height = bm.getHeight()

    local md5=LuaUtil.getFileMD5(tostring(path))
    if #md5==31 then
      md5="0"..md5
    end
    return path,"体积："..size.."\n\n尺寸："..width.."×"..height.."\n\nMD5："..tostring(md5)
   else
    Wait.setVisibility(this.uiManager.viewPager.INVISIBLE)--关闭那个圆形框框。
    print("图片不存在")
  end
end
function Details_picture(path,s)
  if s then
    json=require "cjson"
    local ztable=json.decode(Json)
    Wait.setVisibility(this.uiManager.viewPager.INVISIBLE)--关闭那个圆形框框。
    import"com.google.android.material.dialog.MaterialAlertDialogBuilder"
    local dialog=MaterialAlertDialogBuilder(activity)
    .setTitle("图片信息")
    .setMessage("链接/路径："..ztable[view_pager.getCurrentItem()+1].."\n\n"..s)
    .setPositiveButton("确定",nil).show()
    .findViewById(android.R.id.message).setTextIsSelectable(true)
  end
end
function Save_the_picture(path)--保存文件，逻辑为调用存储访问框架，创建新文件。通过回调获取到新创建文件路径并写入数据，因为uri2path问题较多。可能有问题。
  function 取文件名(path)
    return path:match(".+/(.+)$")
  end
  local LuaUtil = luajava.bindClass "com.androlua.LuaUtil"
  LuaUtil.copyDir(path,activity.getSharedData("图片下载目录")..取文件名(path))
  Wait.setVisibility(this.uiManager.viewPager.INVISIBLE)--关闭那个圆形框框。
  print("保存成功")
end
function Download_pictures(urli,v)--下载图片。第一个参数为路径或图片连接。第二个为第几个按钮
  import "java.io.File"
  File(tostring(activity.getExternalCacheDir()).."/temporary").mkdirs()
  local name=tostring(tostring(activity.getExternalCacheDir()).."/temporary/"..System.currentTimeMillis()..".png")
  --url 请求网址  name 文件保存路径 cookie 身份识别信息  header 请求头
  Http.download(urli,name,nil,nil,function(code,heafer)
    --code 响应代码  header 响应头
    if code==200 then
      Download_List[view_pager.getCurrentItem()+1]=name--向表中写入路径。下载完成了。
      switch (v)--通过判断不同来确认是否为哪个按钮。确定执行的功能
       case 1
        Share_files(name)
       case 2
        Save_the_picture(name)
       case 3
        task(getSize_md5,name,Details_picture)
      end
     else
      print("图片加载失败")
      Wait.setVisibility(this.uiManager.viewPager.INVISIBLE)--关闭那个圆形框框。
    end
  end)
end
if Json then --我又判断了一次。因为这后加的。
  json=require "cjson"
  local ztable=json.decode(Json)
  Share.onClick=function(v)
    Wait.setVisibility(this.uiManager.viewPager.VISIBLE)--把圆形加载框显示出来。
    if ztable[view_pager.getCurrentItem()+1]:match("https?://.+") then--判断是否为连接。
      if Download_List[view_pager.getCurrentItem()+1] then--判断表中是否有数据，也就是判断是否已经下载的图片。
        Share_files(Download_List[view_pager.getCurrentItem()+1])--已下载完直接使用。
       else
        Download_pictures(ztable[view_pager.getCurrentItem()+1],1)--未下载调用下载。并传入一表示第一个按钮。
      end
     else
      local path2=ztable[view_pager.getCurrentItem()+1]--不是连接，那就先从传入的表中获取到路径。
      local path=activity.loader.getImagePath(path2) --fa2拆包获得的代码。应该是用于判断是否为软件内的图片。否的话，返回空。
      if path ~= nil then
        path2 = path--如果是软件内的路径，那就把路径赋值
      end
      Share_files(path2)--调用   下面按钮逻辑跟这个一模一样。
    end
  end
  Save_file.onClick=function(v)
    Wait.setVisibility(this.uiManager.viewPager.VISIBLE)
    if ztable[view_pager.getCurrentItem()+1]:match("https?://.+") then
      if Download_List[view_pager.getCurrentItem()+1] then
        Save_the_picture(Download_List[view_pager.getCurrentItem()+1])
       else
        Download_pictures(ztable[view_pager.getCurrentItem()+1],2)
      end
     else
      local path2=ztable[view_pager.getCurrentItem()+1]
      local path=activity.loader.getImagePath(path2) --fa2拆包获得的代码。应该是用于判断是否为软件内的图片。否的话，返回空。
      if path ~= nil then
        path2 = path
      end
      Save_the_picture(path2)
    end
  end
  Regard.onClick=function(v)
    Wait.setVisibility(this.uiManager.viewPager.VISIBLE)--显示那个圆形框框。
    if ztable[view_pager.getCurrentItem()+1]:match("https?://.+") then
      if Download_List[view_pager.getCurrentItem()+1] then
        task(getSize_md5,Download_List[view_pager.getCurrentItem()+1],Details_picture)
       else
        Download_pictures(ztable[view_pager.getCurrentItem()+1],3)
      end
     else
      local path2=ztable[view_pager.getCurrentItem()+1]
      local path=activity.loader.getImagePath(path2) --fa2拆包获得的代码。应该是用于判断是否为软件内的图片。否的话，返回空。
      if path ~= nil then
        path2 = path
      end
      task(getSize_md5,path2,Details_picture)--大图片还是卡 丢在异步线程处
    end
  end
end

Exit.onClick=function(v)
  activity.finish()--退出
end
bottom.onClick=function(v)
end--这两个没啥用，主要用途是拦截图片点击事件
top.onClick=function(v)
end

function onResume()--隐藏虚拟按键
  activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_HIDE_NAVIGATION|View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY)
end