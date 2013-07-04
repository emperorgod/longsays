<!---
         )               (   
        / \  .-"""""-.  / \ 
       (   \/ __   __ \/   )   
        )  ; / _\ /_ \ ;  (
       (   |  / \ / \  |   )   
        \ (,  \●/_●/  ,) 
         \_|   /   \   |_/              八戒你在干什么？
           | (_\___/_) |                          是不是又在偷看？
           .\ \ -.- / /.                                 为师是怎么教你的？
          {  \ `===' /  }                                        版权没有_翻版不究！
         {    `.___.'    }                       http://www.longsays.com/
          {             }                                       龙语视觉
           `"="="="="="`
--->
<?php    
$url = 'http://pan.baidu.com/share/link?shareid=' . $_GET['shareid'] . '&uk='. $_GET["uk"];    
$src = file_get_contents($url);//获取下载页面源码   
$pattern = '/<a class="new-dbtn"(.*?)href=(.*?) id="downFileButtom">/is';//匹配下载按钮   
preg_match_all($pattern, $src, $result);   
$tempurl = implode("", $result[2]);//各种转换   
$fileurlt = str_replace("\"", "", $tempurl);//各种替换   
$fileurl = str_replace("&amp;", "&", $fileurlt);   
header("location:$fileurl");//Got it   
?>
<html lang="zh-CN">
<head>
<meta charset="UTF-8" />
<title>龙语视觉 by longsays.com</title>
</head>
<body>
<div align="center">
<strong>欢迎来到龙语视觉！</strong>
<br />
Welcome to Shen Ai’s blog
<p>
<script async src="http://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
<ins class="adsbygoogle"
     style="display:inline-block;width:468px;height:60px"
     data-ad-client="ca-pub-4162962838193717"
     data-ad-slot="7400634216"></ins>
<script>
(adsbygoogle = window.adsbygoogle || []).push({});
</script>
<br />
<script async src="http://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
<ins class="adsbygoogle"
     style="display:inline-block;width:728px;height:90px"
     data-ad-client="ca-pub-4162962838193717"
     data-ad-slot="3338933567"></ins>
<script>
(adsbygoogle = window.adsbygoogle || []).push({});
</script>
</div>
</body>
</html>
