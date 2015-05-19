/* CHINAACC:NEWFILE */

$(function(){
	$('.tab .navi li').mouseover(function(){
		var selectorName,index;
		selectorName = $(this).parent().parent().attr('class').split(' tab')[0];
		index = $('.' + selectorName +' .navi li').index(this);
		$('.' + selectorName +' .tabInner li').eq(index).show().siblings().hide();
		$('.' + selectorName +' .navi li').eq(index).addClass('on').siblings().removeClass('on');
		$('.' + selectorName +' .tabInner li').eq(index).find('img.lazy').lazyload();
	});
	
	
	/* add for word limit  begin */
	var maxLen = 18;
	$('.productName').each(function() {
		$(this).find('a').html(cutstr($(this).find('a').html(), maxLen));
	});
	function cutstr(str,len){  
		var str_length = 0;  
		var str_len = 0;  
		str_cut = new String();  
		str_len = str.length;  
		for(var i = 0; i < str_len; i++){  
			a = str.charAt(i);  
			str_length++;  
			if(escape(a).length > 4){  
				//�����ַ�ĳ��Ⱦ�����֮�����4  
				str_length++;  
			}  
			str_cut = str_cut.concat(a);  
			if(str_length>=len){  
				str_cut = str_cut.concat("...");  
				return str_cut;  
			}  
		}
		if(str_length < len){  
     		return  str;  
		}   
	}
	/* add for limit word end */

});