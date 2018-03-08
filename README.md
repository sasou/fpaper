# fpaper
****
ppt swf player!
演示地址：https://sasou.github.io/fpaper/  

|Author|sasou|
|---|---
|E-mail|admin@php-gene.com


# fpaper  
* 加载文档：sy_open(swf_id,file_url)；  
* 文档翻页：sy_go(swf_id,type,page)；  
* 取总页数：sy_count(swf_id)； 
* 取当前页：sy_current(swf_id)；  

-----------

```javascript
页面跳转demo：
	<a href="javascript:void(0);" onclick="sy_go('demo1','page',1);">首页</a>  |
	<a href="javascript:void(0);" onclick="sy_go('demo1','pre',0);">上一页</a>  |
	<a href="javascript:void(0);" onclick="sy_go('demo1','next',0);">下一页</a>  |
	<a href="javascript:void(0);" onclick="sy_go('demo1','page',5);">第五页</a>  |
	<a href="javascript:void(0);" onclick="sy_go('demo1','page',sy_count('demo1'));">末页</a>
```
