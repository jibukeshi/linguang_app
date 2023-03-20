--[[**
 * @Name: uri2path.lua
 * @author FusionApp2公测群（QQ）- Long
 * @Date: 2022-01-21 12:00:00
 * @Description: QQ：3357212590
 *
**]]

-- load the "import" module,
-- which is use to import Java class and lua module
require "import"

-- Android base class library
-- if you don't need these, please remove them
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"

-- Inflate the layout for this page
-- activity.setContentView(loadlayout(layout))

-- this page using the provided parameters.
-- args=... 


-- TODO : 如有问题，请检查传入值类型


import "android.content.Intent"
import "android.content.ContentUris"
import "android.provider.MediaStore"
import "android.provider.DocumentsContract"
import "android.net.Uri"
import "android.os.Build"
import "android.os.Environment"
import "android.text.TextUtils"


function uri2path(uri)
  local needToCheckUri=Build.VERSION.SDK_INT>=19
  local selection
  local selectionArgs
  if needToCheckUri && DocumentsContract.isDocumentUri(activity,uri) then
    if isExternalStorageDocument(uri) then
      local docId=DocumentsContract.getDocumentId(uri)
      local split=String(docId).split(":")
      return Environment.externalStorageDirectory.toString().."/"..split[1]
     elseif isDownloadsDocument(uri) then
      if Build.VERSION.SDK_INT>=23 then
        local id
        local cursor
        pcall(function()
          cursor=activity.contentResolver.query(uri,{"_display_name"},nil,nil,nil)
          if cursor && cursor.moveToFirst() then
            local fileName=cursor.getString(0)
            local path=Environment.externalStorageDirectory.toString().."/Download/"..fileName
            if !TextUtils.isEmpty(path)
              return path
            end
          end
        end)
        if cursor then cursor.close() end
        id=String(DocumentsContract.getDocumentId(uri))
        if !TextUtils.isEmpty(id) then
          if id.startsWith("raw:") then
            return id.replaceFirst("raw:","")
          end
          local contentUriPrefixesToTry={
            "content://downloads/public_downloads",
            "content://downloads/my_downloads",
          }
          for _,contentUriPrefix in pairs(contentUriPrefixesToTry) do
            xpcall(function()
              local contentUri=ContentUris.withAppendedId(Uri.parse(contentUriPrefix),Long.valueOf(id))
              return getDataColumn(activity,contentUri,nil,nil)
            end,function()
              return String(uri.path).replaceFirst("^/document/raw:","").replaceFirst("^raw:","")
            end)
          end
        end
       else
        local id=String(DocumentsContract.getDocumentId(uri))
        if id.startsWith("raw:") then
          return id.replaceFirst("raw:", "")
        end
        pcall(function()
          contentUri=ContentUris.withAppendedId(Uri.parse("content://downloads/public_downloads"),Long.valueOf(id))
        end)
        if contentUri then
          return getDataColumn(activity,contentUri,nil,nil)
        end
      end
     elseif isMediaDocument(uri) then
      local docId=DocumentsContract.getDocumentId(uri)
      local split=String(docId).split(":")
      switch split[0]
       case "image"
        uri=MediaStore.Images.Media.EXTERNAL_CONTENT_URI
       case "video"
        uri=MediaStore.Video.Media.EXTERNAL_CONTENT_URI
       case "audio"
        uri=MediaStore.Audio.Media.EXTERNAL_CONTENT_URI
      end
      selection="_id=?"
      selectionArgs={split[1]}
    end
  end
  if String("content").equalsIgnoreCase(uri.scheme) then
    local projection={"_data"}
    local cursor
    local result
    pcall(function()
      cursor=activity.contentResolver.query(uri,projection,selection,selectionArgs,nil)
      local column_index=cursor.getColumnIndexOrThrow("_data")
      if cursor.moveToFirst() then
        result=cursor.getString(column_index)
      end
    end)
    return result
   elseif String("file").equalsIgnoreCase(uri.scheme)
    return uri.path
  end
end
function isExternalStorageDocument(uri)
  return uri.authority=="com.android.externalstorage.documents"
end
function isDownloadsDocument(uri)
  return uri.authority=="com.android.providers.downloads.documents"
end
function isMediaDocument(uri)
  return uri.authority=="com.android.providers.media.documents"
end

