<?php   
$uk = '3239637208';//把uk码改成你自己的   
$url = 'http://pan.baidu.com/share/link?shareid=' . $_GET['shareid'] . '&uk='. $uk;    
$src = file_get_contents($url);//获取下载页面源码   
$pattern = '/<a class="new-dbtn"(.*?)href=(.*?) id="downFileButtom">/is';//匹配下载按钮   
preg_match_all($pattern, $src, $result);   
$tempurl = implode("", $result[2]);//各种转换   
$fileurlt = str_replace("\"", "", $tempurl);//各种替换   
$fileurl = str_replace("&amp;", "&", $fileurlt);   
header("location:$fileurl");//Got it   
?>