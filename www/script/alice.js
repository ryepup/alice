var alice = {};

(function(self){
     self.init = function(){
	 $('button').button();
	 
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