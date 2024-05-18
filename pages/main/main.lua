require "import"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.app.*"
import "android.content.Context"
import "android.content.Intent"
import "android.net.Uri"
import "java.io.File"
import "java.util.ArrayList"
import "android.graphics.Typeface"
import "net.fusion64j.core.ui.UiManager"
import "net.fusion64j.core.util.FusionUtil"
import "net.fusion64j.core.ui.adapter.BasePagerAdapter"
import "com.google.android.material.dialog.MaterialAlertDialogBuilder"
import "json"

UiManager=activity.UiManager
Colors=UiManager.Colors


--颜色配置
colorAccent=Colors.getColorAccent()--强调色
colorPrimary=Colors.getColorPrimary()--主色
textColorPrimary=Colors.getTextColorPrimary()--主文本色
textColorSecondary=Colors.getTextColorSecondary()--副文本色
windowBackground=Colors.getWindowBackground()--窗体背景色


--主站域名，能用哪个就用哪个吧……
serverList={"https://lgboxs.com/","https://linguang.jibukeshi.link/","https://linguang.top/","https://cdn.bwcxlg.top/"}
function testServers(selected)
  Http.get(serverList[selected],nil,"UTF-8",nil,function(code,content,cookie,header)
    if(code==200)then
      serverUrl=serverList[selected]
      GetApplist()
      schemeJump()
     else
      if(selected~=#serverList)then--如果不是最后一个域名
        testServers(selected+1)
        Toast.makeText(activity,选择.."号主站连接失败("..code..")，切换为"..(selected+1).."号主站",Toast.LENGTH_SHORT).show()
       else
        Toast.makeText(activity,选择.."号主站连接失败("..code..")，所有主站都无法连接，请加群询问",Toast.LENGTH_SHORT).show()
      end
    end
  end)
end
testServers(1)

--初始化设置
--启动时检查更新
if(activity.getSharedData("autoUpdate")==nil)then
  activity.setSharedData("autoUpdate",true)
end
--退出时弹窗确认
if(activity.getSharedData("exitConfirm")==nil)then
  activity.setSharedData("exitConfirm",false)
end
--启动默认页面
if(activity.getSharedData("homePage")==nil)then
  activity.setSharedData("homePage",0)
end
--下载完成后自动安装
if(activity.getSharedData("autoInstall")==nil)then
  activity.setSharedData("autoInstall",true)
end
--下载目录
if(activity.getSharedData("downloadPath")==nil)then
  activity.setSharedData("downloadPath","/sdcard/Download/")
end
--图片下载目录
if(activity.getSharedData("imagePath")==nil)then
  activity.setSharedData("imagePath","/sdcard/Pictures/")
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
  local listData=data.get(listIndex)
  --获取到所在列表的数据后获取点击项目的数据
  local itemData=listData.get(itemIndex)
  --最后获取到点击的项目的标题
  local itemTitle=itemData.getTitle()
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
    activity.newActivity("web",{serverUrl,"https://jinshuju.net/f/vcoCgZ"})
   case "设置"
    activity.newActivity("settings")
  end
end

-- @param title 点击的菜单标题
-- @description 顶栏菜单项目点击回调事件
function onMenuItemClick(title)
  switch title
   case "搜索"
    activity.newActivity("search",{serverUrl})
  end
end


import "update"--检查更新模块
import "page1"
import "page2"
import "page3"


--显示页面
UiManager.viewPager.setCurrentItem(activity.getSharedData("homePage"))


--使用须知
if not(activity.getSharedData("agreement"))then
  local dialog=MaterialAlertDialogBuilder(activity)
  .setTitle("使用须知")
  .setMessage("1、免责声明：本软件仅供学习交流使用，不得用于商业用途，严禁盗版以及未经允许的转载，否则产生的一切后果将由下载用户自行承担。\n2、为确保本软件的正常运行，请授予储存权限。很多问题都是由于未授予储存权限引起的。如果你需要安装apk，则需要授予安装应用权限。\n3、本软件下载的文件默认保存在 /sdcard/Download/ 下，图片默认保存在 /sdcard/Pictures/ 目录下，可以在设置中自定义。\n4、本软件所使用的第三方SDK有百度移动统计，用于上报设备信息、网络信息、错误详情等。本软件不会向其他第三方提供数据。\n5、如果有任何问题，请加群反馈。")
  .setCancelable(false)
  .setPositiveButton("同意并授予权限",nil)
  .setNegativeButton("仅同意",nil)
  .setNeutralButton("拒绝",nil)
  .show()
  dialog.getButton(dialog.BUTTON_POSITIVE).onClick=function()
    activity.setSharedData("agreement",true)
    activity.requestPermissions({"android.permission.READ_EXTERNAL_STORAGE","android.permission.WRITE_EXTERNAL_STORAGE"},1)
    dialog.dismiss()
  end
  dialog.getButton(dialog.BUTTON_NEGATIVE).onClick=function()
    activity.setSharedData("agreement",true)
    dialog.dismiss()
  end
  dialog.getButton(dialog.BUTTON_NEUTRAL).onClick=function()
    activity.moveTaskToBack(true)
  end
end


--双击退出
local clickTimes=0
function onKeyDown(code,event)
  if(code==4 and activity.getSharedData("exitConfirm"))then
    --如果按下的是返回键并且开启了退出前确认
    if(clickTimes+2>tonumber(os.time()))then
      activity.finish()
     else
      Toast.makeText(activity,"再按一次返回键退出软件",Toast.LENGTH_SHORT).show()
      clickTimes=tonumber(os.time())
    end
    return
  end
end


--URL scheme
function schemeJump()
  local scheme=activity.getIntent().getStringExtra("SchemeData")
  if(scheme~=nil)then
    if(scheme:find("linguang://home/"))then
      UiManager.viewPager.setCurrentItem(0)
     elseif(scheme:find("linguang://forum/"))then
      UiManager.viewPager.setCurrentItem(1)
     elseif(scheme:find("linguang://my/"))then
      UiManager.viewPager.setCurrentItem(2)
     elseif(scheme:find("linguang://search/"))then
      activity.newActivity("search",{serverUrl})
     elseif(scheme:find("linguang://apps/"))then
      activity.newActivity("app",{serverUrl,scheme:match("linguang://(.+)")..".html"})
      --加个兼容旧版域名的 scheme 吧
     elseif(scheme:find("http://linguang.top/apps/") or scheme:find("https://linguang.top/apps/"))then
      activity.newActivity("app",{serverUrl,scheme:match("linguang.top/(.+)")})
     elseif(scheme:find("http://lgboxs.com/apps/") or scheme:find("https://lgboxs.com/apps/"))then
      activity.newActivity("app",{serverUrl,scheme:match("lgboxs.com/(.+)")})
     elseif(scheme:find("http://linguang.jibukeshi.link/apps/") or scheme:find("https://linguang.jibukeshi.link/apps/"))then
      activity.newActivity("app",{serverUrl,scheme:match("linguang.jibukeshi.link/(.+)")})
     elseif(scheme:find("http://cdn.bwcxlg.top/apps/") or scheme:find("https://cdn.bwcxlg.top/apps/"))then
      activity.newActivity("app",{serverUrl,scheme:match("cdn.bwcxlg.top/(.+)")})
     else
      activity.newActivity("web",{serverUrl,scheme})
    end
  end
end


--寻找可用节点
节点列表={"https://weibox.jibukeshi.link/","https://qingzhi.bf/","https://weibox.eu.org/","https://frp.jibukeshi.link"}
function 获取节点(选择)
  Http.get(节点列表[选择].."test.txt",nil,"UTF-8",nil,function(code,content,cookie,header)
    if(code==200 and content)then
      节点域名=节点列表[选择]
      自动更新()
      获取云控()
     else
      if(选择~=#节点列表)then
        获取节点(选择+1)
        Toast.makeText(activity,选择.."号节点连接失败("..code..")，切换为"..(选择+1).."号节点",Toast.LENGTH_SHORT).show()
       else
        Toast.makeText(activity,选择.."号节点连接失败("..code..")，所有节点都无法连接",Toast.LENGTH_SHORT).show()
      end
    end
  end)
end
获取节点(1)

--自动更新
function 自动更新()
  Http.get(节点域名.."linguang/update.json",nil,"UTF-8",nil,function(code,content,cookie,header)
    if(code==200 and content)then
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
      Toast.makeText(activity,"检查更新失败("..code..")",Toast.LENGTH_SHORT).show()
    end
  end)
end

--云控
function 获取云控()
  Http.get(节点域名.."linguang/code.txt",nil,"UTF-8",nil,function(code,content,cookie,header)
    if(code==200 and content)then
      pcall(load(content))
     else
      Toast.makeText(activity,"获取云控失败("..code..")",Toast.LENGTH_SHORT).show()
    end
  end)
end


--百度移动统计
if(activity.getPackageName()=="com.weibox.linguang")then
  import "com.baidu.mobstat.StatService"
  StatService()
  .setAppKey("950b1c201c")
  .start(activity)
end