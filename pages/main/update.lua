--获取更新信息
packageName=activity.getPackageManager().getPackageInfo(activity.getPackageName(),1)
versionName=tostring(packageName.versionName)
versionCode=tonumber(packageName.versionCode)

--更新弹窗
function 更新弹窗(当前版本,当前版本号,最新版本,最新版本号,更新日期,安装包大小,更新日志,下载链接)
  local dialog_layout=--弹窗框架
  {
    MaterialCardView;--卡片控件
    layout_width='85%w';--卡片宽度
    layout_height='fill';--卡片高度
    cardBackgroundColor=windowBackground;--卡片颜色
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
        layout_width='40%w';--控件宽度
        layout_height='wrap';--控件高度
        text='发现新版本';--显示文字
        textSize='20sp';--文字大小
        textColor=colorAccent;--文字颜色
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
        ScrollView;--纵向滑动控件
        layout_width="fill";--布局宽度
        layout_height="fill";--布局高度
        verticalScrollBarEnabled=false;--隐藏纵向滑条
        overScrollMode=View.OVER_SCROLL_NEVER,--隐藏圆弧阴影
        layout_weight='1';--权重值
        {
          LinearLayout;--线性控件
          orientation='vertical';--布局方向
          layout_width='fill';--布局宽度
          layout_height='fill';--布局高度
          gravity='center';--重力
          --左:left 右:right 中:center 顶:top 底:bottom
          {
            TextView;--文本控件
            layout_width='fill';--控件宽度
            layout_height='wrap';--控件高度
            text="当前版本："..当前版本.."("..当前版本号..")";--显示文字
            textSize='14sp';--文字大小
            textColor=textColorPrimary;--文字颜色
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
            textColor=textColorPrimary;--文字颜色
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
            text="更新日期："..更新日期;--显示文字
            textSize='14sp';--文字大小
            textColor=textColorSecondary;--文字颜色
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
            textColor=textColorSecondary;--文字颜色
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
            textColor=textColorPrimary;--文字颜色
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
        };
      };
      {
        TextView;--文本控件
        layout_width='fill';--控件宽度
        layout_height='wrap';--控件高度
        text='';--显示文字
        textSize='14sp';--文字大小
        textColor=textColorSecondary;--文字颜色
        id='downloadText';--设置控件ID
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
        id='downloadProgress';--设置控件ID
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
          textColor=textColorSecondary;--文字颜色
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
            textColor=textColorPrimary;--文字颜色
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
          cardBackgroundColor=colorAccent;--卡片颜色
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
            textColor=colorPrimary;--文字颜色
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
  local dialog=MaterialAlertDialogBuilder(activity).show()
  --dialog.setCancelable(false)--禁用返回键
  dialog.setCanceledOnTouchOutside(false)
  dialog.getWindow().setContentView(loadlayout(dialog_layout))
  --dialog.dismiss()--关闭
  --dialog.show()--显示
  local 下载目录=activity.getSharedData("downloadPath")
  cancel.onClick=function()
    dialog.dismiss()
  end
  browser.onClick=function()
    import "android.content.Intent"
    import "android.net.Uri"
    activity.startActivity(Intent("android.intent.action.VIEW",Uri.parse(下载链接)))
  end
  download.onClick=function()
    下载监听(下载链接,下载目录,"粼光应用商店_"..最新版本..".apk")
    downloadText.setVisibility(View.VISIBLE)
    downloadProgress.setVisibility(View.VISIBLE)
    download.getChildAt(0).setText("下载中")
    download.onClick=function()end
  end
  if(File(下载目录.."粼光应用商店_"..最新版本..".apk").exists())then
    download.getChildAt(0).setText("立即安装")
    download.onClick=function()
      安装应用(下载目录.."粼光应用商店_"..最新版本..".apk")
    end
  end
end

function 下载监听(url,path,filename)
  import "android.content.Context"
  import "android.net.Uri"
  import "android.text.format.Formatter"
  import "java.io.File"
  local downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE)
  local request=DownloadManager.Request(Uri.parse(url))
  request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE)--设置通知栏的显示
  request.setDestinationUri(Uri.fromFile(File(path,filename)))--设置下载路径
  request.setVisibleInDownloadsUi(true)--下载的文件可以被系统的Downloads应用扫描到并管理
  request.setTitle(filename)--设置通知栏标题
  request.setDescription(url)--设置通知栏消息
  request.setShowRunningNotification(true)--设置显示下载进度提示
  local downloadId=downloadManager.enqueue(request)
  local downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE)
  local query=DownloadManager.Query()
  local cursor=downloadManager.query(query)
  if(not cursor.moveToFirst())then
    cursor.close()
    return
  end
  local ti=Ticker()
  ti.Period=10--刷新频率
  ti.onTick=function()
    local cursor = downloadManager.query(query)
    if(not cursor.moveToFirst())then
      cursor.close()
      return
    end
    local id=cursor.getLong(cursor.getColumnIndex(DownloadManager.COLUMN_ID))--下载id
    local status=cursor.getInt(cursor.getColumnIndex(DownloadManager.COLUMN_STATUS))--下载请求的状态
    local totalSize=cursor.getLong(cursor.getColumnIndex(DownloadManager.COLUMN_TOTAL_SIZE_BYTES))--下载文件的总字节大小
    local downloadedSoFar=cursor.getLong(cursor.getColumnIndex(DownloadManager.COLUMN_BYTES_DOWNLOADED_SO_FAR))--已下载的字节大小
    local fileName=cursor.getLong(cursor.getColumnIndex(DownloadManager.COLUMN_LOCAL_FILENAME))--文件名 string类型
    local fileUri=cursor.getLong(cursor.getColumnIndex(DownloadManager.COLUMN_LOCAL_URI))--下载链接 string类型
    local title=cursor.getLong(cursor.getColumnIndex(DownloadManager.COLUMN_TITLE))--下载标题 string类型
    if(downloadId and downloadId==id and totalSize and totalSize>0)then
      switch status
        --下载暂停
       case DownloadManager.STATUS_PAUSED
        local reason=cursor.getInt(cursor.getColumnIndex(DownloadManager.COLUMN_REASON))
        switch reason
         case DownloadManager.PAUSED_QUEUED_FOR_WIFI
          reasonName="等待WiFi"
         case DownloadManager.PAUSED_WAITING_FOR_NETWORK
          reasonName="等待连接"
         case DownloadManager.PAUSED_WAITING_TO_RETRY
          reasonName="由于重重原因导致下载暂停，等待重试"
         case DownloadManager.PAUSED_UNKNOWN
          reasonName="未知问题Unknown"
        end
        downloadText.setText("下载暂停，"..reasonName)
        --正在下载
       case DownloadManager.STATUS_RUNNING
        downloadText.setText("已下载"..Formatter.formatFileSize(activity,downloadedSoFar).."，共"..Formatter.formatFileSize(activity,totalSize).."，"..string.format('%.2f',(downloadedSoFar/totalSize*100)).."%")
        downloadProgress.setProgress(tointeger(downloadedSoFar/totalSize*100))
        --下载完成
       case DownloadManager.STATUS_SUCCESSFUL
        downloadText.setText("下载完成")
        downloadProgress.setProgress(100)
        install(path..filename)
        download.getChildAt(0).setText("立即安装")
        download.onClick=function()
          install(path..filename)
        end
        cursor.close()
        ti.stop()
        --下载失败
       case DownloadManager.STATUS_FAILED
        local reason=cursor.getInt(cursor.getColumnIndex(DownloadManager.COLUMN_REASON))
        switch reason
         case DownloadManager.ERROR_CANNOT_RESUME
          reasonName="不能够继续，由于一些其他原因"
         case DownloadManager.ERROR_DEVICE_NOT_FOUND
          reasonName="外部存储设备没有找到"
         case DownloadManager.ERROR_FILE_ALREADY_EXISTS
          reasonName="要下载的文件已经存在了，要想重新下载需要删除原来的文件"
         case DownloadManager.ERROR_FILE_ERROR
          reasonName="可能由于SD卡原因导致了文件错误"
         case DownloadManager.ERROR_HTTP_DATA_ERROR
          reasonName="在Http传输过程中出现了问题。"
         case DownloadManager.ERROR_INSUFFICIENT_SPACE
          reasonName="由于SD卡空间不足造成的。"
         case DownloadManager.ERROR_TOO_MANY_REDIRECTS
          reasonName="这个Http有太多的重定向，导致无法正常下载"
         case DownloadManager.ERROR_UNHANDLED_HTTP_CODE
          reasonName="无法获取http出错的原因，比如说远程服务器没有响应"
         case DownloadManager.ERROR_UNKNOWN
          reasonName="未知问题Unknown"
        end
        downloadText.setText("下载失败，"..reasonName)
        cursor.close()
        ti.stop()
      end
    end
  end
  ti.start()
end