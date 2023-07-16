function download(url,path,filename)
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
  request.setDescription("将下载到"..path)--设置通知栏消息
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
        cursor.close()
        ti.stop()
        downloadText.setText("下载完成")
        downloadProgress.setProgress(100)
        if(activity.getSharedData("自动安装"))then
          install(path..filename)
        end
        button.setText("立即安装")
        button.onClick=function()
          install(path..filename)
        end
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
        --下载完成的动作
       case DownloadManager.ACTION_DOWNLOAD_COMPLETE
        --当用户单击notification中下载管理的某项时触发
       case DownloadManager.ACTION_NOTIFICATION_CLICKED
        --查看下载项
       case DownloadManager.ACTION_VIEW_DOWNLOADS
      end
    end
  end
  ti.start()
end

function install(path)
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
    Toast.makeText(activity,"需要给予安装与存储读取权限",Toast.LENGTH_SHORT).show()
    import "android.content.Intent"
    import "android.provider.Settings"
    import "android.net.Uri"
    activity.startActivity(Intent(Settings.ACTION_MANAGE_UNKNOWN_APP_SOURCES,Uri.parse("package:"..activity.getPackageName())))
    activity.requestPermissions({"android.permission.READ_EXTERNAL_STORAGE","android.permission.WRITE_EXTERNAL_STORAGE"},1)
  end
end