--获取更新信息
package_name=activity.getPackageManager().getPackageInfo(activity.getPackageName(),1)
version_name=tostring(package_name.versionName)
version_code=tonumber(package_name.versionCode)

--更新弹窗
function 更新弹窗(当前版本,当前版本号,最新版本,最新版本号,更新日期,安装包大小,更新日志,下载链接)
  local dialog_layout=--弹窗框架
  {
    LinearLayout;--线性控件
    orientation='vertical';--布局方向
    layout_width='fill';--布局宽度
    layout_height='fill';--布局高度
    gravity='center';--重力
    --左:left 右:right 中:center 顶:top 底:bottom
    {
      MaterialCardView;--卡片控件
      layout_width='85%w';--卡片宽度
      layout_height='fill';--卡片高度
      cardBackgroundColor=窗体背景色;--卡片颜色
      layout_margin='0dp';--卡片边距
      cardElevation='0dp';--卡片阴影
      radius='5dp';--卡片圆角
      {
        LinearLayout;--线性控件
        orientation='vertical';--布局方向
        layout_width='fill';--布局宽度
        layout_height='fill';--布局高度
        gravity='center';--重力
        --左:left 右:right 中:center 顶:top 底:bottom
        layout_margin='10dp';--控件外边距
        {
          TextView;--文本控件
          layout_width='fill';--控件宽度
          layout_height='wrap';--控件高度
          text='发现新版本';--显示文字
          textSize='20sp';--文字大小
          textColor=强调色;--文字颜色
          --id='Text';--设置控件ID
          --singleLine=true;--设置单行输入
          --ellipsize='end';--多余文字用省略号显示
          --start 开始 middle 中间 end 结尾
          --Typeface=Typeface.DEFAULT;--字体
          --textIsSelectable=true;--文本可复制
          --style="?android:attr/buttonBarButtonStyle";--点击特效
          gravity='center';--重力
          --左:left 右:right 中:center 顶:top 底:bottom
          layout_margin='5dp';--控件外边距
        };
        {
          LinearLayout;--线性控件
          orientation='horizontal';--布局方向
          layout_width='fill';--布局宽度
          layout_height='wrap';--布局高度
          {
            TextView;--文本控件
            layout_width='wrap';--控件宽度
            layout_height='wrap';--控件高度
            text="当前版本："..当前版本.."("..当前版本号..")";--显示文字
            textSize='14sp';--文字大小
            textColor=主文本色;--文字颜色
            --id='Text';--设置控件ID
            --singleLine=true;--设置单行输入
            --ellipsize='end';--多余文字用省略号显示
            --start 开始 middle 中间 end 结尾
            --Typeface=Typeface.DEFAULT;--字体
            --textIsSelectable=true;--文本可复制
            --style="?android:attr/buttonBarButtonStyle";--点击特效
            gravity='center|left';--重力
            --左:left 右:right 中:center 顶:top 底:bottom
            layout_margin='2dp';--控件外边距
          };
          {
            TextView;--文本控件
            layout_width='fill';--控件宽度
            layout_height='wrap';--控件高度
            text="最新版本："..最新版本.."("..最新版本号..")";--显示文字
            textSize='14sp';--文字大小
            textColor=主文本色;--文字颜色
            --id='Text';--设置控件ID
            --singleLine=true;--设置单行输入
            --ellipsize='end';--多余文字用省略号显示
            --start 开始 middle 中间 end 结尾
            --Typeface=Typeface.DEFAULT;--字体
            --textIsSelectable=true;--文本可复制
            --style="?android:attr/buttonBarButtonStyle";--点击特效
            gravity='center|right';--重力
            --左:left 右:right 中:center 顶:top 底:bottom
            layout_margin='2dp';--控件外边距
          };
        };
        {
          TextView;--文本控件
          layout_width='fill';--控件宽度
          layout_height='wrap';--控件高度
          text="更新日期："..更新日期;--显示文字
          textSize='14sp';--文字大小
          textColor=副文本色;--文字颜色
          --id='Text';--设置控件ID
          --singleLine=true;--设置单行输入
          --ellipsize='end';--多余文字用省略号显示
          --start 开始 middle 中间 end 结尾
          --Typeface=Typeface.DEFAULT;--字体
          --textIsSelectable=true;--文本可复制
          --style="?android:attr/buttonBarButtonStyle";--点击特效
          gravity='center|left';--重力
          --左:left 右:right 中:center 顶:top 底:bottom
          layout_margin='2dp';--控件外边距
        };
        {
          TextView;--文本控件
          layout_width='fill';--控件宽度
          layout_height='wrap';--控件高度
          text="安装包大小："..安装包大小;--显示文字
          textSize='14sp';--文字大小
          textColor=副文本色;--文字颜色
          --id='Text';--设置控件ID
          --singleLine=true;--设置单行输入
          --ellipsize='end';--多余文字用省略号显示
          --start 开始 middle 中间 end 结尾
          --Typeface=Typeface.DEFAULT;--字体
          --textIsSelectable=true;--文本可复制
          --style="?android:attr/buttonBarButtonStyle";--点击特效
          gravity='center|left';--重力
          --左:left 右:right 中:center 顶:top 底:bottom
          layout_margin='2dp';--控件外边距
        };
        {
          TextView;--文本控件
          layout_width='fill';--控件宽度
          layout_height='wrap';--控件高度
          text='更新内容：\n'..更新日志;--显示文字
          textSize='15sp';--文字大小
          textColor=主文本色;--文字颜色
          --id='Text';--设置控件ID
          --singleLine=true;--设置单行输入
          --ellipsize='end';--多余文字用省略号显示
          --start 开始 middle 中间 end 结尾
          --Typeface=Typeface.DEFAULT;--字体
          --textIsSelectable=true;--文本可复制
          --style="?android:attr/buttonBarButtonStyle";--点击特效
          gravity='center|left';--重力
          --左:left 右:right 中:center 顶:top 底:bottom
          layout_margin='2dp';--控件外边距
        };
        {
          TextView;--文本控件
          layout_width='fill';--控件宽度
          layout_height='wrap';--控件高度
          text='';--显示文字
          textSize='14sp';--文字大小
          textColor=副文本色;--文字颜色
          id='download_text';--设置控件ID
          --singleLine=true;--设置单行输入
          --ellipsize='end';--多余文字用省略号显示
          --start 开始 middle 中间 end 结尾
          --Typeface=Typeface.DEFAULT;--字体
          --textIsSelectable=true;--文本可复制
          --style="?android:attr/buttonBarButtonStyle";--点击特效
          gravity='center|left';--重力
          --左:left 右:right 中:center 顶:top 底:bottom
          layout_margin='2dp';--控件外边距
          visibility=View.GONE;
        };
        {
          ProgressBar;--进度条控件
          layout_width="fill";--布局宽度
          layout_height="wrap";--布局高度
          --Max='';--设置最大进度
          --Progress='';--设置当前进度
          --SecondaryProgress='';--设置第二进度
          --indeterminate=false;--设置是否为不明确进度进度条,true为明确
          --indeterminate=false;--模糊模式,true为开启
          --style='?android:attr/progressBarStyleLarge';--超大号圆形风格
          --style='?android:attr/progressBarStyleSmall';--小号风格
          --style='?android:attr/progressBarStyleSmallTitle';--标题型风格
          style='?android:attr/progressBarStyleHorizontal';--长形进度条
          id='download_progress';--设置控件ID
          layout_margin='5dp';--控件外边距
          visibility=View.GONE;
        };
        {
          LinearLayout;--线性控件
          orientation='horizontal';--布局方向
          layout_width='fill';--布局宽度
          layout_height='wrap';--布局高度
          gravity='center';--重力
          --左:left 右:right 中:center 顶:top 底:bottom
          {
            TextView;--文本控件
            layout_width='wrap';--控件宽度
            layout_height='wrap';--控件高度
            text='取消';--显示文字
            textSize='14sp';--文字大小
            textColor=副文本色;--文字颜色
            id='cancel';--设置控件ID
            singleLine=true;--设置单行输入
            --ellipsize='end';--多余文字用省略号显示
            --start 开始 middle 中间 end 结尾
            --Typeface=Typeface.DEFAULT;--字体
            --textIsSelectbale=true;--文本可复制
            --style="?android:attr/buttonBarButtonStyle";--点击特效
            gravity='center';--重力
            --左:left 右:right 中:center 顶:top 底:bottom
            layout_margin='10dp';--控件外边距
          };
          {
            MaterialCardView;--卡片控件
            layout_width='30%w';--卡片宽度
            layout_height='wrap';--卡片高度
            cardBackgroundColor=卡片色;--卡片颜色
            layout_margin='7dp';--卡片边距
            cardElevation='0dp';--卡片阴影
            radius='5dp';--卡片圆角
            id='browser';--设置控件ID
            {
              TextView;--文本控件
              layout_width='fill';--控件宽度
              layout_height='fill';--控件高度
              text='浏览器下载';--显示文字
              textSize='14sp';--文字大小
              textColor=主文本色;--文字颜色
              --id='Text';--设置控件ID
              singleLine=true;--设置单行输入
              --ellipsize='end';--多余文字用省略号显示
              --start 开始 middle 中间 end 结尾
              --Typeface=Typeface.DEFAULT;--字体
              --textIsSelectbale=true;--文本可复制
              --style="?android:attr/buttonBarButtonStyle";--点击特效
              gravity='center';--重力
              --左:left 右:right 中:center 顶:top 底:bottom
              layout_margin='10dp';--控件外边距
            };
          };
          {
            MaterialCardView;--卡片控件
            layout_width='30%w';--卡片宽度
            layout_height='wrap';--卡片高度
            cardBackgroundColor=强调色;--卡片颜色
            layout_margin='7dp';--卡片边距
            cardElevation='0dp';--卡片阴影
            radius='5dp';--卡片圆角
            id='download';--设置控件ID
            {
              TextView;--文本控件
              layout_width='fill';--控件宽度
              layout_height='fill';--控件高度
              text='立即更新';--显示文字
              textSize='14sp';--文字大小
              textColor=主色;--文字颜色
              --id='Text';--设置控件ID
              singleLine=true;--设置单行输入
              --ellipsize='end';--多余文字用省略号显示
              --start 开始 middle 中间 end 结尾
              --Typeface=Typeface.DEFAULT;--字体
              --textIsSelectbale=true;--文本可复制
              --style="?android:attr/buttonBarButtonStyle";--点击特效
              gravity='center';--重力
              --左:left 右:right 中:center 顶:top 底:bottom
              layout_margin='10dp';--控件外边距
            };
          };
        };
      };
    };
  };
  local dialog=AlertDialog.Builder(this).show()
  --dialog.setCancelable(false)--禁用返回键
  dialog.setCanceledOnTouchOutside(false)
  dialog.getWindow().setContentView(loadlayout(dialog_layout))
  import"android.graphics.drawable.ColorDrawable"
  dialog.getWindow().setBackgroundDrawable(ColorDrawable(0x00000000));--背景透明
  dialog.getWindow().clearFlags(WindowManager.LayoutParams.FLAG_ALT_FOCUSABLE_IM);--支持输入法
  --dialog.dismiss()--关闭
  --dialog.show()--显示
  cancel.onClick=function()
    dialog.dismiss()
  end
  browser.onClick=function()
    import "android.content.Intent"
    import "android.net.Uri"
    activity.startActivity(Intent("android.intent.action.VIEW",Uri.parse(下载链接)))
  end
  download.onClick=function()
    local dir=activity.getSharedData("下载目录")
    if(下载目录:find("/sdcard"))then
      下载目录=下载目录:match("/sdcard(.+)")
    end
    if(下载目录:find("/storage/emulated/0"))then
      下载目录=下载目录:match("/storage/emulated/0(.+)")
    end
    下载监听(下载链接,下载目录,"粼光应用商店_"..最新版本..".apk")
    download_text.setVisibility(View.VISIBLE)
    download_progress.setVisibility(View.VISIBLE)
    download.getChildAt(0).setText("下载中")
    download.onClick=function()end
  end
  if(File(activity.getSharedData("下载目录").."粼光应用商店_"..最新版本..".apk").exists())then
    download.getChildAt(0).setText("立即安装")
    download.onClick=function()
      安装应用(activity.getSharedData("下载目录").."粼光应用商店_"..最新版本..".apk")
    end
  end
end

function 下载监听(url,path,filename)
  import "android.content.Context"
  import "android.net.Uri"
  import "android.service.voice.VoiceInteractionSession$Request"
  local download_manager=activity.getSystemService(Context.DOWNLOAD_SERVICE)
  local request=DownloadManager.Request(Uri.parse(url))
  request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE)--设置通知栏的显示
  request.setDestinationInExternalPublicDir(path,filename)--设置下载路径
  request.setVisibleInDownloadsUi(true)--下载的文件可以被系统的Downloads应用扫描到并管理
  request.setTitle(filename)--设置通知栏标题
  request.setDescription("将下载到"..path)--设置通知栏消息
  request.setShowRunningNotification(true)--设置显示下载进度提示
  local download_id=download_manager.enqueue(request)
  local download_manager=activity.getSystemService(Context.DOWNLOAD_SERVICE)
  local query=DownloadManager.Query()
  local cursor=download_manager.query(query)
  if(not cursor.moveToFirst())then
    cursor.close()
    return
  end
  local ti=Ticker()
  ti.Period=10--刷新频率
  ti.onTick=function()
    local cursor = download_manager.query(query)
    if(not cursor.moveToFirst())then
      cursor.close()
      return
    end
    local id=cursor.getLong(cursor.getColumnIndex(DownloadManager.COLUMN_ID))--下载id
    local status=cursor.getInt(cursor.getColumnIndex(DownloadManager.COLUMN_STATUS))--下载请求的状态
    local total_size=cursor.getLong(cursor.getColumnIndex(DownloadManager.COLUMN_TOTAL_SIZE_BYTES))--下载文件的总字节大小
    local downloaded_so_far=cursor.getLong(cursor.getColumnIndex(DownloadManager.COLUMN_BYTES_DOWNLOADED_SO_FAR))--已下载的字节大小
    local file_name=cursor.getLong(cursor.getColumnIndex(DownloadManager.COLUMN_LOCAL_FILENAME))--文件名 string类型
    local file_uri=cursor.getLong(cursor.getColumnIndex(DownloadManager.COLUMN_LOCAL_URI))--下载链接 string类型
    local title=cursor.getLong(cursor.getColumnIndex(DownloadManager.COLUMN_TITLE))--下载标题 string类型
    local function 转换(a)
      if(a>=1024*1024 and a<=(1024*1024*1024)-1)then
        s=(a/1024)/1024
        s=string.format('%.2f', s).."MB"
       elseif(a>=1024 and a<=(1024*1024)-1)then
        s=a/1024
        s=string.format('%.2f', s).."KB"
       elseif(a<=1023)then
        s=string.format('%.2f', a).."K"
       elseif(a>=1024*1024*1024)then
        s=a/(1024*1024*1024)
        s=string.format('%.2f', s).."GB"
      end
      return s
    end
    if(download_id and download_id==id and total_size and total_size>0)then
      switch status
        --下载暂停
       case DownloadManager.STATUS_PAUSED
        local reason=cursor.getInt(cursor.getColumnIndex(DownloadManager.COLUMN_REASON))
        switch reason
         case DownloadManager.PAUSED_QUEUED_FOR_WIFI
          reason_name="等待WiFi"
         case DownloadManager.PAUSED_WAITING_FOR_NETWORK
          reason_name="等待连接"
         case DownloadManager.PAUSED_WAITING_TO_RETRY
          reason_name="由于重重原因导致下载暂停，等待重试"
         case DownloadManager.PAUSED_UNKNOWN
          reason_name="未知问题Unknown"
        end
        download_text.setText("下载暂停，"..reason_name)
        --正在下载
       case DownloadManager.STATUS_RUNNING
        download_text.setText("已下载"..转换(downloaded_so_far).."，共"..转换(total_size).."，"..string.format('%.2f',(downloaded_so_far/total_size*100)).."%")
        download_progress.setProgress(tointeger(downloaded_so_far/total_size*100))
        --下载完成
       case DownloadManager.STATUS_SUCCESSFUL
        download_text.setText("下载完成")
        download_progress.setProgress(100)
        安装应用(activity.getSharedData("下载目录")..filename)
        download.getChildAt(0).setText("立即安装")
        download.onClick=function()
          安装应用(activity.getSharedData("下载目录")..filename)
        end
        cursor.close()
        ti.stop()
        --下载失败
       case DownloadManager.STATUS_FAILED
        local reason=cursor.getInt(cursor.getColumnIndex(DownloadManager.COLUMN_REASON))
        switch reason
         case DownloadManager.ERROR_CANNOT_RESUME
          reason_name="不能够继续，由于一些其他原因"
         case DownloadManager.ERROR_DEVICE_NOT_FOUND
          reason_name="外部存储设备没有找到"
         case DownloadManager.ERROR_FILE_ALREADY_EXISTS
          reason_name="要下载的文件已经存在了，要想重新下载需要删除原来的文件"
         case DownloadManager.ERROR_FILE_ERROR
          reason_name="可能由于SD卡原因导致了文件错误"
         case DownloadManager.ERROR_HTTP_DATA_ERROR
          reason_name="在Http传输过程中出现了问题。"
         case DownloadManager.ERROR_INSUFFICIENT_SPACE
          reason_name="由于SD卡空间不足造成的。"
         case DownloadManager.ERROR_TOO_MANY_REDIRECTS
          reason_name="这个Http有太多的重定向，导致无法正常下载"
         case DownloadManager.ERROR_UNHANDLED_HTTP_CODE
          reason_name="无法获取http出错的原因，比如说远程服务器没有响应"
         case DownloadManager.ERROR_UNKNOWN
          reason_name="未知问题Unknown"
        end
        download_text.setText("下载失败，"..reason_name)
        cursor.close()
        ti.stop()
      end
    end
  end
  ti.start()
end

function 安装应用(path)
  --检查储存和安装应用权限
  if(activity.getPackageManager().canRequestPackageInstalls() and activity.checkSelfPermission("android.permission.READ_EXTERNAL_STORAGE")==0)then
    --如果有权限就安装
    import "android.content.Intent"
    import "android.content.FileProvider"
    local intent=Intent("android.intent.action.VIEW").addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
    local uri=FileProvider.getUriForFile(activity,activity.getPackageName()..".FileProvider",File(path))
    intent.setDataAndType(uri,"application/vnd.android.package-archive")
    activity.startActivity(intent)
   else
    --如果没有权限就申请
    弹出消息("需要给予安装与存储读取权限")
    import "android.content.Intent"
    import "android.provider.Settings"
    import "android.net.Uri"
    activity.startActivity(Intent(Settings.ACTION_MANAGE_UNKNOWN_APP_SOURCES,Uri.parse("package:"..activity.getPackageName())))
    activity.requestPermissions({"android.permission.READ_EXTERNAL_STORAGE","android.permission.WRITE_EXTERNAL_STORAGE"},1)
  end
end