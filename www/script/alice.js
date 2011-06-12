var alice = {};

(function(self){
     self.init = function(){
	 $('button,a.button').button();
	 $('div.tabs').tabs();
	 var recenter = function(){
	     $('#body').position(
		 {
		     of:$('body'),
		     my:"center bottom",
		     at:"center center"
		 });	     
	 };
	 recenter();
	 $(window).resize(recenter);

     };
})(alice);

$(document).ready(alice.init);