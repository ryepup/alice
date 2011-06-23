var alice = {};

(function(self){
     self.toggleMove = function(classId, move){
	return $.post('/api/moves', {id:classId,move:move});
     };
     self.toggleStudent = function(classId, student){
	return $.post('/api/attendance', {id:classId,student:student});
     };
     
     self.initClassPage = function(){
	 var classId = $('#class-id');
	 if (classId.length == 0) return false;
	 classId = classId.attr('value');

	 $('#class-attendance input.button').click(
	     function(e){
		 self.toggleStudent(classId, $(this).attr('value'));
	     });
	 $('#class-moves input.button').click(
	     function(e){
		 self.toggleMove(classId, $(this).attr('value'));
	     });

	 return true;
     };

     self.init = function(){
	 $('button,a.button,input.button').button();
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
	 self.initClassPage();
     };
})(alice);

$(document).ready(alice.init);