# fpaper  
ppt swf player!  
演示地址：https://sasou.github.io/fpaper/  

|Author|sasou|
|---|---
|E-mail|admin@php-gene.com


# 简单使用 
## 调用代码
```javascript
	<script>
	    new syPPT({
	        width: 755,
	        height: 650,

	        swf_id: 'demo1',//上传flash元素id
	        file_url: 'fpaper/ppt/2.swf',
	        botton_hidden: 0,
	        skin: 'fpaper/skin/comp'
	    }, 755, 650).show();
    </script>
```

```javascript
	<p>演示例子：</p> 
	<div id="demo1">
		<h1>fpaper</h1>
		<p><a href="http://www.adobe.com/go/getflashplayer">Get Adobe Flash player</a></p>
	</div>
```
## 控制代码
```javascript
	1、加载新的ppt：sy_open(swf_id,file_url)；<br> 
	demo： <a href="javascript:void(0);" onclick="sy_open('demo1','fpaper/ppt/1.swf');">加载</a>
	<br>
	<br>
	2、ppt翻页：sy_go(swf_id,type,page)；<br> 
	demo： 
	<a href="javascript:void(0);" onclick="sy_go('demo1','page',1);">首页</a>  |
	<a href="javascript:void(0);" onclick="sy_go('demo1','pre',0);">上一页</a>  |
	<a href="javascript:void(0);" onclick="sy_go('demo1','next',0);">下一页</a>  |
	<a href="javascript:void(0);" onclick="sy_go('demo1','page',5);">第五页</a>  |
	<a href="javascript:void(0);" onclick="sy_go('demo1','page',sy_count('demo1'));">末页</a>
	<br>
	<br>
	<br>
	3、取总页数：sy_count(swf_id)；<br> 
	demo： 
	<a href="javascript:void(0);" onclick="alert(sy_count('demo1'));">取总页数</a>
	<br>
	<br>
	<br>
	4、取当前页：sy_current(swf_id)；<br> 
	demo： 
	<a href="javascript:void(0);" onclick="alert(sy_current('demo1'));">取当前页</a>
```

## 基本控制接口
* 加载文档：sy_open(swf_id, file_url)；  
* 文档翻页：sy_go(swf_id, type,page)；  
* 取总页数：sy_count(swf_id)； 
* 取当前页：sy_current(swf_id)；  

-----------


使用场景
---------
文档在线预览：本方案是先将文档转换成pdf，然后转换成swf，然后在页面用flash播放swf；
