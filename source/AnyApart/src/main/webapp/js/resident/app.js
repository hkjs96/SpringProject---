var gnb = {
	init : function(){
		this.action();
	},
	action : function(){
		var a = $('#header');
		var gnb = a.find('.gnb');
		var pos = [78,78];
		var spd = 500;
		var ani = 'easeInOutExpo';

		gnb.on('mouseenter',function(){
			a.animate({'height':pos[1]},spd,ani);
		});
		a.on('mouseleave',function(){
			a.stop(true).animate({'height':pos[0]},spd,ani);
		});
	}
}
$(document).ready(function(){
	gnb.init();

});

if (typeof console === "undefined" || console === null) {
    console = {
      log: function() {}
    };
  }

var APP = APP || {};

APP.register = function(ns_name){
    var parts = ns_name.split('.'),
    parent = APP;    
    for(var i = 0; i < parts.length; i += 1){
        if(typeof parent[parts[i]] === "undefined"){
               parent[parts[i]] = {};
        }
        parent = parent[parts[i]];
    }
    return parent;
};




var browser = navigator.userAgent;
if(browser.toLowerCase().indexOf("msie 8")>0 || browser.toLowerCase().indexOf("msie 7")>0 ){
    APP.isAlphaTween = false;
}


(function(ns, $,undefined){    
    ns.register('gnb');        
    ns.gnb = function(){
        
               
        var _init = function(depth1, depth2){
            var i, max;
            setDepth1 = depth1;
            setDepth2 = depth2;
            element = $('nav>.gnb');
            depth1Arr = element.find('> li > a');       
            depth1TotalNum = depth1Arr.length;    
            depth2ConArr = element.find('>li> ul'); 
            depth2ConArr.css('height', 0);

            depth1Arr.on('mouseenter focusin mouseleave focusout', depth1Handler);      
            for(i = 0, max = depth2ConArr.length; i<max; i++){        
                depth2Arr[i] =  $(depth2ConArr[i]).find('> li > a');
                depth2Arr[i].on('mouseenter focusin mouseleave focusout', depth2Handler);
               
            } 
            reSetMenu();      
        };
          
        var depth1Handler = function(e){
            var num = $(e.currentTarget).parent().attr('class').slice(4);
            switch ( e.type ) {
                case 'mouseenter':                        
                case 'focusin':
                   stopTimer();
                    depth1Over(num); 
                    viewDepth2(num); 
                    break;
                case 'focusout':
                case 'mouseleave':
                    startTimer();                    
                    break;    
            }
        };        
        
               

        var viewDepth2 = function(num){   
            var margin = 10;
            if(!$.isNumeric(num)){
                 TweenLite.to($(depth2ConArr), 0.5, {css:{height:0}, ease:Cubic.easeOut}); 
                return;
               
            }
            if($(element).find('.menu'+num+'> ul>li').length  <= 0 ){
                    margin = 0
            } 
             TweenLite.to($(element).find('>li> ul'), 0.5, {css:{height:0}, ease:Cubic.easeOut});
            TweenLite.to($(element).find('.menu'+num+'> ul'), 0.5, {css:{height:$(element).find('.menu'+num+'> ul>li').length * 37 + margin}, ease:Cubic.easeOut});  
            
                 
        }
           
   
         
        
        var reSetMenu = function(){ 
            TweenLite.to(depth1Arr, 0.3, {className:'-=on'});            
            TweenLite.to($(element).find('.menu'+setDepth1+'> a'), 0.3, {className:'+=on'});   
            viewDepth2(setDepth1); 
            if(setDepth2 ){
                $(element).find('.menu'+setDepth1+'> ul>.sub'+setDepth2+'>a').trigger('mouseenter');
            }
           
        };       
        
        return{
          init:_init
          
        };
    }();   
    
    ns.register('main');        
    ns.main = function(){
        var thisV, bgImg, bgCon, menuCon,rightMenu, current, menuBox, arrowCon, menuTxtCon, menuTnum=2, leady=true, reSetBgTimer, playBtn, isPlay=true, conVis, r_con, r_banner;
        var vTimer, timerObj ={value:0}, v_menu_circle, r, c;
        function Main(_name){
             this.name = _name;  
             thisV = this;
        }               
        Main.prototype.init = function(){    
            bgCon = $('.visual_con');
            bgImg = bgCon.find('> li');
            $(bgImg).css('opacity', '0'); 
            conVis = $('.main_visual')    
            r_con = $('.main_right_con');
            r_banner = $('.premium_con').find('a');   
            menuCon = $('.menu_con').find('>li');   
            menuBox = $('.menu_con')           
            v_menu_circle = $('.menu_con >li #bar');

            menuCon.on('click', function(e){   
                var num = Number($(e.currentTarget).index()); 
                menuSelect(num);

            });

                      
 
            
            $(window).resize(resize);
            resize();
            setTimeout(resize, 500);
            setTimeout(resize, 600);
            setTimeout(resize, 700);

          

            vTimer = new TweenMax(timerObj, 5, {value:10, onUpdate:updateHandler, ease:Linear.easeNone, repeat:0, onComplete:completeHandler})
            //vTimer.pause();
            vTimer.play();
            function updateHandler(e) {
                var per = vTimer.progress()*400;
                vTimerHandler(per)         
            }
            function completeHandler() {
                
                var num = menuTnum;
                num++;
                if(num>=3){
                    num = 0;
                }
                menuSelect(num)
            }
            menuSelect(0)
       };

       var vTimerHandler = function(per){
            var pct = ((100-per)/100)*c;
            $(v_menu_circle[menuTnum]).css({ strokeDashoffset: pct});
        }
      
       
        var menuSelect = function(num){
            var posX, posY;
            if(num == menuTnum)return;
            if(!leady)return;
            leady = false;
            $(r_banner[num]).trigger('click')
            $(menuCon).removeClass('on')
            $(menuCon).eq(num).addClass('on')
            $(v_menu_circle).css({ strokeDashoffset: 210});
           // menuOver(menuTnum);

            $(bgImg[num]).css({'display':'block'})

            TweenMax.to($(bgImg[num]), 0.5, {css:{opacity:1}});                    
                               
            TweenMax.to($(bgImg[menuTnum]),  0.5, {css:{opacity:0}});
            TweenMax.set($(bgImg[num]).find('.txt'), {opacity:0, y:0, x:0,})
            TweenMax.to($(bgImg[num]).find('.txt_1'), 1.5, {opacity:1, x:-50, delay:1, ease:Cubic.easeOut});  
            TweenMax.to($(bgImg[num]).find('.txt_2'), 1.5, {opacity:1, x:-50, delay:1.5, ease:Cubic.easeOut});    
            TweenMax.to($(bgImg[num]).find('.txt_3'), 1.5, {opacity:1, y:50, delay:1, ease:Cubic.easeOut});    
			TweenMax.to($(bgImg[num]).find('.txt_4'), 1.5, {opacity:1, y:0, delay:1.5, ease:Cubic.easeOut}); 
              
            menuTnum = num;  
            TweenMax.delayedCall(0.5, function(){leady = true;})
            vTimer.seek(0);
                vTimer.play();
           // startBgTimer();
        };

       
        var startBgTimer = function(){
            if(!isPlay)return;
            stopBgTimer();
            reSetBgTimer = setTimeout (function(){
                var reNum = Number(menuTnum)+1;
                if(reNum >= 3)reNum = 0;
                
                menuSelect(reNum);
            }, 5000 );
        };
        var stopBgTimer = function(){
            clearTimeout( reSetBgTimer );
        };
        var menuOver = function(num){
            // for(var i=0; i < 4; i++){
            //     if(num == i){
            //         TweenMax.to($(menuCon[num]), 0.3, {className:'+=on'});

            //     }else{
            //         TweenMax.to($(menuCon[i]), 0.3, {className:'-=on'});
            //     }
            // };
        };
        var resize = function(){
            var w = $(window).width();
            var h = $(window).height() -0;
           
            if(h = 1000)h = 1000;
            conVis.css('height', h);
            //r_con.css('height', h);
             /*
            if(h<840){
                $('.news_con ul li').eq(3).css('display', 'none')
            }else{
                $('.news_con ul li').eq(3).css('display', 'block')
            }
            */
       }
        return new Main('main');
    }();

    ns.register('right');        
    ns.right = function(){
        var rEle, lEleWidth, rEleWidth, conEle, wrap, conVi, contentsWrap, r_btn, is_open = false;
        function Right(_name){
             this.name = _name;  
             thisV = this;
        }               
        Right.prototype.init = function(){   
            rEle = $('.right');
            r_btn = $('.r_btn');
            lEleWidth = $('header').width();
            rEleWidth = $('.right_main').width();  
            conEle = $('.container_con');
            contentsWrap = $('.contents_wrap');
            wrap = $('#wrap');
            r_btn.on('click', r_open)
            $(window).resize(resize);
            resize();
            setTimeout(resize, 200);
            setTimeout(resize, 400);
            setTimeout(resize, 500);

           
            TweenLite.to($('#wrap'), 0.3, {opacity:1})
            $('.con_2 .video').on('mouseenter focusin mouseleave focusout', videoBtn);

            $('.r_pop_view_1').on('click', viewRpop1);
            $('.r_pop_view_2').on('click', viewRpop2);
            $('.right_pop_close').on('click', hideRpop);

        };
        var viewRpop1 = function(){
            $('.right_pop').css('display', 'block')
            $('.right_pop .r_pop_1').css('display', 'block')
            TweenLite.from($('.right_pop .inner'), 0.5, {'autoAlpha':0, ease:Cubic.easeOut})
            
        }
         var viewRpop2 = function(){
            $('.right_pop').css('display', 'block')
            $('.right_pop .r_pop_2').css('display', 'block')
            TweenLite.from($('.right_pop .inner'), 0.5, {'autoAlpha':0, ease:Cubic.easeOut})
            
        }
        var hideRpop = function(){
             $('.right_pop .inner >img').css('display', 'none')
            $('.right_pop').css('display', 'none')
            
        }
        var videoBtn = function(e){
            console.log();
            switch ( e.type ) {
                case 'mouseenter':                        
                case 'focusin':
                    $('.con_2 .video #video')[0].play();
                    break;
                case 'focusout':
                case 'mouseleave':
                     $('.con_2 .video #video')[0].pause(); 
                     $('.con_2 .video #video')[0].currentTime = 0;       
                      $('.con_2 .video #video')[0].load(); 
                    break;    
            }
        }
        var r_open = function(){
            if(is_open){
               // $(rEle).removeClass('on');
                TweenLite.to($(rEle), 0.5, {className:'-=on', ease:Cubic.easeOut})
                $(r_btn).removeClass('close')
                is_open = false;
            }else{
                //$(rEle).addClass('on');
                 TweenLite.to($(rEle), 0.5, {className:'+=on', ease:Cubic.easeOut})
                $(r_btn).addClass('close')
                is_open = true;
            }
           
        }
        var resize = function(){

            var w = $(window).width();
            var h = $(window).height()-0;
            var cW; //= w - lEleWidth;
            /*
            if(w < 1700 ){
                TweenLite.to($(rEle), 0, {x:440}); 
                TweenLite.to($(r_btn), 0.5, {css:{left:-40}}); 
                $(r_btn).removeClass('close')
                is_open = false; 
                cW += rEleWidth;
            }else{
                TweenLite.to($(rEle), 0, {x:0}); 
                TweenLite.to($(r_btn), 0.5, {css:{left:0}}); 
                 $(r_btn).addClass('close')
                is_open = true;
            }
            */
            if(w > 1700){
                cW = w - lEleWidth - 340;
                
            }else{
                cW =  w - lEleWidth;
                 conEle.css({'width': 1100}); 
            }
            if(cW < 1100)cW = 1100;
            conEle.css('width', cW)
            if(h < 1000)h = 1000;
           // console.log($('.contents_wrap').outerHeight(), $('.container_con').outerHeight()
            if($('#wrap').hasClass('sub')){
                h =  Math.max(h, $('.contents_wrap').outerHeight()+190);
                conEle.css('height', h);
            }else{
                $('.layer_con').css('width', cW)
            }
            wrap.css('height', h+145);
            //conVis.css('height', h)
            //resize();
            

       }
      
        return new Right('right');
    }();
    ns.register('premiumMain');        
    ns.premiumMain = function(){
       var thisV, bgImg, bgCon, menuCon, menuTxtCon, menuTnum = 0, menuTotal, playBtn, isPlay=true, mainControll;
        function PremiumMain(_name){
             this.name = _name;  
             thisV = this;
        }               
        PremiumMain.prototype.init = function(){   
            bgCon = $('.premium_con .contents_con');
            bgImg = bgCon.find('> li');
            mainControll = $('.main_visual .menu_con>li');
            menuTotal = bgImg.length; 

            menuCon = $('.premium_con').find('a');             
            menuCon.on('mouseenter focusin mouseleave focusout click', menuHandler);

            menuSelect(menuTnum);
           // menuOver(menuTnum);
        };
        var menuHandler = function(e){
            e.preventDefault();
            var num = $(e.currentTarget).parent().index();

            switch ( e.type ) {
                case 'mouseenter':                        
                case 'focusin':                    
                   // stopBgTimer();
                    break;
                case 'focusout':
                case 'mouseleave': 
                   // startBgTimer();
                    break; 
                case 'click':
                                 
                    menuSelect(num);
                    break;  
            }
        };
        var menuSelect = function(num){
            menuTnum = num;
            // menuOver(menuTnum);  
            $(bgImg[num]).css({'display':'block'})
            $(mainControll[num]).trigger('click');
            for(var i=0; i<menuTotal; i++){
                if(num==i){
                    $(bgImg[num]).addClass('on');

                } else{
                     $(bgImg[i]).removeClass('on');
                }
            };
            
        };
       
      
        return new PremiumMain();
    }();

    ns.register('premium');        
    ns.premium = function(){
       var thisV, bgImg, bgCon, menuCon, menuTxtCon, menuTnum = 0, menuTotal, leady=true, reSetBgTimer, playBtn, isPlay=true;
        function Premium(_name){
             this.name = _name;  
             thisV = this;
        }               
        Premium.prototype.init = function(){   
            bgCon = $('.premium_con .contents_con');
            bgImg = bgCon.find('> li');
            menuTotal = bgImg.length; 
            
            menuCon = $('.premium_con').find('a');                        
            menuCon.on('mouseenter focusin mouseleave focusout click', menuHandler);

            menuSelect(menuTnum);
            startBgTimer();
        };
        var menuHandler = function(e){
            e.preventDefault();
            var num = $(e.currentTarget).parent().index();

            switch ( e.type ) {
                case 'mouseenter':                        
                case 'focusin':                    
                    stopBgTimer();
                    break;
                case 'focusout':
                case 'mouseleave': 
                    startBgTimer();
                    break; 
                case 'click':
                                 
                    menuSelect(num);
                    break;  
            }
        };
        var menuSelect = function(num){
            if(!leady)return;
            leady = false;
            menuTnum = num;  
            $(bgImg[num]).css({'display':'block'})

			for(var i=0; i<menuTotal; i++){
				if(num==i){
					$(bgImg[num]).addClass('on');

				} else{
					 $(bgImg[i]).removeClass('on');
				}
			};
            
           
            TweenMax.delayedCall(0.5, function(){leady = true;})
            startBgTimer();
        };
        var startBgTimer = function(){
            if(!isPlay)return;
            stopBgTimer();
            reSetBgTimer = setTimeout (function(){
                var reNum = Number(menuTnum)+1;
                if(reNum >= menuTotal)reNum = 0;
                
                menuSelect(reNum);
            }, 5000 );
        };
        var stopBgTimer = function(){
            clearTimeout( reSetBgTimer );
        };        
       
        return new Premium();
    }();
           
    

    
}(APP || {}, jQuery));

/*
 * jQuery FlexSlider v2.5.0
 * Copyright 2012 WooThemes
 * Contributing Author: Tyler Smith
 */!function($){$.flexslider=function(e,t){var a=$(e);a.vars=$.extend({},$.flexslider.defaults,t);var n=a.vars.namespace,i=window.navigator&&window.navigator.msPointerEnabled&&window.MSGesture,s=("ontouchstart"in window||i||window.DocumentTouch&&document instanceof DocumentTouch)&&a.vars.touch,r="click touchend MSPointerUp keyup",o="",l,c="vertical"===a.vars.direction,d=a.vars.reverse,u=a.vars.itemWidth>0,v="fade"===a.vars.animation,p=""!==a.vars.asNavFor,m={},f=!0;$.data(e,"flexslider",a),m={init:function(){a.animating=!1,a.currentSlide=parseInt(a.vars.startAt?a.vars.startAt:0,10),isNaN(a.currentSlide)&&(a.currentSlide=0),a.animatingTo=a.currentSlide,a.atEnd=0===a.currentSlide||a.currentSlide===a.last,a.containerSelector=a.vars.selector.substr(0,a.vars.selector.search(" ")),a.slides=$(a.vars.selector,a),a.container=$(a.containerSelector,a),a.count=a.slides.length,a.syncExists=$(a.vars.sync).length>0,"slide"===a.vars.animation&&(a.vars.animation="swing"),a.prop=c?"top":"marginLeft",a.args={},a.manualPause=!1,a.stopped=!1,a.started=!1,a.startTimeout=null,a.transitions=!a.vars.video&&!v&&a.vars.useCSS&&function(){var e=document.createElement("div"),t=["perspectiveProperty","WebkitPerspective","MozPerspective","OPerspective","msPerspective"];for(var n in t)if(void 0!==e.style[t[n]])return a.pfx=t[n].replace("Perspective","").toLowerCase(),a.prop="-"+a.pfx+"-transform",!0;return!1}(),a.ensureAnimationEnd="",""!==a.vars.controlsContainer&&(a.controlsContainer=$(a.vars.controlsContainer).length>0&&$(a.vars.controlsContainer)),""!==a.vars.manualControls&&(a.manualControls=$(a.vars.manualControls).length>0&&$(a.vars.manualControls)),""!==a.vars.customDirectionNav&&(a.customDirectionNav=2===$(a.vars.customDirectionNav).length&&$(a.vars.customDirectionNav)),a.vars.randomize&&(a.slides.sort(function(){return Math.round(Math.random())-.5}),a.container.empty().append(a.slides)),a.doMath(),a.setup("init"),a.vars.controlNav&&m.controlNav.setup(),a.vars.directionNav&&m.directionNav.setup(),a.vars.keyboard&&(1===$(a.containerSelector).length||a.vars.multipleKeyboard)&&$(document).bind("keyup",function(e){var t=e.keyCode;if(!a.animating&&(39===t||37===t)){var n=39===t?a.getTarget("next"):37===t?a.getTarget("prev"):!1;a.flexAnimate(n,a.vars.pauseOnAction)}}),a.vars.mousewheel&&a.bind("mousewheel",function(e,t,n,i){e.preventDefault();var s=a.getTarget(0>t?"next":"prev");a.flexAnimate(s,a.vars.pauseOnAction)}),a.vars.pausePlay&&m.pausePlay.setup(),a.vars.slideshow&&a.vars.pauseInvisible&&m.pauseInvisible.init(),a.vars.slideshow&&(a.vars.pauseOnHover&&a.hover(function(){a.manualPlay||a.manualPause||a.pause()},function(){a.manualPause||a.manualPlay||a.stopped||a.play()}),a.vars.pauseInvisible&&m.pauseInvisible.isHidden()||(a.vars.initDelay>0?a.startTimeout=setTimeout(a.play,a.vars.initDelay):a.play())),p&&m.asNav.setup(),s&&a.vars.touch&&m.touch(),(!v||v&&a.vars.smoothHeight)&&$(window).bind("resize orientationchange focus",m.resize),a.find("img").attr("draggable","false"),setTimeout(function(){a.vars.start(a)},200)},asNav:{setup:function(){a.asNav=!0,a.animatingTo=Math.floor(a.currentSlide/a.move),a.currentItem=a.currentSlide,a.slides.removeClass(n+"active-slide").eq(a.currentItem).addClass(n+"active-slide"),i?(e._slider=a,a.slides.each(function(){var e=this;e._gesture=new MSGesture,e._gesture.target=e,e.addEventListener("MSPointerDown",function(e){e.preventDefault(),e.currentTarget._gesture&&e.currentTarget._gesture.addPointer(e.pointerId)},!1),e.addEventListener("MSGestureTap",function(e){e.preventDefault();var t=$(this),n=t.index();$(a.vars.asNavFor).data("flexslider").animating||t.hasClass("active")||(a.direction=a.currentItem<n?"next":"prev",a.flexAnimate(n,a.vars.pauseOnAction,!1,!0,!0))})})):a.slides.on(r,function(e){e.preventDefault();var t=$(this),i=t.index(),s=t.offset().left-$(a).scrollLeft();0>=s&&t.hasClass(n+"active-slide")?a.flexAnimate(a.getTarget("prev"),!0):$(a.vars.asNavFor).data("flexslider").animating||t.hasClass(n+"active-slide")||(a.direction=a.currentItem<i?"next":"prev",a.flexAnimate(i,a.vars.pauseOnAction,!1,!0,!0))})}},controlNav:{setup:function(){a.manualControls?m.controlNav.setupManual():m.controlNav.setupPaging()},setupPaging:function(){var e="thumbnails"===a.vars.controlNav?"control-thumbs":"control-paging",t=1,i,s;if(a.controlNavScaffold=$('<ol class="'+n+"control-nav "+n+e+'"></ol>'),a.pagingCount>1)for(var l=0;l<a.pagingCount;l++){if(s=a.slides.eq(l),i="thumbnails"===a.vars.controlNav?'<img src="'+s.attr("data-thumb")+'"/>':"<a>"+t+"</a>","thumbnails"===a.vars.controlNav&&!0===a.vars.thumbCaptions){var c=s.attr("data-thumbcaption");""!==c&&void 0!==c&&(i+='<span class="'+n+'caption">'+c+"</span>")}a.controlNavScaffold.append("<li>"+i+"</li>"),t++}a.controlsContainer?$(a.controlsContainer).append(a.controlNavScaffold):a.append(a.controlNavScaffold),m.controlNav.set(),m.controlNav.active(),a.controlNavScaffold.delegate("a, img",r,function(e){if(e.preventDefault(),""===o||o===e.type){var t=$(this),i=a.controlNav.index(t);t.hasClass(n+"active")||(a.direction=i>a.currentSlide?"next":"prev",a.flexAnimate(i,a.vars.pauseOnAction))}""===o&&(o=e.type),m.setToClearWatchedEvent()})},setupManual:function(){a.controlNav=a.manualControls,m.controlNav.active(),a.controlNav.bind(r,function(e){if(e.preventDefault(),""===o||o===e.type){var t=$(this),i=a.controlNav.index(t);t.hasClass(n+"active")||(a.direction=i>a.currentSlide?"next":"prev",a.flexAnimate(i,a.vars.pauseOnAction))}""===o&&(o=e.type),m.setToClearWatchedEvent()})},set:function(){var e="thumbnails"===a.vars.controlNav?"img":"a";a.controlNav=$("."+n+"control-nav li "+e,a.controlsContainer?a.controlsContainer:a)},active:function(){a.controlNav.removeClass(n+"active").eq(a.animatingTo).addClass(n+"active")},update:function(e,t){a.pagingCount>1&&"add"===e?a.controlNavScaffold.append($("<li><a>"+a.count+"</a></li>")):1===a.pagingCount?a.controlNavScaffold.find("li").remove():a.controlNav.eq(t).closest("li").remove(),m.controlNav.set(),a.pagingCount>1&&a.pagingCount!==a.controlNav.length?a.update(t,e):m.controlNav.active()}},directionNav:{setup:function(){var e=$('<ul class="'+n+'direction-nav"><li class="'+n+'nav-prev"><a class="'+n+'prev" href="#">'+a.vars.prevText+'</a></li><li class="'+n+'nav-next"><a class="'+n+'next" href="#">'+a.vars.nextText+"</a></li></ul>");a.customDirectionNav?a.directionNav=a.customDirectionNav:a.controlsContainer?($(a.controlsContainer).append(e),a.directionNav=$("."+n+"direction-nav li a",a.controlsContainer)):(a.append(e),a.directionNav=$("."+n+"direction-nav li a",a)),m.directionNav.update(),a.directionNav.bind(r,function(e){e.preventDefault();var t;(""===o||o===e.type)&&(t=a.getTarget($(this).hasClass(n+"next")?"next":"prev"),a.flexAnimate(t,a.vars.pauseOnAction)),""===o&&(o=e.type),m.setToClearWatchedEvent()})},update:function(){var e=n+"disabled";1===a.pagingCount?a.directionNav.addClass(e).attr("tabindex","-1"):a.vars.animationLoop?a.directionNav.removeClass(e).removeAttr("tabindex"):0===a.animatingTo?a.directionNav.removeClass(e).filter("."+n+"prev").addClass(e).attr("tabindex","-1"):a.animatingTo===a.last?a.directionNav.removeClass(e).filter("."+n+"next").addClass(e).attr("tabindex","-1"):a.directionNav.removeClass(e).removeAttr("tabindex")}},pausePlay:{setup:function(){var e=$('<div class="'+n+'pauseplay"><a></a></div>');a.controlsContainer?(a.controlsContainer.append(e),a.pausePlay=$("."+n+"pauseplay a",a.controlsContainer)):(a.append(e),a.pausePlay=$("."+n+"pauseplay a",a)),m.pausePlay.update(a.vars.slideshow?n+"pause":n+"play"),a.pausePlay.bind(r,function(e){e.preventDefault(),(""===o||o===e.type)&&($(this).hasClass(n+"pause")?(a.manualPause=!0,a.manualPlay=!1,a.pause()):(a.manualPause=!1,a.manualPlay=!0,a.play())),""===o&&(o=e.type),m.setToClearWatchedEvent()})},update:function(e){"play"===e?a.pausePlay.removeClass(n+"pause").addClass(n+"play").html(a.vars.playText):a.pausePlay.removeClass(n+"play").addClass(n+"pause").html(a.vars.pauseText)}},touch:function(){function t(t){t.stopPropagation(),a.animating?t.preventDefault():(a.pause(),e._gesture.addPointer(t.pointerId),w=0,p=c?a.h:a.w,f=Number(new Date),l=u&&d&&a.animatingTo===a.last?0:u&&d?a.limit-(a.itemW+a.vars.itemMargin)*a.move*a.animatingTo:u&&a.currentSlide===a.last?a.limit:u?(a.itemW+a.vars.itemMargin)*a.move*a.currentSlide:d?(a.last-a.currentSlide+a.cloneOffset)*p:(a.currentSlide+a.cloneOffset)*p)}function n(t){t.stopPropagation();var a=t.target._slider;if(a){var n=-t.translationX,i=-t.translationY;return w+=c?i:n,m=w,y=c?Math.abs(w)<Math.abs(-n):Math.abs(w)<Math.abs(-i),t.detail===t.MSGESTURE_FLAG_INERTIA?void setImmediate(function(){e._gesture.stop()}):void((!y||Number(new Date)-f>500)&&(t.preventDefault(),!v&&a.transitions&&(a.vars.animationLoop||(m=w/(0===a.currentSlide&&0>w||a.currentSlide===a.last&&w>0?Math.abs(w)/p+2:1)),a.setProps(l+m,"setTouch"))))}}function s(e){e.stopPropagation();var t=e.target._slider;if(t){if(t.animatingTo===t.currentSlide&&!y&&null!==m){var a=d?-m:m,n=t.getTarget(a>0?"next":"prev");t.canAdvance(n)&&(Number(new Date)-f<550&&Math.abs(a)>50||Math.abs(a)>p/2)?t.flexAnimate(n,t.vars.pauseOnAction):v||t.flexAnimate(t.currentSlide,t.vars.pauseOnAction,!0)}r=null,o=null,m=null,l=null,w=0}}var r,o,l,p,m,f,g,h,S,y=!1,x=0,b=0,w=0;i?(e.style.msTouchAction="none",e._gesture=new MSGesture,e._gesture.target=e,e.addEventListener("MSPointerDown",t,!1),e._slider=a,e.addEventListener("MSGestureChange",n,!1),e.addEventListener("MSGestureEnd",s,!1)):(g=function(t){a.animating?t.preventDefault():(window.navigator.msPointerEnabled||1===t.touches.length)&&(a.pause(),p=c?a.h:a.w,f=Number(new Date),x=t.touches[0].pageX,b=t.touches[0].pageY,l=u&&d&&a.animatingTo===a.last?0:u&&d?a.limit-(a.itemW+a.vars.itemMargin)*a.move*a.animatingTo:u&&a.currentSlide===a.last?a.limit:u?(a.itemW+a.vars.itemMargin)*a.move*a.currentSlide:d?(a.last-a.currentSlide+a.cloneOffset)*p:(a.currentSlide+a.cloneOffset)*p,r=c?b:x,o=c?x:b,e.addEventListener("touchmove",h,!1),e.addEventListener("touchend",S,!1))},h=function(e){x=e.touches[0].pageX,b=e.touches[0].pageY,m=c?r-b:r-x,y=c?Math.abs(m)<Math.abs(x-o):Math.abs(m)<Math.abs(b-o);var t=500;(!y||Number(new Date)-f>t)&&(e.preventDefault(),!v&&a.transitions&&(a.vars.animationLoop||(m/=0===a.currentSlide&&0>m||a.currentSlide===a.last&&m>0?Math.abs(m)/p+2:1),a.setProps(l+m,"setTouch")))},S=function(t){if(e.removeEventListener("touchmove",h,!1),a.animatingTo===a.currentSlide&&!y&&null!==m){var n=d?-m:m,i=a.getTarget(n>0?"next":"prev");a.canAdvance(i)&&(Number(new Date)-f<550&&Math.abs(n)>50||Math.abs(n)>p/2)?a.flexAnimate(i,a.vars.pauseOnAction):v||a.flexAnimate(a.currentSlide,a.vars.pauseOnAction,!0)}e.removeEventListener("touchend",S,!1),r=null,o=null,m=null,l=null},e.addEventListener("touchstart",g,!1))},resize:function(){!a.animating&&a.is(":visible")&&(u||a.doMath(),v?m.smoothHeight():u?(a.slides.width(a.computedW),a.update(a.pagingCount),a.setProps()):c?(a.viewport.height(a.h),a.setProps(a.h,"setTotal")):(a.vars.smoothHeight&&m.smoothHeight(),a.newSlides.width(a.computedW),a.setProps(a.computedW,"setTotal")))},smoothHeight:function(e){if(!c||v){var t=v?a:a.viewport;e?t.animate({height:a.slides.eq(a.animatingTo).height()},e):t.height(a.slides.eq(a.animatingTo).height())}},sync:function(e){var t=$(a.vars.sync).data("flexslider"),n=a.animatingTo;switch(e){case"animate":t.flexAnimate(n,a.vars.pauseOnAction,!1,!0);break;case"play":t.playing||t.asNav||t.play();break;case"pause":t.pause()}},uniqueID:function(e){return e.filter("[id]").add(e.find("[id]")).each(function(){var e=$(this);e.attr("id",e.attr("id")+"_clone")}),e},pauseInvisible:{visProp:null,init:function(){var e=m.pauseInvisible.getHiddenProp();if(e){var t=e.replace(/[H|h]idden/,"")+"visibilitychange";document.addEventListener(t,function(){m.pauseInvisible.isHidden()?a.startTimeout?clearTimeout(a.startTimeout):a.pause():a.started?a.play():a.vars.initDelay>0?setTimeout(a.play,a.vars.initDelay):a.play()})}},isHidden:function(){var e=m.pauseInvisible.getHiddenProp();return e?document[e]:!1},getHiddenProp:function(){var e=["webkit","moz","ms","o"];if("hidden"in document)return"hidden";for(var t=0;t<e.length;t++)if(e[t]+"Hidden"in document)return e[t]+"Hidden";return null}},setToClearWatchedEvent:function(){clearTimeout(l),l=setTimeout(function(){o=""},3e3)}},a.flexAnimate=function(e,t,i,r,o){if(a.vars.animationLoop||e===a.currentSlide||(a.direction=e>a.currentSlide?"next":"prev"),p&&1===a.pagingCount&&(a.direction=a.currentItem<e?"next":"prev"),!a.animating&&(a.canAdvance(e,o)||i)&&a.is(":visible")){if(p&&r){var l=$(a.vars.asNavFor).data("flexslider");if(a.atEnd=0===e||e===a.count-1,l.flexAnimate(e,!0,!1,!0,o),a.direction=a.currentItem<e?"next":"prev",l.direction=a.direction,Math.ceil((e+1)/a.visible)-1===a.currentSlide||0===e)return a.currentItem=e,a.slides.removeClass(n+"active-slide").eq(e).addClass(n+"active-slide"),!1;a.currentItem=e,a.slides.removeClass(n+"active-slide").eq(e).addClass(n+"active-slide"),e=Math.floor(e/a.visible)}if(a.animating=!0,a.animatingTo=e,t&&a.pause(),a.vars.before(a),a.syncExists&&!o&&m.sync("animate"),a.vars.controlNav&&m.controlNav.active(),u||a.slides.removeClass(n+"active-slide").eq(e).addClass(n+"active-slide"),a.atEnd=0===e||e===a.last,a.vars.directionNav&&m.directionNav.update(),e===a.last&&(a.vars.end(a),a.vars.animationLoop||a.pause()),v)s?(a.slides.eq(a.currentSlide).css({opacity:0,zIndex:1}),a.slides.eq(e).css({opacity:1,zIndex:2}),a.wrapup(f)):(a.slides.eq(a.currentSlide).css({zIndex:1}).animate({opacity:0},a.vars.animationSpeed,a.vars.easing),a.slides.eq(e).css({zIndex:2}).animate({opacity:1},a.vars.animationSpeed,a.vars.easing,a.wrapup));else{var f=c?a.slides.filter(":first").height():a.computedW,g,h,S;u?(g=a.vars.itemMargin,S=(a.itemW+g)*a.move*a.animatingTo,h=S>a.limit&&1!==a.visible?a.limit:S):h=0===a.currentSlide&&e===a.count-1&&a.vars.animationLoop&&"next"!==a.direction?d?(a.count+a.cloneOffset)*f:0:a.currentSlide===a.last&&0===e&&a.vars.animationLoop&&"prev"!==a.direction?d?0:(a.count+1)*f:d?(a.count-1-e+a.cloneOffset)*f:(e+a.cloneOffset)*f,a.setProps(h,"",a.vars.animationSpeed),a.transitions?(a.vars.animationLoop&&a.atEnd||(a.animating=!1,a.currentSlide=a.animatingTo),a.container.unbind("webkitTransitionEnd transitionend"),a.container.bind("webkitTransitionEnd transitionend",function(){clearTimeout(a.ensureAnimationEnd),a.wrapup(f)}),clearTimeout(a.ensureAnimationEnd),a.ensureAnimationEnd=setTimeout(function(){a.wrapup(f)},a.vars.animationSpeed+100)):a.container.animate(a.args,a.vars.animationSpeed,a.vars.easing,function(){a.wrapup(f)})}a.vars.smoothHeight&&m.smoothHeight(a.vars.animationSpeed)}},a.wrapup=function(e){v||u||(0===a.currentSlide&&a.animatingTo===a.last&&a.vars.animationLoop?a.setProps(e,"jumpEnd"):a.currentSlide===a.last&&0===a.animatingTo&&a.vars.animationLoop&&a.setProps(e,"jumpStart")),a.animating=!1,a.currentSlide=a.animatingTo,a.vars.after(a)},a.animateSlides=function(){!a.animating&&f&&a.flexAnimate(a.getTarget("next"))},a.pause=function(){clearInterval(a.animatedSlides),a.animatedSlides=null,a.playing=!1,a.vars.pausePlay&&m.pausePlay.update("play"),a.syncExists&&m.sync("pause")},a.play=function(){a.playing&&clearInterval(a.animatedSlides),a.animatedSlides=a.animatedSlides||setInterval(a.animateSlides,a.vars.slideshowSpeed),a.started=a.playing=!0,a.vars.pausePlay&&m.pausePlay.update("pause"),a.syncExists&&m.sync("play")},a.stop=function(){a.pause(),a.stopped=!0},a.canAdvance=function(e,t){var n=p?a.pagingCount-1:a.last;return t?!0:p&&a.currentItem===a.count-1&&0===e&&"prev"===a.direction?!0:p&&0===a.currentItem&&e===a.pagingCount-1&&"next"!==a.direction?!1:e!==a.currentSlide||p?a.vars.animationLoop?!0:a.atEnd&&0===a.currentSlide&&e===n&&"next"!==a.direction?!1:a.atEnd&&a.currentSlide===n&&0===e&&"next"===a.direction?!1:!0:!1},a.getTarget=function(e){return a.direction=e,"next"===e?a.currentSlide===a.last?0:a.currentSlide+1:0===a.currentSlide?a.last:a.currentSlide-1},a.setProps=function(e,t,n){var i=function(){var n=e?e:(a.itemW+a.vars.itemMargin)*a.move*a.animatingTo,i=function(){if(u)return"setTouch"===t?e:d&&a.animatingTo===a.last?0:d?a.limit-(a.itemW+a.vars.itemMargin)*a.move*a.animatingTo:a.animatingTo===a.last?a.limit:n;switch(t){case"setTotal":return d?(a.count-1-a.currentSlide+a.cloneOffset)*e:(a.currentSlide+a.cloneOffset)*e;case"setTouch":return d?e:e;case"jumpEnd":return d?e:a.count*e;case"jumpStart":return d?a.count*e:e;default:return e}}();return-1*i+"px"}();a.transitions&&(i=c?"translate3d(0,"+i+",0)":"translate3d("+i+",0,0)",n=void 0!==n?n/1e3+"s":"0s",a.container.css("-"+a.pfx+"-transition-duration",n),a.container.css("transition-duration",n)),a.args[a.prop]=i,(a.transitions||void 0===n)&&a.container.css(a.args),a.container.css("transform",i)},a.setup=function(e){if(v)a.slides.css({width:"100%","float":"left",marginRight:"-100%",position:"relative"}),"init"===e&&(s?a.slides.css({opacity:0,display:"block",webkitTransition:"opacity "+a.vars.animationSpeed/1e3+"s ease",zIndex:1}).eq(a.currentSlide).css({opacity:1,zIndex:2}):0==a.vars.fadeFirstSlide?a.slides.css({opacity:0,display:"block",zIndex:1}).eq(a.currentSlide).css({zIndex:2}).css({opacity:1}):a.slides.css({opacity:0,display:"block",zIndex:1}).eq(a.currentSlide).css({zIndex:2}).animate({opacity:1},a.vars.animationSpeed,a.vars.easing)),a.vars.smoothHeight&&m.smoothHeight();else{var t,i;"init"===e&&(a.viewport=$('<div class="'+n+'viewport"></div>').css({overflow:"hidden",position:"relative"}).appendTo(a).append(a.container),a.cloneCount=0,a.cloneOffset=0,d&&(i=$.makeArray(a.slides).reverse(),a.slides=$(i),a.container.empty().append(a.slides))),a.vars.animationLoop&&!u&&(a.cloneCount=2,a.cloneOffset=1,"init"!==e&&a.container.find(".clone").remove(),a.container.append(m.uniqueID(a.slides.first().clone().addClass("clone")).attr("aria-hidden","true")).prepend(m.uniqueID(a.slides.last().clone().addClass("clone")).attr("aria-hidden","true"))),a.newSlides=$(a.vars.selector,a),t=d?a.count-1-a.currentSlide+a.cloneOffset:a.currentSlide+a.cloneOffset,c&&!u?(a.container.height(200*(a.count+a.cloneCount)+"%").css("position","absolute").width("100%"),setTimeout(function(){a.newSlides.css({display:"block"}),a.doMath(),a.viewport.height(a.h),a.setProps(t*a.h,"init")},"init"===e?100:0)):(a.container.width(200*(a.count+a.cloneCount)+"%"),a.setProps(t*a.computedW,"init"),setTimeout(function(){a.doMath(),a.newSlides.css({width:a.computedW,"float":"left",display:"block"}),a.vars.smoothHeight&&m.smoothHeight()},"init"===e?100:0))}u||a.slides.removeClass(n+"active-slide").eq(a.currentSlide).addClass(n+"active-slide"),a.vars.init(a)},a.doMath=function(){var e=a.slides.first(),t=a.vars.itemMargin,n=a.vars.minItems,i=a.vars.maxItems;a.w=void 0===a.viewport?a.width():a.viewport.width(),a.h=e.height(),a.boxPadding=e.outerWidth()-e.width(),u?(a.itemT=a.vars.itemWidth+t,a.minW=n?n*a.itemT:a.w,a.maxW=i?i*a.itemT-t:a.w,a.itemW=a.minW>a.w?(a.w-t*(n-1))/n:a.maxW<a.w?(a.w-t*(i-1))/i:a.vars.itemWidth>a.w?a.w:a.vars.itemWidth,a.visible=Math.floor(a.w/a.itemW),a.move=a.vars.move>0&&a.vars.move<a.visible?a.vars.move:a.visible,a.pagingCount=Math.ceil((a.count-a.visible)/a.move+1),a.last=a.pagingCount-1,a.limit=1===a.pagingCount?0:a.vars.itemWidth>a.w?a.itemW*(a.count-1)+t*(a.count-1):(a.itemW+t)*a.count-a.w-t):(a.itemW=a.w,a.pagingCount=a.count,a.last=a.count-1),a.computedW=a.itemW-a.boxPadding},a.update=function(e,t){a.doMath(),u||(e<a.currentSlide?a.currentSlide+=1:e<=a.currentSlide&&0!==e&&(a.currentSlide-=1),a.animatingTo=a.currentSlide),a.vars.controlNav&&!a.manualControls&&("add"===t&&!u||a.pagingCount>a.controlNav.length?m.controlNav.update("add"):("remove"===t&&!u||a.pagingCount<a.controlNav.length)&&(u&&a.currentSlide>a.last&&(a.currentSlide-=1,a.animatingTo-=1),m.controlNav.update("remove",a.last))),a.vars.directionNav&&m.directionNav.update()},a.addSlide=function(e,t){var n=$(e);a.count+=1,a.last=a.count-1,c&&d?void 0!==t?a.slides.eq(a.count-t).after(n):a.container.prepend(n):void 0!==t?a.slides.eq(t).before(n):a.container.append(n),a.update(t,"add"),a.slides=$(a.vars.selector+":not(.clone)",a),a.setup(),a.vars.added(a)},a.removeSlide=function(e){var t=isNaN(e)?a.slides.index($(e)):e;a.count-=1,a.last=a.count-1,isNaN(e)?$(e,a.slides).remove():c&&d?a.slides.eq(a.last).remove():a.slides.eq(e).remove(),a.doMath(),a.update(t,"remove"),a.slides=$(a.vars.selector+":not(.clone)",a),a.setup(),a.vars.removed(a)},m.init()},$(window).blur(function(e){focused=!1}).focus(function(e){focused=!0}),$.flexslider.defaults={namespace:"flex-",selector:".slides > li",animation:"fade",easing:"swing",direction:"horizontal",reverse:!1,animationLoop:!0,smoothHeight:!1,startAt:0,slideshow:!0,slideshowSpeed:7e3,animationSpeed:600,initDelay:0,randomize:!1,fadeFirstSlide:!0,thumbCaptions:!1,pauseOnAction:!0,pauseOnHover:!1,pauseInvisible:!0,useCSS:!0,touch:!0,video:!1,controlNav:!0,directionNav:!0,prevText:"Previous",nextText:"Next",keyboard:!0,multipleKeyboard:!1,mousewheel:!1,pausePlay:!1,pauseText:"Pause",playText:"Play",controlsContainer:"",manualControls:"",customDirectionNav:"",sync:"",asNavFor:"",itemWidth:0,itemMargin:0,minItems:1,maxItems:0,move:0,allowOneSlide:!0,start:function(){},before:function(){},after:function(){},end:function(){},added:function(){},removed:function(){},init:function(){}},$.fn.flexslider=function(e){if(void 0===e&&(e={}),"object"==typeof e)return this.each(function(){var t=$(this),a=e.selector?e.selector:".slides > li",n=t.find(a);1===n.length&&e.allowOneSlide===!0||0===n.length?(n.fadeIn(400),e.start&&e.start(t)):void 0===t.data("flexslider")&&new $.flexslider(this,e)});var t=$(this).data("flexslider");switch(e){case"play":t.play();break;case"pause":t.pause();break;case"stop":t.stop();break;case"next":t.flexAnimate(t.getTarget("next"),!0);break;case"prev":case"previous":t.flexAnimate(t.getTarget("prev"),!0);break;default:"number"==typeof e&&t.flexAnimate(e,!0)}}}(jQuery);